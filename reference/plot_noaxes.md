# Plot SpatRasters without axes by default

This is a small variant on terra::plot that provides default margin
parameters and sets axes and box arguments to false

## Usage

``` r
plot_noaxes(x, axes = FALSE, box = FALSE, mar = c(1, 0.5, 1, 4), ...)
```

## Arguments

- x:

  An object of class Raster\*

- axes:

  Defaults to FALSE, meaning axes with coordinates are not plotted

- box:

  Defaults to FALSE, meaning box drawn is not drawn around plot

- mar:

  Sets the default margins for a single plot to c(0, 0, 1, 4)

- ...:

  Graphical parameters. Any argument that can be passed to image.plot
  and to plot, such as main='title', ylab='latitude'

## Value

A plotted raster

## Examples

``` r
data(chirps)
#> Warning: data set ‘chirps’ not found
plot_noaxes(x = chirps[[1]])
#> Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function '%in%': object 'chirps' not found
plot_noaxes(x = chirps[[1:3]])
#> Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function '%in%': object 'chirps' not found
```
