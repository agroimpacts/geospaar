# indexing
## vectors
### Use positive number
# In R, index start from 1.
x <- 1:10; x
x[1]
x[2]
x[4]
x[4] <- 12
x

# be careful when the index is out of bound
x0 <- x[0]; x0 # give you a vector with length 0
x11 <- x[11]; x11 # give you an NA instead of an error.
x[length(x)] # Always let the machine do the counting.

x[c(1, 4)]
x[1:4]
x[c(1, 1)]
x[c(1.2, 3.6)] # truncated double to integer, not recommended

#### We also could use negative number to exclude an item
x[-1]
x[-c(1, 3)]

#### logical, but be careful of the length
x[c(T, F, T, F)] # will repeat the logical vector if shorter
x[x > 5] # more commonly used case with logical index

#### Use name
names(x) <- paste0('name', 1:10); x
x['name1']
x[c('name1', 'name10')]

#### What we will get?
x[]

## indexing matrix
set.seed(10)
y <- matrix(runif(40), nrow = 4, ncol = 5)
colnames(y) <- paste0('col', 1:5)
rownames(y) <- paste0('row', 1:4); y
y[1, 1]
y[ , 1:3] # think about x[]
y[c(1, 3), c('col1', 'col4')]
y[c('row1', 'row4'), c('col1', 'col5')]
y[c('row1', 'row4'), c('col1', 'col5')] <- 1:4 # change values
y

## Index list
## a list we could see as a vector of list
## so if we take each item as a list, all vector indexing could work on list
n <- list(1:3, c('John', 'Chris', 'Rachel'),
          c(T, T, T), c(98.3, 98.5, 99)); n
n1 <- n[1]; n1 # every time it will give back a list
typeof(n1)
n[-1]
n[1:2]
n[c(T, F, T, T)]
n[]
names(n) <- c('id', 'name', 'pass', 'grade'); n
n['id']

# but every time we will get a list return
# what if we want a vector back?
n[1][[1]]

n1 <- n[[1]] # the same
typeof(n1); n1


# also we could
n[['id']]

# or
n$id

## data.frame
### methods for list and matrix both works on data.frame
df <- as.data.frame(n)
df[1, 3]
df[c(1, 3), c('name', 'grade')]
# list syntax, because data.frame reorganize a list by column
df['id'] # get first column, result is a data.frame
df[c(1, 3)] # how about this one?

# Get a column as vector
df[1][[1]]
df[1][[1]] <- c(99, 999, 9999); df # change values
df['id'][[1]]
df[[1]]
df[['id']] # get first column, result is a vector
df$id
