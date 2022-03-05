# ZM George
# 10 Feb 2022
# Exercise C


# load packages -----------------------------------------------------------

library(tidyverse)
library(ggpubr)
library(lubridate)
library(dplyr)

# Task 1

# load data ---------------------------------------------------------------

load("data/SACTNmonthly_v4.0.RData")


KZNSB <- SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB")

date <- KZNSB %>% 
  mutate(year = floor_date(date, "year")) %>% 
  group_by(year, site) %>% 
  na.omit() %>% 
  summarise(avg_temp = mean(temp))
date
# extract the year from the date column and creates a column called year
# grouped the data by year and site
# added an average column

line_graph <- ggplot(date, 
                     aes(x = year, y = avg_temp, colour = site)) +
  geom_line(aes(group = site), colour = "purple") +
  facet_wrap(~site, ncol = 5) +
  labs(x = "Year", y = "Temperature (°C)", 
       title = "KZNSB: series of annual means") +
  theme_grey()
line_graph

  

# Task 2 ------------------------------------------------------------------

monthly <- KZNSB %>% 
  select(date, site, temp) %>% 
  mutate(date = as.Date(date, format = "%%y-%m-%d")) %>% 
  group_by(site, date) %>% 
  na.omit() %>% 
  summarise(avg_temp = mean(temp))
monthly
# select only site, date and temp column
# add a column with the date in the format y/m/d
# group them by site and data, remove all the NA data

KZNSB_monthly <- monthly %>% 
  mutate(day = lubridate::day(date),
         month = lubridate::month(date),
         year = lubridate::year(date),
         month_abbr = lubridate::month(date, 
                    label = TRUE, abbr = TRUE))
KZNSB_monthly
# add column with the abbreviated months

line_graph2 <- ggplot(KZNSB_monthly, 
                  aes(x = month_abbr, y = avg_temp, colour = site)) +
  geom_line(aes(group = site), colour = "blue") +
  facet_wrap(~site, ncol = 5) +
  labs(x = "Month", y = "Temperature (°C)", 
       title = "KZNSB: series of monthly means") +
  theme_grey()
line_graph2

# Task 3 ------------------------------------------------------------------

# load data ------
tooth_growth <- datasets::ToothGrowth

ggplot(data = tooth_growth, aes(x = dose, y = len, colour = supp)) +
  geom_point() +
  geom_line(aes(group = supp)) +
  labs(x = "Dose (mg/d)", y = "Length (mm)")


# Task 4 ------------------------------------------------------------------

OJ <- tooth_growth %>% 
  filter(supp == "OJ")

VC <- tooth_growth %>% 
  filter(supp == "VC")
# create two datasets: one that only has the OJ supp and another
# that has the VC supp


box_1 <- ggplot(data = OJ, aes(x = dose, y = len)) +
  geom_boxplot(aes(fill = supp)) +
  fill_palette("red") +
  labs(x = "Dose (mg/d)", y = "Tooth Length (mm)")
box_1

box_2 <- ggplot(data = VC, aes(x = dose, y = len)) +
  geom_boxplot(aes(fill = supp)) +
  fill_palette("blue") +
  labs(x = "Dose (mg/d)", y = "Tooth Length (mm)")
box_2

ggarrange(box_1, box_2, 
          ncol = 2, nrow = 2, labels = c("A", "B"),
          common.legend = FALSE)
# display both graphs in 2 columns and 2 rows


# Task 5 ------------------------------------------------------------------

library(lattice)

tooth_growth <- datasets::ToothGrowth

ggplot(data = tooth_growth, 
       aes(x = dose, y = len, fill = supp)) +
  stat_summary(geom = "bar", fun = mean, 
               position = "dodge", alpha = 0.5 ) +
  stat_summary(geom = "errorbar", fun.data = mean_se, 
               position = "dodge", width = .4) +
  labs(x = "Dose (mg/d)", y = "Tooth Length (mm)", 
        title = "Tooth length as a function of dose") +
  scale_fill_manual(values = c("red", "blue")) + 
  theme_bw()
  # width = width of the error bars, alpha = lightens the colour of the bars
# stat sum - enter what you want the physical graph to look like
# scale fill - colour of the bars

