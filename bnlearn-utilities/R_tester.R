# Install bnlearn if needed
if (!requireNamespace("bnlearn", quietly = TRUE)) {
  install.packages("bnlearn")
}
library(bnlearn)
source("R_util.R")


# Build sprinkler network manually
dag <- model2network("[cloudy][sprinkler|cloudy][rain|cloudy][wet|rain:sprinkler]")

# Root node cloudy: 2 rows (states), 1 column (no parents)
cpt_cloudy <- matrix(c(0.5, 0.5), nrow = 2, dimnames = list(cloudy = c("true", "false")))

# Sprinkler given cloudy (parent)
# Node sprinkler states as rows, parent cloudy states as columns
cpt_sprinkler <- matrix(
  c(0.5, 0.5, 0.1, 0.9),
  nrow = 2,
  dimnames = list(sprinkler = c("true", "false"), cloudy = c("false", "true"))
)

# Rain given cloudy
cpt_rain <- matrix(
  c(0.2, 0.8, 0.8, 0.2),
  nrow = 2,
  dimnames = list(rain = c("true", "false"), cloudy = c("false", "true"))
)

# Wet given rain and sprinkler
cpt_wet <- array(
  c(0.1, 0.9, 0.9, 0.1, 0.9, 0.1, 0.99, 0.01),
  dim = c(2, 2, 2),
  dimnames = list(
    wet = c("true", "false"),
    rain = c("false", "true"),
    sprinkler = c("false", "true")
  )
)

fit <- custom.fit(dag, dist = list(
  cloudy = cpt_cloudy,
  sprinkler = cpt_sprinkler,
  rain = cpt_rain,
  wet = cpt_wet
  ))

# Export to Logtalk file
bn_to_logtalk(fit, object_name="bn_sprinkler_r", file="bn_sprinkler_r.lgt")

# Print the result
cat(readLines("bn_sprinkler_r.lgt"), sep="\n")
