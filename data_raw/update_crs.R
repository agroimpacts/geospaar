
# update projection systems in files
roads <- system.file("extdata/roads.shp", package = "geospaar") %>% st_read
districts <- system.file("extdata/districts.shp", package = "geospaar") %>%
  st_read
roads %>% st_transform("ESRI:102022") %>%
  st_write("inst/extdata/roads.shp", delete_dsn = TRUE)

zambia <- getData(name = "GADM", country = 'ZMB', level = 0)
zambia <- st_as_sf(zambia)
districts <- st_transform(districts, crs = st_crs(zambia))
districts %>%
  st_write("inst/extdata/districts.shp", delete_dsn = TRUE)

data(chirps)
crs(chirps) <- crs("EPSG:4326")
usethis::use_data(chirps, overwrite = TRUE)

data(chirpsz)
crs(chirpsz) <- crs("EPSG:4326")
usethis::use_data(chirpsz, overwrite = TRUE)

data(rain_stack)
crs(rain_stack) <- crs("EPSG:4326")
usethis::use_data(rain_stack, overwrite = TRUE)

data(dem)
crs(dem) <- crs("EPSG:4326")
usethis::use_data(dem, overwrite = TRUE)

demalb <- raster(system.file("extdata", "demalb.tif", package = "geospaar"))
crs(demalb) <- crs("ESRI:102022")
demalb <- writeRaster(demalb, filename = "inst/extdata/demalb.tif",
                      overwrite = TRUE)
raster("inst/extdata/demalb.tif")

data(zamprec)
crs(zamprec) <- crs("EPSG:4326")
usethis::use_data(zamprec, overwrite = TRUE)

terrvars <- brick(system.file("extdata", "terrvars.tif", package = "geospaar"))
crs(terrvars) <- crs("ESRI:102022")
writeRaster(terrvars, filename = "inst/extdata/terrvars.tif", overwrite = TRUE)
brick("inst/extdata/terrvars.tif")

