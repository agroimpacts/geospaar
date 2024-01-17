#' Plot SpatRasters without axes by default
#' @description This is a small variant on terra::plot that provides default
#' margin parameters and sets axes and box arguments to false
#' @param x An object of class Raster*
#' @param axes Defaults to FALSE, meaning axes with coordinates are not plotted
#' @param box Defaults to FALSE, meaning box drawn is not drawn around plot
#' @param mar Sets the default margins for a single plot to c(0, 0, 1, 4)
#' @param ... Graphical parameters. Any argument that can be passed to
#' image.plot and to plot, such as main='title', ylab='latitude'
#' @return A plotted raster
#' @importFrom graphics par
#' @examples
#' data(chirps)
#' plot_noaxes(x = chirps[[1]])
#' plot_noaxes(x = chirps[[1:3]])
#' @export
plot_noaxes <- function(x, axes = FALSE, box = FALSE, mar = c(1, 0.5, 1, 4),
                        ...) {
  if(!class(x) %in%
     c("RasterLayer", "RasterStack", "RasterBrick", "SpatRaster")) {
    stop("This function is intended for rasters only", call. = FALSE)
  }
  par(mar = mar)
  if(class(x) %in% c("RasterLayer", "RasterStack", "RasterBrick")) {
    plot(x, axes = axes, box = axes, ...)
  } else {
    plot(x, axes = axes, mar = NA, ...)
  }
}
