if (!require(pacman)) install.packages("pacman")

pacman::p_load(tidyverse,
               terra,
               tidyterra,
               mapview,
               stars)

# rast() is a func

(spr_ex <- rast("data/spr_example.tif"))

#function to read data from your directory
writeRaster(x = spr_ex,
            filename = "data/spr_elev.tif",
            overwrite = TRUE)

#visualize raster data; geom_spatraster()( from "tidyterre")
ggplot() +
  geom_spatraster(
    data = spr_ex
  )


# if you want mapview() function to work.
star_ex <- st_as_stars(spr_ex)
mapview(star_ex)

# continuous case
v_elev <- values(spr_ex)
head(v_elev)

extract(spr_ex, y = cbind(6.0000, 50.0000))

extract(spr_ex, y = cbind(5.9, 49.85))

extract(spr_ex, y = cbind(5.8, 49.6))


# extract data at mutiple points
df_point <- tibble(
  lon = c(6, 5.9),
  lat = c(50, 49.96)
)

extract(spr_ex, y = df_point)

#discrete data

## load forest raster
(spr_for <- rast("data/spr_forest_nc.tif"))

ggplot() +
  geom_spatraster(data = spr_for)

unique(spr_for)

v_binary <- values(spr_for)
mean(v_binary)*100


#multiple classes - code values with multiple categories.
(spr_land <- rast("data/spr_land_reclass.tif"))
unique(spr_land)

extract(spr_land, cbind(-79.8063, 36.0701))




# write a conversion matrix
# left, original value
# right, value after conversion
(cm <- cbind(c(0, 1001, 1010, 1100),
             c(0, 1, 0, 0)))

spr_bin <- classify(spr_land,
                    rcl = cm)

unique(spr_bin)
v_bin <- values(spr_bin)
mean(v_bin)* 100

# calculate % cropland
cm_crop <- cbind(
  c(0, 1001, 1010, 1100),
  c(0, 0, 1, 0)
)
spr_crop <- classify(
  x = spr_land,
  rcl = cm_crop
)

v_crop <- values(spr_crop)
mean(v_crop)*100


#exercise

#Q1 
spr_prec_ncne <- terra::rast("data/spr_prec_ncne.tif")

#Q2
spr_prec_ncne

#Q3
ggplot() +
  tidyterra::geom_spatraster(data = spr_prec_ncne)

#Q4
sf_site <- readRDS("data/sf_finsync_nc.rds")

#Q5

df_xy <- st_coordinates(sf_site)

#Q6
df_land <- terra::extract(spr_land, df_xy)

#Q7
df_land %>%
  count(2, sort = TRUE)

#Q8

freq(spr_land)

#Q9

spr_urban <- terra::ifel(spr_land == 1, 1, 0)

#Q10

terra::global(spr_urban, "mean", na.rm = TRUE)

