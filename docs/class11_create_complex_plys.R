# Title     : Script to create complex polygons from scratch
# Objective : Create sf polygons.
# Created by: Lei Song
# Created on: 03/29/21

# Define coords matrics=============================
## regular but tedious way to specify coords matrix in right order
coords <- rbind(c(-71.82117553759312, 42.25084734394512),
                c(-71.82212771135572, 42.25194565868353),
                c(-71.82156280512835, 42.252417357356265),
                c(-71.82316986959349, 42.25367904720517),
                c(-71.82545037620447, 42.2518579577067),
                c(-71.82587265873052, 42.25131095436722),
                c(-71.8236126925188, 42.249563032541396),
                c(-71.82117553759312, 42.25084734394512))
coords_hole <- rbind(c(42.250752539789936, -71.82286910793475),
                     c(42.25122903303232, -71.82209663177332),
                     c(42.250947108298725, -71.82195179249305),
                     c(42.250657240709515, -71.82237558149828),
                     c(42.250752539789936, -71.82286910793475))
## Use [] to reshape the matrix
coords_hole <- coords_hole[, ncol(coords_hole):1]
## Put them together into a pipeline
unversity_park <- rbind(c(42.249469593141114, -71.82345056718931),
                        c(42.248967301194284, -71.82310488341018),
                        c(42.24555540098775, -71.82201661966104),
                        c(42.24721398663701, -71.81934077114846),
                        c(42.249867632975345, -71.82281041204276),
                        c(42.249469593141114, -71.82345056718931)) %>%
  `[`(, ncol(.):1) # right, [] is actually a function
# Define a polygon with multiple parts and holes=========================
# HOW TO: give st_polygon a list of multiple items
# clark_ply_withhole is a polygon with hole and separate parts.
# it is not very easy to split two separate parts into two polygons
# since we use st_polygon
clark_ply_withhole <- st_polygon(list(coords,
                                      coords_hole,
                                      unversity_park)) %>% # create sfc
  st_sfc() %>%
  st_sf() %>% st_set_crs(4326)
plot(clark_ply_withhole$geometry, col = 'red')
# Define a multipolygon with multiple parts and holes=========================
# HOW TO: give st_multipolygon a list of lists.
# clark_ply_separate is a polygon collection of a polygon with hole
# and another polygon without hole.
# it is easy to cast into two separate polygons
# since we use st_multipolygon
clark_ply_separate <- st_multipolygon(
  list(list(coords, coords_hole),
       list(unversity_park))) %>% # create sfc
  st_sfc() %>% st_cast('POLYGON') %>%
  st_sf() %>% st_set_crs(4326)
plot(clark_ply_separate$geometry, border = 'red')
plot(clark_ply_separate$geometry[1], col = 'blue',
     border = 'transparent', add = T)
plot(clark_ply_separate$geometry[2], col = 'yellow',
     border = 'transparent', add = T)
