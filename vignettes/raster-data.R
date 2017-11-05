## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.align = 'center', fig.height = 4, 
                      fig.width = 5)

## ---- warning=FALSE, message=FALSE---------------------------------------
library(geospaar)
library(rgdal)
library(rgeos)
library(raster)

## ---- message=FALSE, warning=FALSE---------------------------------------
farmers <- read.csv(system.file("extdata/farmer_spatial.csv", 
                                package = "geospaar"), stringsAsFactors = FALSE)
roads <- readOGR(system.file("extdata/roads.shp", package = "geospaar"), 
                 layer = "roads", verbose = FALSE)
data("districts")

## ------------------------------------------------------------------------
e <- extent(c("xmin" = 27, "xmax" = 29, "ymin" = -16, "ymax" = -14))  # 1
r <- raster(x = e, res = 0.25, crs = crs(districts))  # 2 
set.seed(1)  
values(r) <- sample(1:100, size = ncell(r), replace = TRUE)  # 3
# r[] <- sample(1:100, size = ncell(r), replace = TRUE) 
# r <- setValues(x = r, values = sample(1:100, size = ncell(r), replace = TRUE))

par(mar = c(0, 0, 0, 4))
plot(districts, col = "grey")
plot(r, add = TRUE)

## ------------------------------------------------------------------------
r
class(r)
typeof(r)
slotNames(r)
values(r)
# slot(slot(r, "data"), "values")  # identical to values(r)
res(r)

## ------------------------------------------------------------------------
r2 <- r > 50
r3 <- r
set.seed(1)
values(r3) <- rnorm(n = ncell(r3), mean = 10, sd = 2)
l <- list(r, r2, r3)

## ------------------------------------------------------------------------
s <- stack(l)
# s <- stack(r, r2, r3)  # also works
names(s) <- c("r", "r2", "r3")
s

b <- brick(s)
b

plot(b)

## ---- fig.width=7, fig.height=2.5----------------------------------------
par(mfrow = c(1, 3), mar = c(0, 0, 0, 4))
for(i in 1:nlayers(s)) {
  plot(districts, col = "grey")
  plot(s[[i]], add = TRUE)
}

## ---- eval = FALSE-------------------------------------------------------
#  # Block 1 - write to disk
#  writeRaster(r, filename = "external/unit2/data/r.tif")
#  writeRaster(r2, filename = "external/unit2/data/r2.tif")
#  writeRaster(r3, filename = "external/unit2/data/r3.tif")
#  writeRaster(b, filename = "external/unit2/data/b.tif")
#  
#  # Block 2 - read back in each individual raster and recreate stack
#  r <- raster("external/unit2/data/r.tif")
#  r2 <- raster("external/unit2/data/r2.tif")
#  r3 <- raster("external/unit2/data/r3.tif")
#  s <- stack(list(r, r2, r3))  # recreate stack
#  
#  # Block 3 - programmatic creation of stack
#  fnms <- dir("external/unit2/data/", pattern = "r.*.tif", full.names = TRUE)
#  l <- lapply(fnms, function(x) raster(x))
#  s <- stack(l)
#  
#  # Block 4 - read in brick
#  b <- raster("external/unit2/data/b.tif")  # incorrect
#  b <- brick("external/unit2/data/b.tif")  # correct

## ---- fig.width=5, fig.height=4------------------------------------------
# Block 1
zamr <- raster(x = extent(districts), crs = crs(districts), res = 0.1)
values(zamr) <- 1:ncell(zamr)

# Block 2
districts$ID <- 1:length(districts)
distsr <- rasterize(x = districts, y = zamr, field = "ID")
distsr

par(mar = c(0, 0, 0, 4))
plot(distsr, axes = FALSE, box = FALSE)

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

## ------------------------------------------------------------------------
# Block 3 (not run because slow)
# roads$ID <- 1:length(roads)
# roads$length <- gLength(spgeom = roads, byid = TRUE) / 1000
# roadsgcs <- spTransform(roads[roads$length > 1000, ], crs(zamr))
# roadsr <- rasterize(x = roadsgcs, y = zamr, field = "ID", progress = "text")

## ---- fig.width=5, fig.height=4------------------------------------------
dists_fromr <- rasterToPolygons(x = distsr, dissolve = TRUE)
farmers_fromr <- rasterToPoints(x = farmersr, spatial = TRUE)

par(mar = c(0, 0, 0, 0))
plot(dists_fromr, col = topo.colors(n = length(districts)))
points(farmers_fromr, pch = 20, col = "red")

