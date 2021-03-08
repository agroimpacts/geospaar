####################
#      Task 1      #
####################
set.seed(10)
m <- cbind(a = 16:11, b = sample(1:100, 6))
m
apply(m, 1, mean)
apply(m, 2, sort)
deri <- function(x) log10(x) - 5
apply(m, 1, deri) # as we can see, the result is transposed.

####################
#      Task 2      #
####################
set.seed(12)
l <- list(a = matrix(sample(2:50, 6), nrow = 2),
          b = data.frame(m = runif(10, 0, 10),
                         n = rnorm(10, mean = 3, sd = 1)))
lapply(l, sum)
sapply(l, sum)

sapply(l, is.matrix)

lapply(l, colMeans)
