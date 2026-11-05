if (!require(pacman)) install.packages("pacman")

pacman::p_load(tidyverse,
               sf,
               mapview)

# erase all objects in enviroment
rm(list = ls())


sf_site <-readRDS("data/sf_finsync_nc.rds")
sf_nc_county <- readRDS("data/sf_nc_county.rds")

mapview(sf_nc_county, legend = FALSE) + mapview(sf_site, legend = FALSE)

sf_site_join <- st_join(sf_site,
                        sf_nc_county)

# how many sites in guilford county
sf_site_guilford <- sf_site_join %>% 
  filter(county == "guilford")

# how many sites in clay county
sf_site_clay <- sf_site_join %>% 
  filter(county == "clay")

## re-read stream layer
sf_str <- readRDS("data/sf_stream_gi.rds")

# produce map with guilford county polygon, sites found within guilford,use ggplot()

sf_gi_county <- sf_nc_county %>% 
  filter(county == "guilford")

 ggplot() +
  geom_sf(data = sf_gi_county) +
  geom_sf(data = sf_str) + 
  geom_sf(data = sf_site_guilford)
 
 
 ## geometric analysis
 sf_str_proj <- st_transform(sf_str, crs = 32617)
 #calculate the length of each stream line segment

 v_str_l <-  st_length(sf_str_proj)
 head(v_str_l)
 
sf_str_w_len <- sf_str %>% 
   mutate(length = v_str_l)

#area#

sf_nc_county_proj <- st_transform(sf_nc_county, crs = 32617)

#calculate the area of county polygons
v_area <- st_area(sf_nc_county_proj)


# create column area in sf_nc_county_proj, an d identify which county is largest

sf_nc_county_w_area <-sf_nc_county_proj %>% 
  mutate(area = as.numeric(v_area) / 1E+6) %>%
           arrange(desc(area))

#subset
sf_county1k <- sf_nc_county_w_area %>% 
  filter(area > 1000)

ggplot() +
          geom_sf(data = sf_county1k)



#### exercise

1#
sf_nz <- readRDS("data/sf_nz.rds")
sf_quakes <- readRDS("data/sf_quakes.rds")

2#
sf_quakes_join <- st_join(x = sf_quakes,
                          y = sf_nz)


mapview(sf_nz) + mapview(sf_quakes)

sf_quakes_join <- st_join(sf_quakes, sf_nz)

sf_quakes <- drop_na(sf_quakes_join, fid)

nrow("sf_quakes_nz")



sf_site_join
3#

df_n <- sf_site_join %>% 
  as_tibble() %>% 
  group_by(county) %>% 
  summarize(n = n())

sf_n_site <- left_join(sf_nc_county,
                       df_n)

sf_n10 <- sf_n_site %>% 
  filter(n > 10)

 #4 
ggplot() +
  geom_sf(data = sf_nc_county) +
  geom_sf(data = sf_n_site %>% 
            filter(n > 1),
          fill = "grey") +
  
  geom_sf(data = sf_n10,
          fill = "salmon")







