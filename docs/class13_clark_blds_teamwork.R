# Title     : Script to plot buildings at Clark
# Objective : Create polygons and plot them.
# Created by: GEOG 246/346 Spring 2021
# Created on: 04/03/21

# Load packages=====
library(dplyr)
library(sf)
library(leaflet)
library(RColorBrewer)
library(ggplot2)
library(mapview)

# Create polygons=======================================
# Main campus - Lei
coords <- rbind(c(-71.82117553759312, 42.25084734394512),
                c(-71.82212771135572, 42.25194565868353),
                c(-71.82156280512835, 42.252417357356265),
                c(-71.82316986959349, 42.25367904720517),
                c(-71.82545037620447, 42.2518579577067),
                c(-71.82587265873052, 42.25131095436722),
                c(-71.8236126925188, 42.249563032541396),
                # repeat the first point
                c(-71.82117553759312, 42.25084734394512))
clark_campus_ply <- st_polygon(list(coords)) %>% # create sfc
  st_sfc() %>% st_set_crs(4326) %>%  # create sfc
  st_sf() %>% mutate(name = 'Clark main campus')

# Math and physics building - Sophie
coords <- rbind(c(-71.82393039239071, 42.25029125533269),
                c(-71.82411245347981, 42.250467158275576),
                c(-71.82404154525784, 42.2505111339837),
                c(-71.82416803037283, 42.25063171258245),
                c(-71.82456856454016, 42.250416089670466),
                c(-71.8245072384403, 42.2503579282911),
                c(-71.82439991808675, 42.25039622979893),
                c(-71.82434050860395, 42.25034090548506),
                c(-71.82426001827238, 42.25038062544141),
                c(-71.82408179057461, 42.25020614076214),
                c(-71.82393039239071, 42.25029125533269))
clark_math_phys <- st_polygon(list(coords)) %>% st_sfc() %>%
  st_sf() %>% st_set_crs(4326) %>%
  mutate(name = "CS, Mathematics, and Physics")

# Atwood hall - Tom
atwood_coord <- rbind(c(-71.82207, 42.25160),
                      c(-71.82156, 42.25105),
                      c(-71.82154, 42.25104),
                      c(-71.82151, 42.25102),
                      c(-71.82150, 42.25102),
                      c(-71.82149, 42.25101),
                      c(-71.82148, 42.25101),
                      c(-71.82136, 42.25089),
                      c(-71.82160, 42.25077),
                      c(-71.82168, 42.25085),
                      c(-71.82173, 42.25082),
                      c(-71.82173, 42.25080),
                      c(-71.82171, 42.25077),
                      c(-71.82173, 42.25076),
                      c(-71.82170, 42.25073),
                      c(-71.82189, 42.25063),
                      c(-71.82189, 42.25062),
                      c(-71.82196, 42.25058),
                      c(-71.82198, 42.25058),
                      c(-71.82204, 42.25055),
                      c(-71.82216, 42.25068),
                      c(-71.82182, 42.25085),
                      c(-71.82182, 42.25085),
                      c(-71.82180, 42.25085),
                      c(-71.82176, 42.25085),
                      c(-71.82171, 42.25088),
                      c(-71.82171, 42.25088),
                      c(-71.82168, 42.25090),
                      c(-71.82174, 42.25096),
                      c(-71.82173, 42.25096),
                      c(-71.82192, 42.25116),
                      c(-71.82194, 42.25115),
                      c(-71.82219, 42.25142),
                      c(-71.82222, 42.25140),
                      c(-71.82229, 42.25148),
                      c(-71.82225, 42.25150),
                      c(-71.82226, 42.25150),
                      c(-71.82212, 42.25157),
                      c(-71.82207, 42.25160))
atwood_esri <- st_polygon(list(atwood_coord)) %>% # create sfc
  st_sfc() %>% st_set_crs(4326) %>%  # create sfc
  st_sf() %>% mutate(name = "Atwood Hall")

# Kneller athletic center - Danielle
coords <- rbind(c(-71.82439796970183, 42.252175487709735),
                c(-71.82386089239114, 42.252586593284256),
                c(-71.82336176840901, 42.25221523581643),
                c(-71.8238627053235, 42.2518319555434),
                c(-71.82419703573785, 42.252081716625185),
                c(-71.8242349574394, 42.252053074312876),
                c(-71.82439796970183, 42.252175487709735))
kneller_athl <- st_polygon(list(coords)) %>%
  st_sfc() %>% st_set_crs(4326) %>%
  st_sf() %>% mutate(name = "Kneller Athletic Center")

