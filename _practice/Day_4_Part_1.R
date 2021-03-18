# Day_4_Part_1
# Mapping in ggplot: Chapters 9 and 10
# AJ Smit
# 18 March 2021

# Load libraries
library(tidyverse)
library(scales)
library(ggsn)
library(maps)

# Some text in here -------------------------------------------------------

# Load Africa map
load("_GitBook/data/africa_map.RData")

ggplot() +
  borders() + # The global shape file
  coord_equal() # Equal sizing for lon/lat 

sa_1 <- ggplot() +
  borders(fill = "grey70", colour = "black") +
  coord_equal(xlim = c(16, 20), ylim = c(-35, -33), expand = 0)
sa_1

sa_2 <- sa_1 +
  annotate("text", label = "Atlantic\nOcean", 
           x = 15.1, y = -32.0, 
           size = 5.0, 
           angle = 30, 
           colour = "navy") +
  annotate("text", label = "Indian\nOcean", 
           x = 33.2, y = -34.2, 
           size = 5.0, 
           angle = 330, 
           colour = "springgreen")
sa_2

sa_3 <- sa_2 +
  geom_point(data = cape_point_sites, aes(x = lon+0.002, y = lat-0.007), 
             colour = "red", size =  2.5) +
  labs(x = "", y = "")


# Chapter 10: ggmap -------------------------------------------------------

library(OpenStreetMap)

# define the spatial extent
lat1 <- -35
lat2 <- -33
lon1 <- 16
lon2 <- 20

sa_map <- openmap(c(lat2, lon1), c(lat1, lon2), zoom = NULL,
                  type = "stamen-toner",
                  mergeTiles = TRUE)
sa_map2 <- openproj(sa_map)
OpenStreetMap::autoplot.OpenStreetMap(sa_map2) +
  annotate("text", label = "Atlantic\nOcean", 
           x = 15.1, y = -32.0, 
           size = 5.0, 
           angle = 30, 
           colour = "navy") +
  geom_point(data = cape_point_sites, aes(x = lon+0.002, y = lat-0.007), 
             colour = "red", size =  2.5)
  
  
# Tidy data ---------------------------------------------------------------

load("_GitBook/data/SACTN_mangled.RData")

ggplot(data = SACTN1, aes(x = date, y = temp)) +
  geom_line(aes(colour = site, group = paste0(site, src))) +
  labs(x = "", y = "Temperature (°C)", colour = "Site") +
  theme_bw()

SACTN2_tidy <- SACTN2 %>%
  gather(DEA, KZNSB, SAWS, key = "src", value = "temp")

SACTN3_tidy1 <- SACTN3 %>% 
  spread(key = var, value = val)

SACTN4a_tidy <- SACTN4a %>% 
  separate(col = index, into = c("site", "src"), sep = "/ ")

SACTN4b_tidy <- SACTN4b %>% 
  unite(year, month, day, col = "date", sep = "-")

colnames(SACTN4a_tidy)
colnames(SACTN4b_tidy)

SACTN4_tidy <- left_join(SACTN4a_tidy, SACTN4b_tidy)


# Tidier data -------------------------------------------------------------

load("_GitBook/data/SACTNmonthly_v4.0.RData")
SACTN <- SACTNmonthly_v4.0

SACTN %>% 
  filter(year(date) == 2012 & site == "Sunwich Port")

SACTN %>% 
  filter(date >= "2012-01-01" & date <= "2012-12-31")

SACTN %>% 
  select(site) %>% 
  unique() %>% 
  nrow()