## ---- fig.width=7, fig.height=2.5----------------------------------------
zamr_alb <- projectRaster(from = zamr, res = 11000, crs = crs(roads), 
                          method = "ngb")  # 1
distsr_alb <- projectRaster(from = distsr, to = zamr_alb, method = "ngb")  # 2

par(mfrow = c(1, 2), mar = c(0, 0, 1, 4))
plot(distsr, main = "GCS rasterized districts", axes = FALSE, box = FALSE)
plot(distsr_alb, main = "Albers rasterized districts", axes = FALSE, box = FALSE)

## ---- fig.width=7, fig.height=2.5----------------------------------------
distsr_alb2 <- projectRaster(from = distsr, to = zamr_alb, method = "bilinear")

par(mfrow = c(1, 2), mar = c(0, 0, 1, 4))
plot(distsr_alb2, main = "Bilinear reprojection", axes = FALSE, box = FALSE)
plot(distsr_alb, main = "Nearest neighbor", axes = FALSE, box = FALSE)

## ------------------------------------------------------------------------
data("chirps")

## ---- eval = FALSE, echo = FALSE-----------------------------------------
#  zamr <- raster(x = extent(districts), crs = crs(districts), res = 0.1)
#  values(zamr) <- 1:ncell(zamr)
#  
#  districts$ID <- 1:length(districts)
#  distsr <- rasterize(x = districts, y = zamr, field = "ID")
#  distsr
#  
#  farmers <- read.csv(system.file("extdata/farmer_spatial.csv",
#                                  package = "geospaar"), stringsAsFactors = FALSE)
#  farmers2 <- do.call(rbind, lapply(unique(farmers$uuid), function(x) {
#    dat <- farmers[farmers$uuid == x, ][1, ]  # select first row only
#  }))
#  coordinates(farmers2) <- ~lon + lat
#  farmers2$ct <- 1  # assign value of 1 to each farmers
#  
#  zamr2 <- raster(x = extent(districts), crs = crs(districts), res = 0.25)
#  values(zamr2) <- 1:ncell(zamr2)
#  farmersr <- rasterize(farmers2, zamr2, field = "ct", fun = sum)

## ------------------------------------------------------------------------
chirps
names(chirps)

## ---- fig.width=7, fig.height=2.5----------------------------------------
zam <- gUnaryUnion(districts)
par(mfrow = c(1, 3), mar = c(0, 0, 1, 4))
for(i in 1:3) {
  leg <- ifelse(test = i == 3, yes = TRUE, no = FALSE)  # 1
  plot(chirps[[i]], main = names(chirps)[[i]], axes = FALSE, box = FALSE, 
       zlim = c(0, max(chirps[1:3])), legend = leg)  # 2
  plot(zam, add = TRUE)
}

## ---- fig.width=5, fig.height=4------------------------------------------
test_m <- mask(x = chirps[[1]], mask = districts)
par(mar = c(0, 0, 0, 4))
plot(test_m, axes = FALSE, box = FALSE)  

## ---- fig.width=7, fig.height=2.5----------------------------------------
chirpsz <- mask(x = chirps, mask = districts)

par(mfrow = c(1, 3), mar = c(0, 0, 1, 4))
set.seed(1)
for(i in sample(1:nlayers(chirpsz), size = 3, replace = FALSE)) {
  plot(chirpsz[[i]], axes = FALSE, box = FALSE, main = names(chirpsz)[[i]]) 
}

## ---- fig.width=5, fig.height=4------------------------------------------
chirps1_dist72 <- crop(x = chirpsz[[1]], y = districts[72, ])

par(mar = c(0, 0, 0, 4))
plot(chirps1_dist72, axes = FALSE, box = FALSE)
plot(districts, add = TRUE)
text(districts, labels = districts$ID)

## ---- fig.width=5, fig.height=4------------------------------------------
par(mar = c(0, 0, 0, 4))
plot(chirpsz[[1]], axes = FALSE, box = FALSE, ext = extent(districts[72, ]))
plot(districts, add = TRUE)
text(districts, labels = districts$ID)

## ---- eval = FALSE-------------------------------------------------------
#  # x <- chirpsz[[1]]; x <- 1:10
#  plot_noaxes <- function(x, axes = FALSE, box = FALSE, mar = c(0, 0, 1, 4),
#                          ...) {
#    if(!class(x) %in% c("RasterLayer", "RasterStack", "RasterBrick", "Extent")) {
#      stop("This function is intended for rasters only", call. = FALSE)
#    }
#    par(mar = mar)
#    plot(x, axes = axes, box = axes, ...)
#  }

