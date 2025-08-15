bn_to_logtalk <- function(fit, object_name="bn_from_r", file="bn.lgt") {
  stopifnot("bn.fit" %in% class(fit))
  con <- file(file, open="wt")

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
    true_state <- "true"

    if (length(parents) == 0) {
      # Root node, probs is a named vector
      p_true <- as.numeric(probs[true_state])
      writeLines(sprintf("cpt(%s,[],%g).", tolower(n), p_true), con)
    } else {
      # CPT is a table or array with dimensions: node states x parent states
      parent_states <- dimnames(probs)[parents]
      node_states <- dimnames(probs)[[1]]  # first dim = node states

      # Generate all parent assignments
      grid <- expand.grid(parent_states, stringsAsFactors = FALSE)
      for (row_idx in seq_len(nrow(grid))) {
        parent_assignments <- mapply(function(p, v) paste0(tolower(p), "-", tolower(v)),
                                     names(grid), grid[row_idx, ], USE.NAMES = FALSE)

        # Extract probability for 'true' node state given parent assignment
        # Indexing into probs: node state first, then parents in order
        # Build indices vector: index of 'true' state in node states + indices for parent states
        idxs <- c(match(true_state, node_states))
        for (p in parents) {
          idxs <- c(idxs, match(grid[row_idx, p], dimnames(probs)[[p]]))
        }
        # Use do.call to index multi-dimensional array
        p_true <- do.call("[", c(list(probs), as.list(idxs)))

        writeLines(sprintf("cpt(%s,[%s],%g).",
                           tolower(n),
                           paste(parent_assignments, collapse = ","),
                           p_true), con)
      }
    }
  }

  writeLines("", con)
  writeLines(":- end_object.", con)
  close(con)
}

