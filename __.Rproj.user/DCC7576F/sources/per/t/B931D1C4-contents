# Day 4

# load the libraries
library(tidyverse)

# load the data
load("data/SACTN_mangled.RData")


# SACTN1 ------------------------------------------------------------------

# examine the data... (how?)

# and now plot them
ggplot(data = SACTN1, aes(x = date, y = temp)) +
  geom_line(aes(colour = site, group = paste0(site, src))) +
  labs(x = "", y = "Temperature (°C)", colour = "Site") +
  theme_bw()


# SACTN2 ------------------------------------------------------------------

# examine the data... 

# describe the data... can anyone figure out why they are not tidy?

# create a plot of these data...

SACTN2_tidy <- SACTN2 %>%
  gather(DEA, KZNSB, SAWS, key = "src", value = "temp")


# SACTN3 ------------------------------------------------------------------

SACTN3_tidy <- SACTN3 %>% 
  spread(key = var, value = val)


# SACTN4a -----------------------------------------------------------------

SACTN4a_tidy <- SACTN4a %>% 
  separate(col = index, into = c("site", "src"), sep = "/ ")

SACTN_tidy2 <- SACTN4a %>% 
  separate(col = index, into = c("site", "src"), sep = "/ ") %>% 
  mutate(day = day(date),
         month = month(date),
         year = year(date))


# SACTN4b -----------------------------------------------------------------

SACTN4b_tidy <- SACTN4b %>% 
  unite(year, month, day, col = "date", sep = "-")


# Joining SACTN4a_tidy and SACTN4b_tidy -----------------------------------

SACTN4_tidy <- left_join(SACTN4a_tidy, SACTN4b_tidy)

SACTN4_tidy <- left_join(SACTN4a_tidy, SACTN4b_tidy, by = c("site", "src", "date"))


