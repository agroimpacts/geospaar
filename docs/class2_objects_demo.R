# Vector
## create
x <- 'John' # a vector of character with length 1
x
is.vector(x)
x <- c('John') # the same as above
x

x <- c('John', 'Chris', 'Rachel') # recreate a longer one
## Check
is.character(x)
is.double(x)
as.numeric(x)
as.logical(x)

## attributes
dim(x)
length(x)
names(x)
class(x)
attributes(x)

levels(x_f)
as.character(x_f)
as.integer(x_f)

## set attributes
### names, how many items we should set?
names(x) <- 'name'
x
names(x)

# should give it a name vector with the same length as the vector
names(x) <- c('name1', 'name2', 'name3')
x
names(x)
attr(x, 'names') # the same as names(x)
attributes(x) # list all attributes

### Or we could set names when creating
x <- c(name1 = 'John', name2 = 'Chris', name3 = 'Rachel')
names(x)

### add meta data
attr(x, 'function') <- 'register'
x
attributes(x)
attr(x, 'function')

### convert to matrix
x_matrix <- matrix(x, nrow = 1, ncol = 3)
dim(x_matrix)
length(x_matrix)

### add an NA
c('John', 'Chris', 'Rachel', NA)

## Other types of vector
y <- c(1, 3, 4, 7, 10); y
y <- c(1:40); y # a vector of integer with length 50
y <- 1:40; y # the same as above, only for a sequence of numbers

is.vector(y)
is.numeric(y)
is.integer(y)
y_char <- as.character(y); y_char # could convert back
y_converted <- as.integer(y_char); y_converted

y_logic <- as.logical(y); y_logic # cannot convert back
y_converted <- as.integer(y_logic); y_converted

### To matrix
length(y)
y1 <- matrix(y, nrow = 10, ncol = 4); y1 # one way
dim(y1)
y2 <- y
dim(y2)
dim(y2) <- c(10, 4); y2 # another way

# use rbind, cbind
y3 <- 1:5
y3_rbind <- rbind(row1 = y3, row2 = y3); y3_rbind
y3_cbind <- cbind(y3, y3); y3_cbind

### to array
y3 <- array(y, dim = c(2, 5, 4)); y3 # one way
y4 <- y
dim(y4)
dim(y4) <- c(2, 5, 4); y4 # another way

### array/matrix attributes
colnames(y)
colnames(y2) # seems like the same
colnames(y) <- as.character(1:40) # try to set colnames for vector
colnames(y2) <- c('col1', 'col2', 'col3', 'col4')
colnames(y2)

# the same for rownames
rownames(y2) <- as.character(1:10)
rownames(y2)
y2

dimnames(y2) # get a list

## Logical
z <- c(T, F, T, F)
z
is.logical(z)
as.integer(z)
as.character(z)

## double
m <- runif(10, 0, 1)
m
is.double(m)

## factor
f <- factor(c('M', 'F'))
f
typeof(f) # it is an integer type
class(f)

attributes(f) # has levels and class attributes
levels(f)

# convert to other types with caution
as.integer(f)
as.character(f)

# an example
f <- factor(c('John', 'Chris', 'Rachel'))
typeof(f)
attributes(f)

as.character(f)
as.integer(f)
levels(f)

f1 <- factor(c('F', 'M', 'F'))
f2 <- factor(c('F', 'F'))

c(f1, f2) # dangerous

# recommended way, make a list and then unlist it.
unlist(list(f1, f2))

# Any question about what we have showed above?


# Mix different types in a vector
# all items will be converted to the most complex one
# logical < integer < double < character

n <- c(1, 'John', T, 98.3)
typeof(n)

o <- c(1, 2, T, T, F)
typeof(o)

p <- c(1L, 2L, T, F)
typeof(p)


# Use list to store things with different classes
n <- list(1, 'John', T, 98.3); n
length(n)
dim(n)
names(n) <- c('id', 'name', 'pass', 'grade')
n
names(n)

n <- list(id = 1, name = 'John', pass = T, grade = 98.3); n # the same to set names
attr(n, 'function') <- 'register'
n
attributes(n)

## list-matrix
dim(n)
dim(n) <- c(2, 2)
n

is.list(n)
colnames(n) <- c('col1', 'col2')
rownames(n) <- c('row1', 'row2')
n

## list-matrix with longer list
n <- list(id = 1:2, name = c('John', 'Rachel'), pass = c(T, T), grade = c(98.3, 98.5)); n
n <- matrix(n, nrow = 2, ncol = 2) # the same as setting dim
n

### as we could see, list is a vector!! ###

## data.frame
df <- as.data.frame(n)
is.data.frame(df)
str(df)
attributes(df)
nrow(df); ncol(df)
names(df)
row.names(df)

rownames(df) # also works
colnames(df) # also works

# operation
## Single numbers
### One fact: within R,
### a single number/character/... is actually a vector of length 1
1.5 + 2.3 - (0.6 + 2.1) * 1.2 - 1.5 / 0.5 + 2^3
5 %/% 3
5 %% 3

## Non-length1 vectors with single number
x <- 1:5
x + 3
(x + 3) / 2 - (2 * x + 1) + x^2

y <- c(x, NA)
y + 2

## vectors with the same length
x1 <- c(1, 5)
x2 <- c(7, 19)

x1 + x2
x1 - x2
x1 * x2

# vectors with different lengths
x1 <- c(10, 20)
x2 <- c(1, 3, 5, 7)
# The shorter one will be repeated first to get the same length,
# then do calculation.
x1 + x2

# It will give you a warning
# if the length of one vector is not the multiple of another one.
x1 <- c(10, 20, 40)
x2 <- c(1, 3, 5, 7)
x1 + x2

# sort function
x1 <- sample(1:100, 10)
x1
sort(x1)
order(x1) # give you the index


## logical type
3 >= 5
c(1, 3, 5) >= 2
c(1, 3, 5) + 1 >= 2

c(1:4) > c(3:6)
c(1:4) > c(3:5) # still will repeat the shorter one
c(1, NA, 2) <= 4

## is.xxx function
is.na(c(1, NA, 2))

# %in% check if an item within a vector or not
3 %in% 3
c(1, 3) %in% 3
3 %in% c(1:3)
c(1, 3) %in% c(2:10)
'John' %in% c('John', 'Ross')

# logical calculation
T | F
T & F
!T

# some checking functions
x <- c(TRUE, FALSE, FALSE, TRUE, TRUE, FALSE)
all(x) # all true?
any(x) # any true?

## example
num <- c(3, 2, 4, 23, 5, 10, 3)
any(num > 10)
all(num < 10)

which(num > 10)

duplicated(num)
unique(num)

all.equal(c(1, 2, 3), c(1, 2, 3))

## character
x <- 'This is a string'
nchar(x)
substr(x, 1, 4)

paste(x, "!!")
paste(x, "!!", sep = '/')
paste0(x, "!!")

strsplit(x, " ")[[1]]
gsub(" ", "_", x)

y <- strsplit(x, " ")[[1]]
y
paste0(y, " ")
paste(y, collapse = ' ')