# Higgins - Morgan
coords <- rbind(c(-71.82406422645192, 42.25063671141722),
                c(-71.82361763867316, 42.25088389319217),
                c(-71.82342586073958, 42.250700244176414),
                c(-71.82338965090528, 42.25069528068216),
                c(-71.82339702697966, 42.25065954351143),
                c(-71.82319787296478, 42.250455543438385),
                c(-71.8231904968857, 42.250460010598815),
                c(-71.82308924350119, 42.25044958722056),
                c(-71.82307985577017, 42.25043966019206),
                c(-71.82309125514941, 42.250370170946375),
                c(-71.82297189685094, 42.25025352811449),
                c(-71.82293903979237, 42.250271396817396),
                c(-71.82278615388408, 42.250125468927806),
                c(-71.82303090545366, 42.2499874823794),
                c(-71.8230590686467, 42.250016270964124),
                c(-71.82347749324916, 42.249782983775404),
                c(-71.82345469447382, 42.24976064772303),
                c(-71.82356399448491, 42.249699595806185),
                c(-71.82377790065081, 42.249901116543725),
                c(-71.8236303791642, 42.24998400789498),
                c(-71.82360422762781, 42.24996067920332),
                c(-71.823199884626, 42.250190491262806),
                c(-71.8232790097874, 42.250265936938284),
                c(-71.82337892206749, 42.25027536764137),
                c(-71.8233883097985, 42.25028479834307),
                c(-71.8233883097985, 42.25028529469574),
                c(-71.8233883097985, 42.25028579104842),
                c(-71.8233748987542, 42.25035776214525),
                c(-71.82335880550342, 42.25036818554106),
                c(-71.82355594786455, 42.25056722239293),
                c(-71.82384763809222, 42.25040243382428),
                c(-71.82406221480773, 42.25063720777184),
                c(-71.82406422645192, 42.25063671141722))
higgins_sackler <- st_polygon(list(coords)) %>%
  st_sfc() %>% st_set_crs(4326) %>%
  st_sf() %>% mutate(name = "Higgins University Center")

# Estabrook hall - Ruhua
coords <- rbind(c(-71.82210224288923, 42.25271579651383),
                c(-71.8221149605771, 42.25270627790321),
                c(-71.82211764278598, 42.2527097522385),
                c(-71.82214513542701, 42.25268940255761),
                c(-71.82214178266591, 42.25268642455497),
                c(-71.82218536856023, 42.25265664452089),
                c(-71.82218805076911, 42.252658629856946),
                c(-71.82222291948456, 42.25263629482285),
                c(-71.82214111211368, 42.25257524568934),
                c(-71.82214982929256, 42.25256978600814),
                c(-71.82214848818812, 42.25256978600814),
                c(-71.82184137526676, 42.25233948628404),
                c(-71.82183198753033, 42.25234693133036),
                c(-71.82182863476925, 42.25234395331157),
                c(-71.82170726481736, 42.252434286486064),
                c(-71.82201236608361, 42.25266011885911),
                c(-71.82201907160582, 42.252656148187064),
                c(-71.82210224288923, 42.25271579651383))
cu_estabrook_hall <- st_polygon(list(coords)) %>%
  st_sfc() %>% st_set_crs(4326) %>%
  st_sf() %>% mutate(name = "Estabrook Hall")

# Library - Lara
coords <- rbind(c(-71.8230987, 42.2514347),
                c(-71.8230960, 42.2514347),
                c(-71.8229699, 42.2514963),
                c(-71.8230048, 42.2515459),
                c(-71.8228143, 42.2516491),
                c(-71.8226588, 42.2517087),
                c(-71.8226776, 42.2517405),
                c(-71.8226320, 42.2517941),
                c(-71.8230718, 42.2520859),
                c(-71.8231148, 42.2520482),
                c(-71.8230879, 42.2520244),
                c(-71.8232435, 42.2519092),
                c(-71.8232971, 42.2519410),
                c(-71.8233669, 42.2518854),
                c(-71.8233401, 42.2518636),
                c(-71.8235171, 42.2517226),
                c(-71.8233991, 42.2516015),
                c(-71.8233696, 42.2516194),
                c(-71.8231738, 42.2514169),
                c(-71.8231094, 42.2514546),
                c(-71.8230987, 42.2514347))
clark_goddard <- st_polygon(list(coords)) %>%
  st_sfc() %>% st_set_crs(4326) %>%
  st_sf() %>% mutate(name = "Robert H. Goddard Library & Academic Commons")

