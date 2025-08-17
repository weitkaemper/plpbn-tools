library(bnlearn)

normalize_state <- function(x) {
    tolower(as.character(as.logical(x)))
}


bn_to_logtalk <- function(fit, object_name="bn_from_r", file="bn.lgt") {
  stopifnot("bn.fit" %in% class(fit))
  
  # Helper: normalize any value to "true" / "false"
  
  con <- file(file, open="wt")
  on.exit(close(con))
  
  # Write object header
  writeLines(sprintf(":- object(%s, implements(bnp)).", object_name), con)
  writeLines("", con)
  
  # Nodes
  for (n in nodes(fit)) {
    writeLines(sprintf("node(%s).", tolower(n)), con)
  }
  writeLines("", con)
  
  # Edges
  arcs_mat <- arcs(fit)
  for (i in seq_len(nrow(arcs_mat))) {
    from <- tolower(arcs_mat[i, "from"])
    to <- tolower(arcs_mat[i, "to"])
    writeLines(sprintf("edge(%s,%s).", from, to), con)
  }
  writeLines("", con)
  
  # CPTs
  for (n in nodes(fit)) {
    parents <- fit[[n]]$parents
    probs <- fit[[n]]$prob
    
    node_states <- dimnames(probs)[[1]]
    true_idx <- which(normalize_state(node_states) == "true")
    if (length(true_idx) != 1) {
      stop(sprintf("Node %s: could not determine a unique 'true' state", n))
    }
    
    if (length(parents) == 0) {
      # Root node: probs is a named vector
      p_true <- as.numeric(probs[true_idx, 1])
      writeLines(sprintf("cpt(%s,[],%g).", tolower(n), p_true), con)
    } else {
      # Node with parents: probs is a table/array
      parent_states <- dimnames(probs)[parents]
      grid <- expand.grid(parent_states, stringsAsFactors = FALSE)
      
      for (row_idx in seq_len(nrow(grid))) {
        # Parent assignments
        parent_assignments <- mapply(
          function(p, v) paste0(tolower(p), "-", normalize_state(v)),
          names(grid), grid[row_idx, ], USE.NAMES = FALSE
        )
        
        # Build index vector for multi-dimensional array
        idxs <- c(true_idx)
        for (p in parents) {
          idxs <- c(idxs, match(grid[row_idx, p], dimnames(probs)[[p]]))
        }
        
        # Extract probability of 'true' state
        p_true <- do.call("[", c(list(probs), as.list(idxs)))
        writeLines(
          sprintf("cpt(%s,[%s],%g).",
                  tolower(n),
                  paste(parent_assignments, collapse = ","),
                  p_true),
          con
        )
      }
    }
  }
  
  # Footer
  writeLines("", con)
  writeLines(":- end_object.", con)
  invisible(NULL)
}