## ------------------------------------------------------------------------
plot_noaxes(chirpsz[[1]])

## ------------------------------------------------------------------------
chirpsz1agg <- aggregate(x = chirpsz[[1]], fact = 2, fun=mean)
chirpsz1agg

## ------------------------------------------------------------------------
chirpsz1km <- disaggregate(x = chirpsz[[1]], fact = 5)
# chirpsz1km <- disaggregate(x = chirpsz[[1]], fact = 5, method = "bilinear") 
chirpsz1km

## ---- error=TRUE---------------------------------------------------------
chirps125 <- aggregate(x = chirpsz[[1]], fact = 5)  # no fun b/c default is mean
s <- stack(chirps125, farmersr)  # fails 

par(mar = c(1, 1, 1, 1))
plot(extent(chirps125), axes = FALSE, col = "blue")
plot(extent(farmersr), add = TRUE, col = "red")


## ------------------------------------------------------------------------
farmersr_rs <- resample(x = farmersr, y = chirps125) 
s <- stack(chirps125, farmersr_rs)  
names(s) <- c("rain", "farmer_count")
plot_noaxes(s)

## ------------------------------------------------------------------------
plot(s$rain > 1 & s$farmer_count > 1)
# plot(chirps125 > 1 & farmersr > 1)

## ------------------------------------------------------------------------
cellStats(x = chirpsz[[1]], stat = "mean")  # for a single date
cellStats(x = chirpsz[[c(5, 7, 14)]], stat = "mean")
summary(chirpsz[[1:3]])

## ------------------------------------------------------------------------
v <- values(chirpsz[[1]])
mean(v) 
mean(v, na.rm = TRUE)

## ------------------------------------------------------------------------
# Block 1
rain_stats <- lapply(c("mean", "sum", "sd", "cv"), function(x) {
  cellStats(x = chirpsz, stat = x)
})
names(rain_stats) <- c("mean", "sum", "sd", "cv")

# Block 2
dates <- names(rain_stats[[1]])
dates <- as.Date(gsub("Y", "", dates), "%y%j")  # convert names to date vector

# Block 3
par(mfrow = c(2, 2), mar = c(4, 4, 2, 2))
for(i in 1:length(rain_stats)) {
  plot(x = dates, y = rain_stats[[i]], type = "l", xlab = "Date", 
       ylab = paste("Rain", names(rain_stats)[i]), col = "blue")
}

## ---- fig.width=5, fig.height=4------------------------------------------
plot_noaxes(chirpsz[[15]], main = paste("CV =", round(rain_stats$cv[15])))

## ---- fig.width=7, fig.height=4------------------------------------------
par(mfrow = c(1, 3))
hist(chirpsz[[15:17]], col = "blue", xlab = "mm")

## ------------------------------------------------------------------------
f <- freq(chirpsz[[1]])
f

## ------------------------------------------------------------------------
# zonemu <- zonal(x = chirpsz, z = distsr, fun = "mean")  # fail b/c extent
distsr_rs <- resample(x = distsr, y = chirpsz, method = "ngb")  # match extent
zonemu <- zonal(x = chirpsz, z = distsr_rs, fun = "mean")
head(zonemu)[, 1:5]

## ------------------------------------------------------------------------
distr_rfmu <- subs(x = distsr_rs, y = data.frame(zonemu)[, 1:2], by = "zone")
plot_noaxes(distr_rfmu)

## ---- fig.width=6, fig.height=4------------------------------------------
# Block 1
wmat <- matrix(1 / 9, nrow = 3, ncol = 3) 
chirps1_focmu1 <- focal(x = chirpsz[[1]], w = wmat) 

# Block 2
wmat <- matrix(1, nrow = 3, ncol = 3) 
chirps1_focmu2 <- focal(x = chirpsz[[1]], w = wmat, fun = mean) 

# Block 3
wmat <- matrix(1, nrow = 5, ncol = 5) 
chirps1_focmu3 <- focal(x = chirpsz[[1]], w = wmat, fun = mean) 

# Block 4 
wmat <- matrix(1, nrow = 5, ncol = 5) 
chirps1_focmu4 <- focal(x = chirpsz[[1]], w = wmat, fun = mean, na.rm = TRUE) 

