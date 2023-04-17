#load packages

install.packages("C:/Users/micha/Downloads/RStoolbox_0.3.0.tar", repos=NULL, type="source")
library(raster)
library(RStoolbox)
library(sf)
library(dplyr)


#load an example dataset
#data(lsat)

lsat <- brick("C:/Users/micha/Downloads/Landsat8SR_SD_July2019_scale.tif")

mountain <- st_read("C:/Users/micha/Downloads/drive-download-20230225T211054Z-001/mountain.shp")
mountain_spec <- extract(lsat, mountain, fun = 'mean')

water <- st_read("C:/Users/micha/Downloads/drive-download-20230225T211054Z-001/water.shp")
water_spec <- extract(lsat, water, fun = 'mean')

residential <- st_read("C:/Users/micha/Downloads/drive-download-20230225T211054Z-001/residential.shp")
residential_spec <- extract(lsat, residential, fun = 'mean')

urban <- st_read("C:/Users/micha/Downloads/drive-download-20230225T211054Z-001/urban.shp")
urban_spec <- extract(lsat, urban, fun = 'mean')





#make up some endmember spectra: water and land
em_names <- c("mountain", "water", "residential", "urban")
#pts <- data.frame(class=em_names, cell = c(47916,5294))
em <- rbind(mountain_spec[1,],
            water_spec[1,] + 0.0000001,
            residential_spec[1,],
            urban_spec[1,])
rownames(em) <- em_names


probs <- mesma(lsat, em, method = "NNLS", iterate = 5000)

raster::plot(probs)
sum_rast <- probs[['mountain']] + probs[['water']] + probs[['residential']] + probs[['urban']]
probs_adj <- probs

for(name in em_names){
  probs_adj[[name]] <- probs_adj[[name]]/sum_rast
}


a <- st_read("C:/Users/micha/Downloads/Endmembers/BiophysicalEndmembers.shp")
a_em <- extract(lsat, st_centroid(a)) %>% cbind(a, .)
a_group <- a_em %>% group_by(class) %>%
  summarise(mean_b1 = mean(Landsat8SR_SD_July2019_scale_1),
                                                  mean_b2 = mean(Landsat8SR_SD_July2019_scale_2),
                                                  mean_b3 = mean(Landsat8SR_SD_July2019_scale_3),
                                                  mean_b4 = mean(Landsat8SR_SD_July2019_scale_4),
                                                  mean_b5 = mean(Landsat8SR_SD_July2019_scale_5)) %>%
  st_drop_geometry()

a_group <- a_group[, grepl( "mean", names(a_group))]

#a_group[4,] <- c(0.000001)
probs_a <- mesma(lsat,
                 a_group[1:3, ],
                 method = "NNLS",
                 iterate = 1000)

sum_adj_rast <- sum(probs_a[[-1]])

b <- st_read("C:/Users/micha/Downloads/Endmembers/TaxonomicEndmembers.shp")
b_em <- extract(lsat, st_centroid(b)) %>% cbind(b, .)
b_group <- b_em %>% group_by(class) %>%
  summarise(mean_b1 = mean(Landsat8SR_SD_July2019_scale_1),
            mean_b2 = mean(Landsat8SR_SD_July2019_scale_2),
            mean_b3 = mean(Landsat8SR_SD_July2019_scale_3),
            mean_b4 = mean(Landsat8SR_SD_July2019_scale_4),
            mean_b5 = mean(Landsat8SR_SD_July2019_scale_5)) %>%
  st_drop_geometry()

class_names <-  b_group$class

b_group <- b_group %>% select(-class)
rownames(b_group) <- class_names

probs_b <- mesma(lsat,
                 b_group,
                 method = "NNLS",
                 iterate = 1000)

plot(probs_b)

sum_b <- sum(probs_b) - probs_b[['RMSE']]

raster::plot(sum_b)

probs_b_adj <- probs_b
#sum_b_adj <- sum(probs_b_adj)

for(band in class_names){
  print(band)
  probs_b_adj[[band]] <- probs_b_adj[[band]]/sum_b
}

summary(probs_b_adj)

sum_b_adj <- sum(probs_b_adj) - probs_b_adj[['RMSE']]
summary(sum_b_adj)
plot(sum_b_adj)

#install.packages('hsdar')
library(hsdar)


unmix(spectra, endmember, returnHCR = "auto", scale = FALSE, ...)