# Dana commons - Lia
coords <- rbind(c(-71.82530, 42.25136),
                c(-71.82507, 42.25119),
                c(-71.82534, 42.25100),
                c(-71.82551, 42.25112),
                c(-71.82548, 42.25114),
                c(-71.82555, 42.25119),
                c(-71.82530, 42.25136))
dana_commons_ply <- st_polygon(list(coords)) %>% st_sfc() %>%
  st_set_crs(4326) %>% st_sf() %>% mutate(name = "Dana Commons")

# Carlson hall - Sarah
coords <- rbind(c(-71.82443790272043, 42.250817992384235),
                c(-71.82458274149204, 42.25097186003828),
                c(-71.82458810590163, 42.25098575774715),
                c(-71.82453312062859, 42.25101653122979),
                c(-71.82454921386054, 42.251037377802675),
                c(-71.82454384943857, 42.251041348575946),
                c(-71.82455323716616, 42.25104829743418),
                c(-71.82456798927937, 42.251044326259645),
                c(-71.82463772676483, 42.25111480750027),
                c(-71.8246430912017, 42.25113168329076),
                c(-71.82461895128884, 42.25115352255891),
                c(-71.82462163350826, 42.251167420268494),
                c(-71.82453580258719, 42.2512140768603),
                c(-71.82448484045878, 42.25121804759888),
                c(-71.82448349935133, 42.25121705490439),
                c(-71.82441107972465, 42.25114161008549),
                c(-71.82442046748515, 42.251137639326046),
                c(-71.82437889330197, 42.25110090958896),
                c(-71.82431317894431, 42.25113267564812),
                c(-71.82431452005545, 42.25113168295793),
                c(-71.82416565818014, 42.25098079303914),
                c(-71.82416699939084, 42.2509649099416),
                c(-71.82416565828703, 42.25096490993569),
                c(-71.82422064373375, 42.25093413662688),
                c(-71.82423673726109,42.250881523904276),
                c(-71.8242233263504, 42.250861669978086),
                c(-71.82429038160133, 42.250824940512686),
                c(-71.82431049807124, 42.25083486750809),
                c(-71.82434402563699, 42.25082295526489),
                c(-71.8243721886518, 42.250851743455286),
                c(-71.82437352975239, 42.250851743458874),
                c(-71.82443924377891, 42.25081799198152))
carlson_hall <- st_linestring(coords) %>% # create sfg
  st_cast('POLYGON') %>%
  st_sfc() %>% st_set_crs(4326) %>% # create sfc
  st_sf() %>% # build sf
  mutate(name = "Carlson Hall")

# Little center - Ashna
coords <- rbind ( c(-71.82237432392284, 42.252619945745685),
                  c(-71.82258612445072, 42.25277711831066),
                  c(-71.82267977958945, 42.252717371350926),
                  c(-71.82269595689753, 42.25272750338386),
                  c(-71.822804220421, 42.252646447074994),
                  c(-71.82279053192954, 42.252633551743514),
                  c(-71.82286929956557, 42.25256751582313),
                  c(-71.8226598690564, 42.25240788301601),
                  c(-71.82257400488261, 42.25247051768256),
                  c(-71.8225416502664, 42.2524511746304),
                  c(-71.82243214233462, 42.2525349944802),
                  c(-71.82245951931756, 42.25255710079565),
                  c(-71.82237432392284, 42.252619945745685))
little_center <- st_polygon(list(coords)) %>%
  st_sfc() %>% st_set_crs(4326) %>%
  st_sf() %>% mutate(name = "Little Center")

# Jonas Clark hall
jonas <- rbind(c(42.25073971066906, -71.82325961386029),
                c(42.2507777725669, -71.82318350005451),
                c(42.25078223970596, -71.82318551171117),
                c(42.25084875040589, -71.82305810678872),
                c(42.25083237091165, -71.8230406724309),
                c(42.25091029755825, -71.8228891276284),
                c(42.25099269123274, -71.82278452148155),
                c(42.250988720455716, -71.82277915706375),
                c(42.251034384379025, -71.82269466747479),
                c(42.25113415000695, -71.8227925681005),
                c(42.25115301115209, -71.82275904048932),
                c(42.25120463109945, -71.82281000245831),
                c(42.25118676266091, -71.82284621227836),
                c(42.251274119423435, -71.82293539572409),
                c(42.251233101414996, -71.82301271143761),
                c(42.251168576503304, -71.82312268200226),
                c(42.251181481490924, -71.82313743415118),
                c(42.251096606328346, -71.8232997078066),
                c(42.25108370132338, -71.82329099062768),
                c(42.250977483105125, -71.82349819126475),
                c(42.25087821357723, -71.82340431395349),
                c(42.250858856001734, -71.8234391826691),
                c(42.25081666639184, -71.8233969378754),
                c(42.25083503128357, -71.82335938695088)) %>%
  `[`(, ncol(.):1) %>% st_linestring() %>% # create sfg
  st_cast('POLYGON') %>%
  st_sfc() %>% st_set_crs(4326) %>% # create sfc
  st_sf() %>% # build sf
  mutate(name = "Jonas Clark Hall")

