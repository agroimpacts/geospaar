## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.align = 'center', fig.height = 4, 
                      fig.width = 5, cache=TRUE)

## ---- eval = FALSE, echo = FALSE-----------------------------------------
#  png("fig/zamdem.png", height = 400, width = 600)
#  plot_noaxes(dem, main = "Zambia DEM", legend.args = list(text = "meters"))
#  dev.off()
#  save(dem, file = "inst/extdata/dem.rda")

## ---- echo = FALSE-------------------------------------------------------
load(system.file("extdata/dem.rda", package = "geospaar"))
plot_noaxes(dem, main = "Zambia DEM", legend.args = list(text = "meters"))

## ---- fig.width=4--------------------------------------------------------
set.seed(1)
a <- sapply(20:100, function(x) rnorm(n = 100, mean = x, sd = x / 10))
mu <- colMeans(a)  # means
mumu <- round(mean(mu), 2) # mean of mean
sdev <- apply(a, 2, sd)  # stdevs
musd <- round(mean(sdev), 2)  # mean of stdevs
plot(mu, sdev, xlab = expression(mu), ylab = expression(sigma), pch = 20, 
     main = expression(paste("Mean (", mu, ") versus StDev (", sigma, ")")))
text(x = 20, y = 10, pos = 4,
     label = substitute(paste("Overall ", mu, "=", a), list(a = mumu)))
text(x = 20, y = 9, pos = 4,
     label = substitute(paste("Overall ", sigma, "=", a), list(a = musd)))

## ---- fig.width=6, fig.height=4------------------------------------------
# Block 1
set.seed(1)
randsamp <- sampleRandom(raintotalb, size = 10, xy = TRUE)
randsamp <- as.data.frame(randsamp)
coordinates(randsamp) <- ~x + y

# Block 2
ptdistr <- distanceFromPoints(object = raintotalb, xy = randsamp)
ptdistrmsk <- mask(ptdistr, raintotalb)

# Block 3
randsampr <- rasterize(as(randsamp, "SpatialPoints"), y = raintotalb)
ptdistr2 <- distance(randsampr)
ptdistrmsk2 <- mask(ptdistr2, raintotalb)

# Block 4
s <- stack(ptdistrmsk, ptdistrmsk2) / 1000
names(s) <- c("distanceFromPoints", "distance")
par(mfrow = c(1, 2))
for(i in 1:nlayers(s)) {
  plot_noaxes(s[[i]], main = names(s)[i])
  points(randsamp, pch = 20, cex = 0.5)
}

## ---- eval = FALSE-------------------------------------------------------
#  wcprec <- getData("worldclim", var = "prec", res = 2.5, path = p_data)
#  zamprec <- crop(wcprec, y = districts)
#  zamprec <- mask(calc(zamprec, sum), districts)
#  save(zamprec, file = "data/zamprec.rda")

## ---- fig.width=7, fig.height = 2.5--------------------------------------
# Block 1
data(zamprec)
zamprecalb <- projectRaster(from = zamprec, to = raintotalb)
names(zamprecalb) <- "rain"
elev <- resample(aggregate(x = demalb, fact = 5), y = raintotalb)

# Block 2
set.seed(1)
pts <- sampleRandom(x = zamprecalb, size = 500, sp = TRUE)
pts$elev <- extract(x = elev, y = pts)
pts <- as.data.frame(pts)
pts <- pts[which(!is.na(rowSums(pts))), ]

# Block 3
par(mfrow = c(1, 4), mar = c(4, 4, 1, 1))
for(i in 2:4) {
  plot(pts[, i], pts$rain, pch = 20, xlab = colnames(pts)[i], ylab = "rain")
}

# Block 4
rain_lm <- lm(rain ~ x + y + elev, data = pts)
summary(rain_lm)

# Block 5
xs <- xFromCell(object = raintotalb, cell = 1:ncell(raintotalb))
ys <- yFromCell(object = raintotalb, cell = 1:ncell(raintotalb))
x <- y <- raintotalb
values(x) <- xs
values(y) <- ys

# Block 6
predst <- stack(x, y, elev)
names(predst) <- c("x", "y", "elev")
predrainr <- predict(object = predst, model = rain_lm)

# Block 7
s <- stack(zamprecalb, predrainr, (predrainr - zamprecalb) / zamprecalb * 100)
mae <- round(cellStats(abs(zamprecalb - predrainr), mean), 1)  # mean absolute error
pnames <- c("'Observed' Rainfall", "Predicted Rainfall", "% Difference")
par(mfrow = c(1, 3), mar = c(0, 0, 1, 4))
for(i in 1:3) {
  plot_noaxes(s[[i]], main = pnames[i])
  if(i %in% 1:2) points(pts$x, pts$y, pch = 20, cex = 0.1, col = "grey70")
  if(i == 3) {
    mtext(side = 1, line = -3, cex = 0.8, 
          text = paste("Mean abs err =", mae, "mm"))
  }
}

