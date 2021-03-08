######################
#   One dimension    #
######################
# Creation
## a, vector of integers with 10 elements randomly from 1-20.
set.seed(10)
a <- sample(1:20, 10)
names(a) <- paste0('V', 1:10)
a
names(a) <- paste('V', 1:10, sep = '')
a

## b, random from letters
set.seed(10)
b <- sample(letters, 10)
b
letters[a]

## d, 10 random number from normal distribution with mean 100 and sd 20
set.seed(12)
d <- rnorm(10, mean = 100, sd = 20)
d

## l, a list made by a, b and d
l <- list(a = a, b = b, d = d)
l

# Indexing, subsetting, and replacing
## a
a[c(1, 2, 10)]
a[c(paste0('V', 1:3))]
a[2:length(a)] <- "sasquatch"
a

## b
b[b %in% c('c', 'd', 'e')]
which(b %in% c('c', 'd', 'e'))

## d
d[1:5] * d[-5:-1]
d[d > 100]
length(d[d > 100])
## or
sum(d > 100)
d[d > 95 & d < 105] <- 100
d

## from l
### 1
l$a[c(1, 2, 10)]

### 3
l$a[2:length(l$a)] <- "sasquatch"
l

### 4
l$b[l$b %in% c('c', 'd', 'e')]

### 8
l$d[l$d > 95 & l$d < 105] <- 100

######################
#    Two dimension   #
######################
# creation
## m
V1 <- 1:10
set.seed(50)
V2 <- sample(1:100, 10)
set.seed(50)
V3 <- runif(10, 0, 50)
m <- cbind(V1 = V1, V2 = V2, V3 = V3)
m
str(m)
class(m)

## dat
set.seed(50)
V4 <- sample(LETTERS, 10)
dat <- data.frame(m, V4 = V4)
# or
dat <- data.frame(V1 = V1, V2 = V2, V3 = V3, V4 = V4)
dat

# Indexing/subsetting/replacing
## m
m[1:10]

m[length(m)]

m[length(m)] <- -99
m

m[3, 1:2] <- m[3, 1:2] * 10
m

m[3, c('V1', 'V2')] <- m[3, c('V1', 'V2')] / 10
m

dat$V3^2
# or
dat[['V3']]^2
# or
dat[, 'V3']^2

datss <- dat[1:2, 1:2]
datss

dat[1:2, 1:2] <- -1:-4
dat

dat[1:2, 1:2] <- datss
dat

######################
#      Summary       #
######################
rowMeans(m)
colMeans(m)
rowMeans(select_if(daBet, is.numeric))
colMeans(select_if(dat, is.numeric))

mean(m)
sum(m)
mean(rowMeans(select_if(dat, is.numeric)))
sum(rowSums(select_if(dat, is.numeric)))
# or for dat
mean(unlist(select_if(dat, is.numeric)))
sum(unlist(select_if(dat, is.numeric)))
# or for dat
mean(as.matrix(select_if(dat, is.numeric)))
sum(as.matrix(select_if(dat, is.numeric)))

aggregate(select_if(dat, is.numeric),
          by = list(dat$V4),
          FUN = mean)
dat %>% group_by(V4) %>%
  summarise_at(vars(V1, V2, V3),
               list(avg = mean))
