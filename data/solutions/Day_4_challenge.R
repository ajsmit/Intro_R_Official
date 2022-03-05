library(tidyverse)
library(raster)
library(sf)
library(cmocean)


# load GEBCO data ---------------------------------------------------------

# load the data
bathy <- read_delim("data/gebco_sa.asc", delim = " ", col_names = FALSE, skip = 6)
bathy_info <- read_csv("data/gebco_sa.asc", col_names = FALSE, n_max = 6)

# create lon/lat vectors
lon <- seq(from = as.numeric(bathy_info[3, 2]), by = as.numeric(bathy_info[5, 2]), length.out = as.numeric(bathy_info[1, 2]))
lat <- rev(seq(from = as.numeric(bathy_info[4, 2]), by = as.numeric(bathy_info[5, 2]), length.out = as.numeric(bathy_info[2, 2])))

# add column names for the longitude columns
colnames(bathy) <- lon

# add lats as a column at the start of the bathy/lon data and save
bathy_wide <- as_tibble(cbind(lat, bathy))
save(bathy_wide, file = "data/gebco_sa.Rdata")

load("data/gebco_sa.Rdata")
# the dimensions of the dataset?
dim(bathy_wide)

# what is the range of the lons for bathy_wide?
range(as.numeric(colnames(bathy_wide[,2:ncol(bathy_wide)])))

# what is the length of the lons for bathy_wide?
n_lons <- length(as.numeric(colnames(bathy_wide[,2:ncol(bathy_wide)])))
n_lons / 2

# what is the range of the lats for bathy_wide?
range(bathy_wide$lat)
n_lats <- nrow(bathy_wide)
n_lats / 2

# create a subset
bathy_wide_reduced <- bathy_wide[1:(n_lats / 2), 1:(n_lons / 2) + 1]

# the dimensions of the new dataset?
dim(bathy_wide_reduced)

save(bathy_wide_reduced, file = "data/gebco_reduced_sa.Rdata")

# gather to long (tidy) format
bathy_long <- bathy_wide %>% 
  gather(key = "lon", value = "z", -lat) %>% 
  mutate(lon = as.numeric(lon),
         z = as.numeric(z))

# create a colour map
cmap <- cmocean("topo")
cols <- cmap(51)

# make a plot
ggplot() +
  geom_raster(data = bathy_long, aes(x = lon, y = lat, fill = z)) +
  scale_fill_gradientn(colours = cols,
                       values = scales::rescale(c(min(bathy_long$z), 0,
                                                  max(bathy_long$z))),
                       breaks = c(-6200, -4000, -2000, 0, 1000, 2000, 3400),
                       name = "Elevation /\nDepth (m)") +
  coord_sf(expand = FALSE) +
  labs(x = NULL, y = NULL)

