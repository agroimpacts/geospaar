# Helpful functions

## strings

### paste, paste0

Concatenate strings. `paste` includes the option to add a specific
separator, like a space or hyphen.

``` r

paste("a", "b", "c", sep = " ")
#> [1] "a b c"
paste("a", "b", "c", sep = "-")
#> [1] "a-b-c"
```

`paste0` assumes there is no separator.

``` r

paste0("a", "b", "c")
#> [1] "abc"
```

### str_replace

From `stringr` package. Use to replace strings

``` r

library(stringr)
v <- "king phillip came over for good soup"
print(v)
#> [1] "king phillip came over for good soup"
w <- stringr::str_replace(v, "soup", "spaghetti" )
print(w)
#> [1] "king phillip came over for good spaghetti"
```

### str_replace_all

Similar to `str_replace`, but `str_replace_all` replaces

``` r

library(stringr)
v <- "it was the best of times it was the worst of times"
print(v)
#> [1] "it was the best of times it was the worst of times"
w <- stringr::str_replace(v, "times", "spaghetti" )
print(w) ## only first "times" replaced
#> [1] "it was the best of spaghetti it was the worst of times"
x <- stringr::str_replace_all(v, "times", "spaghetti" ) 
print(x) ## all "times" replaced
#> [1] "it was the best of spaghetti it was the worst of spaghetti"
```

### str_sub

Create substrings based on character index

``` r

library(stringr)
v <- "it was the best of times it was the worst of times"
print(v)
#> [1] "it was the best of times it was the worst of times"
w <- stringr::str_sub(v, 1, 10)
print(w)
#> [1] "it was the"
x <- stringr::str_sub(v, 11, 20)
print(x)
#> [1] " best of t"
```

## dates

### as_date

From `lubridate` package. Converts from character to date.

Dates in “YYYY-MM-DD” format don’t need additional information.

``` r

library(lubridate)
#> 
#> Attaching package: 'lubridate'
#> The following objects are masked from 'package:base':
#> 
#>     date, intersect, setdiff, union
a <- as_date("2020-11-01")
print(a)
#> [1] "2020-11-01"
```

