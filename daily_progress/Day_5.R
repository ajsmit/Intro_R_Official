# Day_5.R
# Intention: to undertake assignment 1
# Hafeez
# 23 Feb 2018


# Set-up ------------------------------------------------------------------

library(tidyverse)


# Load the data -----------------------------------------------------------

dat1 <- iris


# Obj 1 -------------------------------------------------------------------

# Objective 1: produce a frequency distribution (histogram) 
# for Petal.Length, showing the relationship of the data
# distribution between species

plot1 <- ggplot(dat1, aes(x = Petal.Length)) +
  geom_histogram(aes(fill = Species))

plot2 <- ggplot(dat1, aes(x = Petal.Length)) +
  geom_histogram(aes(fill = Species), position = "dodge")

plot3 <- ggplot(dat1, aes(x = Petal.Length)) +
  geom_histogram(aes(fill = Species)) +
  facet_wrap(~Species, nrow = 3)

plot4 <- ggplot(dat1, aes(x = Petal.Length)) +
  geom_histogram(aes(fill = Species)) +
  facet_wrap(~Species, ncol = 3)

library(ggpubr)

ggarrange(plot1, plot2, plot3, plot4,
          nrow = 2, ncol = 2,
          labels = "AUTO")


# Moving on... ------------------------------------------------------------

# Load libraries
library(tidyverse)
library(ggpubr)

# Load data
load("data/south_africa_coast.Rdata")
load("data/sa_provinces.RData")
load("data/rast_annual.Rdata")
load("data/MUR.Rdata")
# load("data/MUR_low_res.RData")

sst <- MUR
rm(MUR)
head(sst)
head(south_africa_coast)

# The colour pallette we will use for ocean temperature
cols11 <- c("#004dcd", "#0068db", "#007ddb", "#008dcf", "#009bbc",
            "#00a7a9", "#1bb298", "#6cba8f", "#9ac290", "#bec99a")

ggplot(sst, aes(x = lon, y = lat)) +
  geom_point()

library(scales)
library(ggsn)

load("data/cape_point_sites.RData")

cps <- cape_point_sites %>% 
  filter(site == "Noordhoek")

cape_point_sites[5, ]

ggplot(data = south_africa_coast, aes(x = lon, y = lat)) +
  geom_raster(data = sst, aes(fill = bins)) +
  geom_polygon(fill = "floralwhite", size = 0.4, aes(group = group)) +
  geom_path(data = sa_provinces, colour = "grey80", size = 0.2, aes(group = group)) +
  scale_fill_brewer("Temp. (°C)", palette = "Spectral", direction = -1) +
  geom_point(aes(x = 25, y = -30)) +
  geom_point(data = cps, aes(x = lon + 0.002, y = lat - 0.007), 
             colour = "red", size =  2.5) +
  annotate("text", label = "Noordhoek", 
           x = cps$lon, y = cps$lat, 
           size = 3, angle = 30, colour = "navy", hjust = -0.1) +
  coord_equal(xlim = c(15, 34), ylim = c(-36, -26), expand = 0) +
  scalebar(x.min = 29.5, x.max = 33.5, y.min = -34.5, y.max = -33.5, # Set location of bar
           dist = 200, height = 0.25, st.dist = 0.2, st.size = 2.5, # Set particulars
           dd2km = TRUE, model = "WGS84") +
  north(x.min = 29.5, x.max = 33.5, y.min = -33.5, y.max = -31.5, # Set location of symbol
        scale = 1.2, symbol = 16) +
  labs(x = "Longitude (°E)", y = "Latitude (°S)", title = "Plot of MUR SST data")


# ggmap -------------------------------------------------------------------

library(ggmap)



# load data ---------------------------------------------------------------

# load("data/cape_point_sites.RData")


# create the Google map ---------------------------------------------------

cape_point <- get_map(location = c(lon = 18.36519, lat = -34.2352581),
                      zoom = 10, maptype = 'satellite')

cp_1 <- ggmap(cape_point) +
  geom_point(data = cape_point_sites, aes(x = lon+0.002, y = lat-0.007), 
             colour = "red", size =  2.5) +
  labs(x = "", y = "")
cp_1

cp_2 <- cp_1 +
  geom_text(data = cape_point_sites, # Choose dataframe
            aes(lon+0.002, lat-0.007, label = site), # Set aesthetics
            hjust = 1.15, vjust = 0.5, # Adjust vertical and horizontal
            size = 3, colour = "white") # Adjust appearance
cp_2
