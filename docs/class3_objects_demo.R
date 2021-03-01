# Title     : Demo script for objects and operations
# Objective : Include necessary examples to show how to create objects,
#             query or set their attributes, and operations between vectors.
# Created by: Lei Song
# Created on: 03/01/21

#####################
##     Vector      ##
#####################

# character vector
x <- 'John' # a vector of character with length 1
x
is.vector(x)

x <- c('John') # the same as above
x

# recreate a longer one
x <- c('John', 'Chris', 'Rachel')
x

## Check
is.character(x)
is.double(x)

## convert data type
as.numeric(x)
x_c <- as.numeric(x) # might put unexpected things into x_c
as.logical(x)

# Convert to factors
x
x_f <- factor(x) # or as.factor()
x_f
levels(x_f)
as.character(x_f)
as.integer(x)
as.integer(x_f) # it is convertible because factor is a sequence of integers with labels

## See a very brain-damaging example
f <- factor(c(1:4, 10))
f
f_int <- as.integer(f)
f_int
# Learn our lesson: be careful of factor,
# even though is necessary for categorical data

# How to deal with this?
## We could set levels manually
f <- factor(c(1:4, 10), levels = 1:10)
f
f_int <- as.integer(f)
f_int

## We could convert to character first
f <- factor(c(1:4, 10))
f
f_int <- as.integer(as.character(f))
f_int

## We could convert levels information instead
f <- factor(c(1:4, 10))
f
f_int <- as.integer(levels(f)[f])
f_int

## Merge two factor vectors
f1 <- factor(c('F', 'M', 'F'))
f2 <- factor(c('F', 'F'))
f1; f2

c(f1, f2) # dangerous

# recommended way, make a list and then unlist it.
unlist(list(f1, f2))

## attributes
x
dim(x)

length(x)

names(x)

# should give it a name vector with the same length as the vector
names(x) <- 'name'
x
names(x) <- c('name1', 'name2', 'name3')
x
names(x)
attr(x, 'names') # the same as names(x)
attr(x, 'names') <- c('name_a', 'name_b', 'name_c') # the same as names(x) <- c('name1', 'name2', 'name3')

attributes(x)

# set a new attribute
attr(x, 'type') <- 'roster'

attributes(x)

attr(x, 'type')

### include NAs
x_n <- c('John', 'Chris', NA, 'Rachel', NA)
x_n
length(x_n)

## numeric vector
y <- c(1, 3, 4, 7, 10); y
y <- c(0:9); y # a vector of integer with length 50
y <- 0:9; y # the same as above, only for a sequence of numbers

is.vector(y)
is.numeric(y) # is.numeric exam if an object behave like numbers
is.integer(y)
y_char <- as.character(y); y_char # could convert back
y_converted <- as.integer(y_char); y_converted

y_logic <- as.logical(y); y_logic # cannot convert back
y_converted <- as.integer(y_logic); y_converted

#####################
##   array/matrix  ##
#####################

### convert a vector to matrix
y
length(y)
y1 <- matrix(y, nrow = 2, ncol = 5); y1 # one way
dim(y1)

y2 <- y
y2
dim(y2)
dim(y2) <- c(2, 5); y2 # another way

# use rbind, cbind
y3 <- 1:5
y3
y3_rbind <- rbind(row1 = y3, row2 = y3 + 2); y3_rbind
rownames(y3_rbind)
dimnames(y3_rbind)

y3_cbind <- cbind(y3 + 2, y3); y3_cbind
colnames(y3_cbind)
colnames(y3_cbind) <- c('col1', 'col2')
colnames(y3_cbind)
rownames(y3_cbind) <- 1:5
dimnames(y3_cbind)

### to array
y <- 1:40
y3 <- array(y, dim = c(2, 5, 2, 2)); y3 # one way

y4 <- y
dim(y4)
dim(y4) <- c(2, 5, 4); y4 # another way

###################################
# Mix different types in a vector #
###################################
# all items will be converted to the most complex one
# logical < integer < double < character

n <- c(1, 'John', T, 98.3)
n; typeof(n)

o <- c(1.2, 2, T, T, F)
o; typeof(o)

p <- c(1L, 2L, T, F)
typeof(p)

#####################
##      List       ##
#####################
# Use list to store things with different classes
n <- list(1:3, c('John', 'Chris', 'Rachel'),
          c(T, T, T), c(98.3, 98.5, 99)); n
length(n)
dim(n)
names(n) <- c('id', 'name', 'pass', 'grade')
n
names(n)

n <- list(id = 1:3, name = c('John', 'Chris', 'Rachel'),
          pass = c(T, T, T), grade = c(98.3, 98.5, 99)); n # the same to set names
attr(n, 'type') <- 'roster'
n
attributes(n)

#####################
##   data.frame    ##
#####################
n
df <- as.data.frame(n)
df
is.data.frame(df)
str(df)
attributes(df)
nrow(df); ncol(df)
names(df) # because data.frame combine "containers" of a list by column
row.names(df)

rownames(df) # also works
colnames(df) # also works

#####################
##    Operation    ##
#####################

## Single numbers
### One fact: within R,
### a single number/character/... is actually a vector of length 1
1.5 + 2.3 - (0.6 + 2.1) * 1.2 - 1.5 / 0.5 + 2^3
5 %/% 3 # integral division operator
5 %% 3 # x mode y

## vectors with the same length
x1 <- c(1, 5)
x2 <- c(7, 19)
x1; x2

# calculation is done in pairs
x1 + x2
x1 - x2
x1 * x2

# vectors with different lengths
x1 <- c(10, 20)
x2 <- c(1, 3, 5, 7)
x1; x2
# The shorter one will be repeated first to get the same length,
# then do calculation.
x1 + x2

## Special case: non-length1 vectors with single number
x <- 1:5
x + 3
(x + 3) / 2 - (2 * x + 1) + x^2

# It will give you a warning
# if the length of one vector is not the multiple of another one.
x1 <- c(10, 20, 40)
x2 <- c(1, 3, 5, 7)
x1 + x2

# sort function
x1 <- sample(1:100, 10)
x1
sort(x1)


## logical type
3 >= 5
c(1, 3, 5) >= 2
c(1, 3, 5) + 1 >= 2

c(1:4) > c(3:6)
c(1:4) > c(3:5) # still will repeat the shorter one
c(1, NA, 2) <= 4

## check NAs
anyNA(c(1, NA, 2))

# %in% check if an item within a vector or not
3 %in% 3
c(1, 3) %in% 3 # check each element of c(1, 3) if in c(3)
3 %in% c(1:3) # check each element of c(3) if in c(1:3)
c(1, 3) %in% c(2:10) # check each element of c(1, 3) if in c(2:10)
'John' %in% c('John', 'Ross')

# logical calculation
T | F # or
T & F # and
!T # not

# some checking functions
x <- c(TRUE, FALSE, FALSE, TRUE, TRUE, FALSE); x
all(x) # all true?
any(x) # any true?

## example
num <- c(3, 2, 4, 23, 5, 10, 3)
any(num > 10)
all(num < 10)

which(num > 5) # give you index

duplicated(num)
unique(num)

all.equal(c(1, 2, 3), c(1, 2, 3))

## character
x <- 'This is a string'
nchar(x)
substr(x, 1, 4) # get sub string

# paste strings together
paste(x, "!!")
paste(x, "!!", sep = '/')
paste0(x, "!!")

# split a string
y <- strsplit(x, " ")[[1]]
y
paste(y, collapse = ' ')

# replace sub string within a string
gsub(" ", "_", x)