Dates in other formats may need the `format` parameter. See different
format options
[here](https://epirhandbook.com/en/working-with-dates.html) or run
[`?strptime`](https://rdrr.io/r/base/strptime.html).

``` r

date2 <- as_date("3/1/22", format = "%m/%d/%y" )
date2
#> [1] "2022-03-01"
```

Can also convert from date to character.

``` r

date2_char <- as.character(date2, format = "%A %B %d, %Y")
#> Warning in as.character.POSIXt(as.POSIXlt(x), ...): as.character(td, ..) no
#> longer obeys a 'format' argument; use format(td, ..) ?
date2_char
#> [1] "2022-03-01"
```

### as_datetime

Similar to `as_date`, except you can include a time.

``` r

date3 <- as_datetime("2000-05-09 10:00:00", tz = "EST")
date3
#> [1] "2000-05-09 10:00:00 EST"
```

## dplyr

``` r

library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
```

### pipe operator ( %\>% )

Use pipe operator to chain commands.

``` r

a <- c(9, 16, 25)
b <- a %>% sqrt()
b
#> [1] 3 4 5
```

Commonly used with tibbles. Note that in `dplyr`, you don’t need to use
quotes for column names.

Example below groups by “site_id” and summarizes the mean NDVI.

``` r

library(geospaar)
#> Loading required package: terra
#> terra 1.9.46
#> 
#> Attaching package: 'terra'
#> The following object is masked from 'package:knitr':
#> 
#>     spin
#> Loading required package: sf
#> Linking to GEOS 3.12.1, GDAL 3.8.4, PROJ 9.4.0; sf_use_s2() is TRUE
#> Loading required package: tidyverse
#> ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
#> ✔ forcats 1.0.1     ✔ readr   2.2.0
#> ✔ ggplot2 4.0.3     ✔ tibble  3.3.1
#> ✔ purrr   1.2.2     ✔ tidyr   1.3.2
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ tidyr::extract() masks terra::extract()
#> ✖ dplyr::filter()  masks stats::filter()
#> ✖ dplyr::lag()     masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
f <- system.file("extdata/FAOSTAT_maize.csv", package = "geospaar")
maize <- read.csv(f)
site_summary <- maize %>% 
  filter(Element == "Production") %>% 
  group_by(Area) %>% 
  summarise(mean_value = mean(Value, na.rm = TRUE), .groups = "drop")
site_summary
#> # A tibble: 2 × 2
#>   Area         mean_value
#>   <chr>             <dbl>
#> 1 South Africa   8878649.
#> 2 Zambia         1308998.
```

You can use `.` to specify in which argument the `%>%` should go to.
Let’s say you want to take a sample of size 50 from the numbers 1:100.

``` r

sample_size <- 50
samples <- sample_size %>% sample(1:100, ., replace = F)
```

### mutate

Creates a new column based on calculations you define.

``` r

set.seed(1)
tib <- tibble(a = 1:10, b = sample(1:100, 10))
tib <- tib %>% mutate(product = a * b) ## new column is product of columns a, b
tib
#> # A tibble: 10 × 3
#>        a     b product
#>    <int> <int>   <int>
#>  1     1    68      68
#>  2     2    39      78
#>  3     3     1       3
#>  4     4    34     136
#>  5     5    87     435
#>  6     6    43     258
#>  7     7    14      98
#>  8     8    82     656
#>  9     9    59     531
#> 10    10    51     510
```

### dplyr::select

``` r

set.seed(1)
tib <- tibble(a = 1:10, b = sample(1:100, 10))
tib <- tib %>% mutate(product = a * b) ## new column is product of columns a, b
tib
#> # A tibble: 10 × 3
#>        a     b product
#>    <int> <int>   <int>
#>  1     1    68      68
#>  2     2    39      78
#>  3     3     1       3
#>  4     4    34     136
#>  5     5    87     435
#>  6     6    43     258
#>  7     7    14      98
#>  8     8    82     656
#>  9     9    59     531
#> 10    10    51     510
```

### arrange

Sorts by a column. Default is ascending order. You can also arrange
multiple columns.

``` r

set.seed(1)
tib <- tibble(a = 1:10, b = sample(1:100, 10))
tib <- tib %>% mutate(product = a * b) ## new column is product of columns a, b
## sort tib by product column
tib_sorted <- tib %>% arrange(product)
tib_sorted
#> # A tibble: 10 × 3
#>        a     b product
#>    <int> <int>   <int>
#>  1     3     1       3
#>  2     1    68      68
#>  3     2    39      78
#>  4     7    14      98
#>  5     4    34     136
#>  6     6    43     258
#>  7     5    87     435
#>  8    10    51     510
#>  9     9    59     531
#> 10     8    82     656
```

Use `-` for descending order

``` r

tib_sorted <- tib %>% arrange(-product)
tib_sorted
#> # A tibble: 10 × 3
#>        a     b product
#>    <int> <int>   <int>
#>  1     8    82     656
#>  2     9    59     531
#>  3    10    51     510
#>  4     5    87     435
#>  5     6    43     258
#>  6     4    34     136
#>  7     7    14      98
#>  8     2    39      78
#>  9     1    68      68
#> 10     3     1       3
```

## control structures

### for loops

In for loop, you perform the operations once for each item in the
iterator. So if the loop starts `for(k in items)` then `items` is the
iterator.

``` r

set.seed(2)
items <- sample (1:100, 5)
for(k in items){
  print(k)
  print(paste0("This value is ", k))
}
#> [1] 85
#> [1] "This value is 85"
#> [1] 79
#> [1] "This value is 79"
#> [1] 70
#> [1] "This value is 70"
#> [1] 6
#> [1] "This value is 6"
#> [1] 32
#> [1] "This value is 32"
```

### if-else

``` r

items <- sample(LETTERS, 10)

for(k in items){
  print(k)
  if(k %in% c("A", "E", "I", "O", "U")){
    print("vowel")
  } else {
    print("consonant")
  }
}
#> [1] "H"
#> [1] "consonant"
#> [1] "Q"
#> [1] "consonant"
#> [1] "Y"
#> [1] "consonant"
#> [1] "L"
#> [1] "consonant"
#> [1] "I"
#> [1] "vowel"
#> [1] "R"
#> [1] "consonant"
#> [1] "K"
#> [1] "consonant"
#> [1] "A"
#> [1] "vowel"
#> [1] "C"
#> [1] "consonant"
#> [1] "P"
#> [1] "consonant"
```

### lapply

`lapply` returns objects in a list.

``` r

v1 <- 1:5
v2 <- lapply(v1, function(x){
  y <- x^2  ## y will be returned
}) #
print(v2)
#> [[1]]
#> [1] 1
#> 
#> [[2]]
#> [1] 4
#> 
#> [[3]]
#> [1] 9
#> 
#> [[4]]
#> [1] 16
#> 
#> [[5]]
#> [1] 25
```

### sapply

`sapply` returns elements in a vector (when possible)

``` r

v1 <- 1:5
v2 <- sapply(v1, function(x){
  y <- x^2  ## y will be returned
}) #
print(v2)
#> [1]  1  4  9 16 25
```

### apply

`apply` works well fro 2D objects.

``` r

set.seed(3)
v1 <- sample(1:100, 5)
v2 <- sample(1:100, 5)
DF <- data.frame(v1, v2) ## data frame columns will take names of vectors
DF
#>   v1 v2
#> 1  5 95
#> 2 58  8
#> 3 12 20
#> 4 36 74
#> 5 99 55
```

Use index 1 for rows.

``` r

## index 1 for rows
rowMax <- apply(DF, 1, FUN = max)
rowMax
#> [1] 95 58 20 74 99
```

Use index 2 for columns

``` r

## index 2 for columns
colMax <- apply(DF, 2, FUN = max)
colMax
#> v1 v2 
#> 99 95
```

## sampling

### sample

`sample` is used for picking samples from a discrete object, like a
vector.

``` r

v1 <- sample(1:100, 5)
v2 <- sample(letters, 5)
print(v1)
#> [1] 40 48  8 37 66
print(v2)
#> [1] "l" "m" "e" "h" "x"
```

### runif

`runif` samples from a uniform distribution (equal probability for all
values in the defined interval)

The example below picks 5 values from a uniform distribution between 0
and 2.

``` r

set.seed(4)
v <- runif(5, min = 0, max = 2)
v
#> [1] 1.17160061 0.01789159 0.58747922 0.55474992 1.62714843
```

### rnorm

`rnorm` uses a normal distribution. You can define the mean and standard
deviation.

``` r

set.seed(4)
v <- rnorm(5, mean = 10, sd = 3)
v
#> [1] 10.650265  8.372522 12.673434 11.787942 14.906854
```

## read/write

### read/write csv’s

You can use Base R
[`read.csv()`](https://rdrr.io/r/utils/read.table.html), or readr
`read_csv()`

``` r

f <- system.file("extdata/FAOSTAT_maize.csv", package = "geospaar")
maize <- read.csv(f)
print(class(maize))
#> [1] "data.frame"
```

``` r

maize2 <- readr::read_csv(f)
#> Rows: 228 Columns: 14
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> chr (8): Domain Code, Domain, Area, Element, Item, Unit, Flag, Flag Description
#> dbl (6): Area Code, Element Code, Item Code, Year Code, Year, Value
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
print(class(maize2))
#> [1] "spec_tbl_df" "tbl_df"      "tbl"         "data.frame"
maize2
#> # A tibble: 228 × 14
#>    `Domain Code` Domain `Area Code` Area      `Element Code` Element `Item Code`
#>    <chr>         <chr>        <dbl> <chr>              <dbl> <chr>         <dbl>
#>  1 QC            Crops          202 South Af…           5312 Area h…          56
#>  2 QC            Crops          202 South Af…           5312 Area h…          56
#>  3 QC            Crops          202 South Af…           5312 Area h…          56
#>  4 QC            Crops          202 South Af…           5312 Area h…          56
#>  5 QC            Crops          202 South Af…           5312 Area h…          56
#>  6 QC            Crops          202 South Af…           5312 Area h…          56
#>  7 QC            Crops          202 South Af…           5312 Area h…          56
#>  8 QC            Crops          202 South Af…           5312 Area h…          56
#>  9 QC            Crops          202 South Af…           5312 Area h…          56
#> 10 QC            Crops          202 South Af…           5312 Area h…          56
#> # ℹ 218 more rows
#> # ℹ 7 more variables: Item <chr>, `Year Code` <dbl>, Year <dbl>, Unit <chr>,
#> #   Value <dbl>, Flag <chr>, `Flag Description` <chr>
```

### save/load

Saving and loading is used for `RData` objects. Use extension `.rda`.
You can save any R object in this way (data frames, tibbles, lists,
rasters etc)

``` r

f <- system.file("extdata/FAOSTAT_maize.csv", package = "geospaar")
maize <- read.csv(f)
save(maize, file = "~/maize.rda") ## save to your user home
```

When you load data, it will retain the variable name it had.

``` r

maize <- NULL
load(file = "~/maize.rda") ## data will be loaded into "maize" variable
```

## table indexes

### Base R

Use `[ , ]` notation. Row conditions (filtering) are to the left of
comma. Column conditions (dplyr::selecting columns) are to the right.

``` r

DF <- data.frame(v1 = 1:5, v2 = 6:10)
rownames(DF) <- LETTERS[1:5]
DF
#>   v1 v2
#> A  1  6
#> B  2  7
#> C  3  8
#> D  4  9
#> E  5 10
```

``` r

DF[,'v2'] ## column indexing
#> [1]  6  7  8  9 10
```

``` r

DF[c("A", "B", "D"), ] ## row indexing
#>   v1 v2
#> A  1  6
#> B  2  7
#> D  4  9
```

Subsetting data.

``` r

DF[ DF$v1 > 3   ,    ] ## get observations (rows) where first column is larger than 3
#>   v1 v2
#> D  4  9
#> E  5 10
```

### dplyr

Use `filter` for row conditions and
[`dplyr::select`](https://dplyr.tidyverse.org/reference/select.html) to
dplyr::select columns.

``` r

DF <- tibble(v1 = 1:5, v2 = 6:10)
rownames(DF) <- LETTERS[1:5]
#> Warning: Setting row names on a tibble is deprecated.
DF
#> # A tibble: 5 × 2
#>      v1    v2
#> * <int> <int>
#> 1     1     6
#> 2     2     7
#> 3     3     8
#> 4     4     9
#> 5     5    10
```

Filter to rows where v1 is greater than 3.

``` r

DF_filt <- DF %>% filter(v1 > 3)
DF_filt
#> # A tibble: 2 × 2
#>      v1    v2
#> * <int> <int>
#> 1     4     9
#> 2     5    10
```

Same as above but only show column v2.

``` r

DF_filt <- DF %>% filter(v1 > 3) %>% dplyr::select(v2)
DF_filt
#> # A tibble: 2 × 1
#>      v2
#>   <int>
#> 1     9
#> 2    10
```

### slice

`slice` is a `dplyr` function to dplyr::select rows by number.

dplyr::select second and third rows.

``` r

DF_filt <- DF %>% slice(2:3)
DF_filt
#> # A tibble: 2 × 2
#>      v1    v2
#> * <int> <int>
#> 1     2     7
#> 2     3     8
```

### head, tail

`head` dplyr::selects the first n rows in a data frame or tibble. `tail`
dplyr::selects the last n rows.

``` r

DF_head <- DF %>% head(2)
DF_head
#> # A tibble: 2 × 2
#>      v1    v2
#>   <int> <int>
#> 1     1     6
#> 2     2     7
```

``` r

DF_tail <- DF %>% tail(2)
DF_tail
#> # A tibble: 2 × 2
#>      v1    v2
#>   <int> <int>
#> 1     4     9
#> 2     5    10
```

## table functions

### cbind, rbind

### joins

### pivot_longer

### pivot_wider

## Other

### which

Returns indices (position in vector) where a condition is true.

``` r

set.seed(1)
a <- sample(1:100, 20)
print(a)
#>  [1] 68 39  1 34 87 43 14 82 59 51 85 21 54 74  7 73 79 37 83 97
print(which(a > 80)) ## shows indices of elements greater than 80. 
#> [1]  5  8 11 19 20
```

### which.min

Finds index of minimum value. Only returns first location of min, even
if multiple values exist.

``` r

v <- c(5, 1, 10, 3, 10, 8, 1)
which.min(v) ## only returns index 2, even though 
#> [1] 2
```

### which.max

Finds index of maximum value. Only returns first location of max, even
if multiple values exist.

``` r

v <- c(5, 1, 10, 3, 10, 8, 1)
which.max(v) ## only returns index 3
#> [1] 3
```

### unique

`unique` filters an object to unique values

``` r

set.seed(2)
birthdays <- sample(1:365, 50, replace = T) ## sample 100 birthdays
print(birthdays)
#>  [1] 341 198 262 273 349 204 297 178  75 131 306 311  63 136 231 289  54 361 112
#> [20] 171  38 361 110 144  45 238 208 134 339   9 350 130 244   3 129 304 297 301
#> [39] 289 274   8 164 350  37 226 149 205 327 242 358
```

``` r

distinct_birthdays <- (unique(birthdays))
print(distinct_birthdays)
#>  [1] 341 198 262 273 349 204 297 178  75 131 306 311  63 136 231 289  54 361 112
#> [20] 171  38 110 144  45 238 208 134 339   9 350 130 244   3 129 304 301 274   8
#> [39] 164  37 226 149 205 327 242 358
print(paste0(length(distinct_birthdays), " distinct birthdays"))
#> [1] "46 distinct birthdays"
```

## getting help

### ?

Use `?` to load help for a function

``` r

#?dplyr::mutate
#?strptime
```

------------------------------------------------------------------------

[Back to home](https://agroimpacts.github.io/geospaar/articles/index.md)

------------------------------------------------------------------------
