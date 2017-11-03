## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.align = 'center', fig.height = 4, 
                      fig.width = 5, cache=TRUE)

## ---- fig.width=5, fig.height=4------------------------------------------
# Block 1
zamr2 <- raster(x = extent(districts), crs = crs(districts), res = 0.25)
values(zamr2) <- 1:ncell(zamr2)

# Block 2
farmers2 <- do.call(rbind, lapply(unique(farmers$uuid), function(x) {
  dat <- farmers[farmers$uuid == x, ][1, ]  # select first row only
}))
# farmers3 <- farmers[which(!duplicated(farmers$uuid)), ]
# nrow(farmers3) == nrow(farmers2)

# Block 3
coordinates(farmers2) <- ~lon + lat
farmers2$ct <- 1  # assign value of 1 to each farmers
farmersr <- rasterize(farmers2, zamr2, field = "ct", fun = sum)

par(mar = c(0, 0, 1, 4))
plot(gUnaryUnion(districts), col = "grey", border = "transparent", 
     main = "N farmers per 0.25 degree grid cell")
plot(farmersr, add = TRUE)