# Block 5
wmat <- matrix(1 / 9, nrow = 5, ncol = 5) 
chirps1_focmu5 <- focal(x = chirpsz[[1]], w = wmat, na.rm = TRUE) 

# plots
l <- list(chirps1_focmu1, chirps1_focmu3, chirps1_focmu4, chirps1_focmu5)
titles <- c("3X3 NAs not removed", "5X5 NAs not removed", 
            "5X5 NAs removed properly", "5X5 NAs removed improperly")
par(mfrow = c(2, 2))
for(i in 1:length(l)) {
  plot_noaxes(l[[i]], main = titles[i])
}

## ------------------------------------------------------------------------
# Block 1
rain_zmu <- calc(x = chirpsz, fun = mean)
rain_zsd <- calc(x = chirpsz, fun = sd)
rain_zrng <- calc(x = chirpsz, fun = range)

# Block 2
rain_zstack <- stack(rain_zmu, rain_zsd, rain_zrng)
names(rain_zstack) <- c("Mean", "StDev", "Min", "Max")

plot_noaxes(rain_zstack)


## ---- eval = FALSE, echo = FALSE-----------------------------------------
#  data("chirps")
#  data("districts")
#  chirpsz <- mask(x = chirps, mask = districts)
#  districts$ID <- 1:length(districts)
#  zamr <- raster(x = extent(districts), crs = crs(districts), res = 0.1)
#  values(zamr) <- 1:ncell(zamr)
#  distsr <- rasterize(x = districts, y = zamr, field = "ID")
#  distsr_rs <- resample(x = distsr, y = chirpsz, method = "ngb")  # match extent
#  farmers <- read.csv(system.file("extdata/farmer_spatial.csv",
#                                  package = "geospaar"), stringsAsFactors = FALSE)
#  farmers2 <- do.call(rbind, lapply(unique(farmers$uuid), function(x) {
#    dat <- farmers[farmers$uuid == x, ][1, ]  # select first row only
#  }))
#  coordinates(farmers2) <- ~lon + lat
#  farmers2$ct <- 1  # assign value of 1 to each farmers

## ------------------------------------------------------------------------
r1 <- chirpsz[[1]] / chirpsz[[2]]
r2 <- chirpsz[[1]] + chirpsz[[2]]
r3 <- chirpsz[[1]] - chirpsz[[2]]
r4 <- chirpsz[[1]] * chirpsz[[2]]

s <- stack(r1, r2, r3, r4)
names(s) <- c("divide", "sum", "subtract", "multiply")
plot_noaxes(s)

## ---- fig.width = 6, fig.height=4----------------------------------------
# Block 1
raintot <- calc(chirpsz, fun = sum)
raincv <- calc(chirpsz, fun = cv)

# Block 2
highrain_highcv <- raintot > 80 & raincv > 200  

# Block 3
dist54 <- distsr_rs == 54  # 1
distrain <- dist54 * raintot  # 2
distrain[dist54 == 0] <- NA  # 3
# distrain <- mask(raintot, dist54, maskvalue = 0)  # 4

# Block 4
meandistrain <- distrain > cellStats(distrain, mean)

# Block 5
rain_gt_mu <- raintot > cellStats(raintot, mean)


s <- stack(raintot, raincv, highrain_highcv, distrain, meandistrain, rain_gt_mu)
titles <- c("Total rain", "Rain CV", "High rain, high CV", "Dist 54 rain", 
            "Dist 54 rain > mean", "Rain > mean")
par(mfrow = c(2, 3))
for(i in 1:nlayers(s)) {
  plot_noaxes(s[[i]], main = titles[i])  
}

## ------------------------------------------------------------------------
qtiles <- quantile(raintot, probs = seq(0, 1, 1/3))
raintotcut <- cut(x = raintot, breaks = qtiles, include.lowest = TRUE)

cols <- c("tan", "yellow3", "green4")
plot_noaxes(raintotcut, legend = FALSE, main = "Total Rainfall", col = cols, 
            mar = c(0, 0, 1, 0))
legend(x = "bottomright", legend = c("High", "Intermediate", "Low"), 
       pch = 15, pt.cex = 3, col = rev(cols), bty = "n")

## ------------------------------------------------------------------------
rclmat <- cbind(qtiles[1:3], qtiles[2:4], 1:3)
rclmat
raintotrcl <- reclassify(x = raintot, rcl = rclmat, include.lowest = TRUE)

