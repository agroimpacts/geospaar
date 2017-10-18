#' Evaluate the structure of SpatialPolygons*
#' @description Calculates the number of polygons per SpatialPolygons*, and how
#' many polygons are in each of those polygons
#' @param l A list of SpatialPolygons* to evaluate
#' @return A matrix
#' @examples
#' data(districts)
#' polygon_structure(l = list(districts))
#' @export
sppoly_structure <- function(l) {
  do.call(rbind, lapply(1:length(l), function(x) {
    p <- slot(l[[x]], "polygons")  # get polygons slot from l[[x]]
    ps <- t(sapply(1:length(p), function(y) {  # loop through p's poly groups
      a <- length(slot(p[[y]], "Polygons"))  # # polys in each group
      c("poly group" = y, "N polys in group" = a) # combine w/ y, grp counter
    }))  # transpose sapply results to get variables as columns
    cbind("object#" = x, ps)  # cbind x with ps, giving a label for object
  }))
}