# Combine them
buildings_clark <- rbind(atwood_esri, carlson_hall,
                         clark_goddard, clark_math_phys,
                         cu_estabrook_hall, jonas,
                         dana_commons_ply, higgins_sackler,
                         kneller_athl, little_center) %>%
  group_by(name) %>%
  mutate(label = str_extract_all(name, '[A-Z]')
         %>% unlist() %>% paste0(collapse = '')) %>%
  ungroup()

# Plot -- Base plot ==================================
cols <- rainbow(10)
# sf way to define colors
# cols <- sf.colors(10)
plot(clark_campus_ply %>% st_geometry(),
     col = 'lightblue', axes = TRUE,
     main = 'Clark Campus')
plot(st_geometry(clark_math_phys), add = T, col = cols[1])
plot(atwood_esri$geometry, add = T, col = cols[2])
plot(kneller_athl$geometry, add = T, col = cols[3])
plot(higgins_sackler$geometry, add = T, col = cols[4])
plot(cu_estabrook_hall$geometry, add = T, col = cols[5])
plot(clark_goddard$geometry, add = T, col = cols[6])
plot(dana_commons_ply$geometry, add = T, col = cols[7])
plot(carlson_hall$geometry, add = T, col = cols[8])
plot(little_center$geometry, add = T, col = cols[9])
plot(jonas$geometry, add = T, col = cols[10])

# Use combined one
## Plot geometry, default is no axes.
plot(buildings_clark %>% st_geometry(),
     col = 'lightblue', border = 'orange',
     lty = 4, lwd = 2, axes = TRUE,
     graticule = st_crs(buildings_clark))

## plot attribute,
## could plot multiple attributes together
## but not very nice.
plot(buildings_clark['label'],
     main = 'Clark Buildings',
     key.pos = 4, key.width = lcm(4),
     # Must set reset = FALSE to add more layers
     axes = TRUE, reset = FALSE)
plot(buildings_clark %>% st_centroid() %>%
       st_geometry(), add = T, pch = 20, col = 'red')

# Plot - ggplot2=====================================
ggplot(clark_campus_ply) +
  geom_sf(fill = 'pink') +
  # Must set data = ... to add more layers.
  geom_sf(data = buildings_clark, aes(fill = name)) +
  scale_fill_brewer(palette = 'Paired') +
  ggtitle("Clark Campus") +
  theme_bw()

# Plot - Leaflet========================================
ctr_campus <- st_coordinates(st_centroid(clark_campus_ply))
leaflet() %>%
  # Set default view
  setView(ctr_campus[1], ctr_campus[2], zoom = 17) %>%
  # Base layer groups
  addProviderTiles(providers$Esri.WorldImagery,
                   group = 'Esri Satellite') %>%
  # addTiles() # Default OSM base layer
  # Overlay layer groups
  addPolygons(data = clark_campus_ply, fillColor = 'pink',
              color = 'red', fillOpacity = 0.4,
              group = "Clark Main Campus") %>%
  addPolygons(data = buildings_clark,
              fillColor = ~brewer.pal(10, "Paired"),
              weight = 2, opacity = 1,
              color = 'darkgrey', fillOpacity = 1,
              highlightOptions =
                highlightOptions(color = "white",
                                 weight = 2,
                                 bringToFront = TRUE),
              label = ~ name,
              group = "Clark Buildings") %>%
  # Layer control
  addLayersControl(
    baseGroups = c("Esri Satellite"),
    overlayGroups = c("Clark Main Campus", "Clark Buildings"),
    options = layersControlOptions(collapsed = FALSE)
  )

# Plot - mapview======================================
mapview(clark_campus_ply, legend = F,
        layer.name = 'Clark Campus') +
  mapview(buildings_clark, zcol = 'name',
          col.regions = sf.colors(10), fgb = F,
          layer.name = 'Buildings') +
  mapview(st_centroid(buildings_clark),
          col.regions = 'red', legend = F,
          layer.name = 'Centroids')