plot_noaxes(raintotrcl, legend = FALSE, main = "Total Rainfall", col = cols, 
            mar = c(0, 0, 1, 0))
legend(x = "bottomright", legend = c("High", "Intermediate", "Low"), 
       pch = 15, pt.cex = 3, col = rev(cols), bty = "n")

## ------------------------------------------------------------------------
# Block 1
farmrain <- extract(x = raintot, y = farmers2)

# Block 2
farmdistid <- unique(extract(distsr_rs, farmers2))  # 1
farmdistid <- na.exclude(farmdistid)  # 2
# farmdistids <- farmdistids[!is.na(farmdistids)]  # 3
farmdists <- districts[na.exclude(farmdistid), ]  # 4
distrain <- extract(x = raintot, y = farmdists, fun = mean)  # 5

# Block 3
farmrainmu <- mean(farmrain, na.rm = TRUE)
distrainmu <- mean(distrain, na.rm = TRUE)
boxplot(x = list(farmrain, distrain), col = c("blue", "red"), xaxt = "n", 
        main = "Rainfall", ylab = "mm")
points(x = 1:2, y = c(farmrainmu, distrainmu), pch = 16, cex = 2)
axis(side = 1, at = 1:2, labels = c("Farmers", "Districts"))

## ------------------------------------------------------------------------
# Block 1
farmdistsr <- distsr_rs %in% farmdistid
distsrfarm <- mask(x = distsr_rs, mask = farmdistsr, maskvalue = 0)
# plot_noaxes(farmdistsr)

# Block 2
set.seed(1)
distsamp <- sampleRandom(x = distsrfarm, size = nrow(farmers2), cells = TRUE)
# head(distsample)
randrain <- raintot[distsamp[, 1]]

# Block 3
set.seed(1)
distsamp_str <- sampleStratified(x = distsrfarm, 
                                 size = nrow(farmers2) / length(farmdistid), 
                                 cells = TRUE)
stratrandrain <- raintot[distsamp_str[, 1]]

# Block 4
randmu <- mean(randrain, na.rm = TRUE)
strrandmu <- mean(stratrandrain, na.rm = TRUE)
boxplot(x = list(distrain, randrain, stratrandrain), ylab = "mm",
        col = c("blue", "red", "purple"), xaxt = "n", main = "Rainfall")
points(x = 1:3, y = c(distrainmu, randmu, strrandmu), pch = 16, cex = 2)
axis(side = 1, at = 1:3, labels = c("Distr. means", "Random", "Strat. Random"))

## ---- eval = FALSE, echo = FALSE-----------------------------------------
#  data("chirps")
#  data("districts")
#  chirpsz <- mask(x = chirps, mask = districts)
#  districts$ID <- 1:length(districts)
#  
#  zamr <- raster(x = extent(districts), crs = crs(districts), res = 0.1)
#  values(zamr) <- 1:ncell(zamr)
#  distsr <- rasterize(x = districts, y = zamr, field = "ID")
#  distsr_rs <- resample(x = distsr, y = chirpsz, method = "ngb")  # match extent
#  farmers <- read.csv(system.file("extdata/farmer_spatial.csv",
#                                  package = "geospaar"), stringsAsFactors = FALSE)
#  farmers2 <- do.call(rbind, lapply(unique(farmers$uuid), function(x) {
#    dat <- farmers[farmers$uuid == x, ][1, ]  # select first row only
#  }))
#  coordinates(farmers2) <- ~lon + lat
#  farmers2$ct <- 1  # assign value of 1 to each farmers
#  coordinates(farmers2) <- ~lon + lat
#  farmers2$ct <- 1  # assign value of 1 to each farmers
#  zamr2 <- raster(x = extent(districts), crs = crs(districts), res = 0.25)
#  farmersr <- rasterize(farmers2, zamr2, field = "ct", fun = sum)
#  
#  raintot <- calc(chirpsz, sum)

## ----dem, eval=FALSE-----------------------------------------------------
#  dem <- getData(name = "alt", country = "ZMB", path = "../external/unit2/data/")
#  plot_noaxes(dem, main = "Zambia DEM", legend.args = list(text = "meters"))

## ---- eval = FALSE, echo = FALSE-----------------------------------------
#  dem <- dem * 1
#  save(dem, file = "data/dem.rda")

## ---- echo = FALSE-------------------------------------------------------
data(dem)
plot_noaxes(dem, main = "Zambia DEM", legend.args = list(text = "meters"))

