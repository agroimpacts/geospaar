# Control structure code in slides
## If-else
# one line
if (4 > 5) print('4 is larger than 5.') else print("4 is smaller than 5.")
# paragraph
if (4 > 5) {
  print('4 is larger than 5.')
} else print("4 is smaller than 5.")
# or could get longer
if (4 > 5) {
  print('4 is larger than 5.')
} else if (4 == 5){
  print("4 is equal to 5.")
} else {
  print("4 is smaller than 5.")
}
# ifelse
ifelse(4 > 5, print('4 is larger than 5.'), print("4 is smaller than 5."))

x <- 4
y <- 10
z <- ifelse(x > y, x, y)

## switch
x <- 'b'
# If - else structure
if (x == "a") {
  "option 1"
} else if (x == "b") {
  "option 2"
} else if (x == "c") {
  "option 3"
} else {
  stop("Invalid `x` value")
}
# switch
switch(x,
       a = "option 1",
       b = "option 2",
       c = "option 3",
       stop("Invalid `x` value")
)

## For loop
# One line
for (i in 1:10) print(i)
# code paragraph
for (x in 1:10){
  print(x)
  print(x + 1)
}
# nested for
for (i in 1:10){
  for (j in 2:11){
    print(i + j)
  }
}

## While and repeat
# while
x <- 0
while(x < 10){
  print(x)
  x <- x + 1 # Change the checking condition
}
# repeat
x <- 0
repeat{
  print(x)
  x <- x + 1 # update
  if (x == 10){
    print('Finish repeat!')
    break
  }
}

# Break and next
x <- 0
repeat{
  if (x < 5){
    print('Skip this interation!')
    next
  }
  x <- x + 1 # what if we move this line after the first if?
  if (x == 10){
    print('Finish repeat!')
    break
  }
  print(x)
}
