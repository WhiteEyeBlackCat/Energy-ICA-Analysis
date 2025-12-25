df <- read.csv("D:/project/statistic method final/data/log_return.csv")
library(SparseICA)

time_idx <- df$Time
df <- df[, sapply(df, is.numeric), drop = FALSE]

df <- na.omit(df)  # remove missing values


# Sparse ICA expects input in P x T format
# P: number of features (variables)
# T: number of time points

# Original df is T x P (rows = time, columns = variables)
x <- t(as.matrix(df))
storage.mode(x) <- "double"

set.seed(0)

fit <- sparseICA(
  xData = x,
  n.comp = 8,          # number of independent components
  nu = "BIC",          # select sparsity level using a BIC-like criterion
  nu_list = seq(0.1, 4, 0.1),
  method = "C",        # use C / Rcpp implementation for faster computation
  restarts = 40,       # multiple random initializations to avoid poor local minima
  verbose = TRUE,
  converge_plot = FALSE
)


S <- fit$estS   # P x Q: loading matrix (features x components)
M <- fit$estM   # Q x T: component time courses
S

# Identify the most influential variables for each IC
rownames(S) <- colnames(df)          # assign variable names (from df columns)
colnames(S) <- paste0("IC", 1:ncol(S))

top_k <- function(v, k = 5){
  ord <- order(abs(v), decreasing = TRUE)
  data.frame(var = names(v)[ord][1:k], loading = v[ord][1:k])
}

apply(S, 2, \(v) top_k(setNames(v, rownames(S)), 5))


# ===== component time courses =====
ic_colors <- rainbow(8)
matplot(t(M), type = "l", lty = 1, col = ic_colors,
        xlab = "t (time index)", ylab = "IC score",
        main = "SparseICA: component time courses")
legend("topright", legend = colnames(S),
       col = ic_colors, lty = 1, lwd = 2, cex = 0.8)

# Proportion of near-zero loadings (sparsity measure)
apply(S, 2, \(v) mean(abs(v) < 1e-3))