## ----demarea-------------------------------------------------------------
demarea <- area(dem)
plot_noaxes(demarea, legend.args = list(text = expression("km"^2)), 
            main = paste("DEM pixel area, mean = ", 
                         round(cellStats(demarea, mean), 3)))
plot(districts, add = TRUE)

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

## ----terrain-------------------------------------------------------------
# Block 1
zamr <- raster(x = extent(districts), crs = crs(districts), res = res(dem))
values(zamr) <- 1:ncell(zamr)
zamr_alb <- projectRaster(from = zamr, res = 1000, crs = crs(roads), 
                          method = "ngb")
demalb <- projectRaster(from = dem, to = zamr_alb)  # default is bilinear

# Block 2
# slope <- terrain(x = demalb, opt = 'slope', unit = 'degrees')  # slope
# aspect <- terrain(x = demalb, opt = 'aspect', unit = 'degrees')  # aspect
# flowdir <- terrain(x = demalb, opt = 'flowdir')  # flow direction
# tri <- terrain(x = demalb, opt = 'tri')  # topographic roughness index
vars <- c("slope", "aspect", "flowdir", "tri")
terrvars <- stack(lapply(1:length(vars), function(x) {
  tv <- terrain(x = demalb, opt = vars[x], unit = "degrees")
}))
names(terrvars) <- vars

plot_noaxes(terrvars)

## ----interpolate, eval = FALSE-------------------------------------------
#  # install.packages("gstat")
#  library(gstat)
#  
#  # Block 1
#  raintotalb <- projectRaster(from = raintot, res = 5000, crs = crs(roads))
#  names(raintotalb) <- "rain"
#  r <- raster(extent(raintotalb), res = res(raintotalb), crs = crs(raintotalb),
#              vals = 1)
#  
#  # Block 2
#  set.seed(1)
#  rainsamp <- sampleRandom(raintotalb, size = 1000, xy = TRUE)
#  rainsamp <- as.data.frame(rainsamp)
#  # head(rainsamp)
#  
#  # Block 3
#  invdist <- gstat(id = "rain", formula = rain ~ 1, locations = ~x + y,
#                   data = rainsamp)
#  invdistr <- interpolate(object = r, model = invdist)
#  invdistrmsk <- mask(x = invdistr, mask = raintotalb)
#  
#  # Block 4
#  coordinates(rainsamp) <- ~x + y  #1
#  crs(rainsamp) <- crs(roads)  #2
#  v <- variogram(object = rain ~ 1, data = rainsamp)  #3
#  m <- fit.variogram(object = v, model = vgm("Sph"))  #4
#  m
#  plot(variogramLine(m, max(v[, 2])), type = "l")  #5
#  points(v[, 2:3], pch = 20)  #6
#  legend("bottomright", legend = c("variogram fit", "variogram"), lty = c(1, NA),
#         pch = c(NA, 20), bty = "n") #7
#  
#  # Block 5
#  ordkrig <- gstat(id = "rain", formula = rain ~ 1, data = rainsamp, model= m)
#  ordkrigr <- interpolate(object = r, model = ordkrig)
#  ordkrigrmsk <- mask(x = ordkrigr, mask = raintotalb)
#  
#  # Block 6
#  raininterp <- stack(raintotalb, invdistrmsk, ordkrigrmsk)
#  names(raininterp) <- c("Actual rain", "IDW rain", "Kriged rain")
#  par(mfrow = c(2, 2), mar = c(0, 0, 1, 0))
#  plot(rainsamp, pch = 20, cex = 0.5)
#  for(i in 1:3) plot_noaxes(raininterp[[i]], main = names(raininterp)[i])

## ---- eval = FALSE, echo = FALSE-----------------------------------------
#  png("fig/interpolate.png", height = 400, width = 600)
#  raininterp <- stack(raintotalb, invdistrmsk, ordkrigrmsk)
#  names(raininterp) <- c("Actual rain", "IDW rain", "Kriged rain")
#  par(mfrow = c(2, 2), mar = c(0, 0, 1, 0))
#  plot(rainsamp, pch = 20, cex = 0.5)
#  for(i in 1:3) plot_noaxes(raininterp[[i]], main = names(raininterp)[i])
#  dev.off()

## ---- echo = FALSE-------------------------------------------------------
# rebuild raintotalb
raintotalb <- projectRaster(from = raintot, res = 5000, crs = crs(roads))
names(raintotalb) <- "rain"

## ---- fig.width=6.5, fig.height=4----------------------------------------
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

