library(raster)

# Basic raster============================
# Get raster
dsn <- system.file('extdata/terrvars.tif',
                   package = 'geospaar')
terrs <- stack(dsn)

# Subset a raster stack or brick
l1_terrs <- terrs$terrvars.1
l1_terrs <- terrs[['terrvars.1']]
l1_terrs <- subset(terrs, 'terrvars.1')

## Attributes
terrs@crs@projargs
# Or use functions
extent(terrs)
ncell(terrs)
nlayers(terrs)
crs(terrs)
minValue(terrs)
maxValue(terrs)
freq(terrs$terrvars.1) %>% head()

# Load values from disk
getValues(terrs)

# create a new raster based on a template
rst <- raster(terrs)
# If we give a raster factors, it will become a categorical map
set.seed(10)
values(rst) <- as.factor(
  sample(letters, replace = T,
         size = length(rst)))
# Then we could check levels in the same way as factor
levels(rst)[[1]]

# Re-project=====================================
## Use a defined CRS object
rst_lonlat <- projectRaster(
  rst, crs = CRS("+init=epsg:4326"))
## Or get crs from an existing object
rst <- projectRaster(rst_lonlat, crs = crs(dem))
## Or directly use an existing object
rst <- projectRaster(rst, rst_lonlat)
