# Assignment_2.R
# Do the assignment.
# AJ Smit
# 2 March 2018


# Load stuff --------------------------------------------------------------

library(tidyverse)
library(lubridate)
load("data/SACTNmonthly_v4.0.RData")


# Do stuff ----------------------------------------------------------------

SACTN <- SACTNmonthly_v4.0

SACTN_grp <- SACTN %>%
  mutate(yr = year(date))

SACTN_grp <- SACTN %>%
  separate(date, into = c("yr", "mo", "da"), sep = "-") %>% 
  filter(src == "KZNSB") %>% 
  mutate(yr = as.numeric(yr)) %>% 
  group_by(yr, site) %>% 
  summarise(mn.temp = mean(temp, na.rm = TRUE))

ggplot(SACTN_grp, aes(x = yr, y = mn.temp)) +
  geom_line(aes(group = site), colour = "salmon") +
  facet_wrap(~site) +
  scale_x_continuous(breaks = c(1980, 2000)) +
  scale_y_continuous(breaks = c(20, 24)) +
  labs(x = "Year", y = "Temperature (°C)",
       title = "KZNSB: annual mean temperature")


# Laminaria data ----------------------------------------------------------

# load the data
lam <- read_csv("data/laminaria.csv")

lam_mn <- lam %>%
  filter(region == "FB") %>% 
  group_by(site) %>% 
  summarise(mn.bl.w = mean(blade_weight, na.rm = TRUE),
            mn.bl.l = mean(blade_length, na.rm = TRUE))

ggplot(lam, aes(x = blade_length, y = blade_weight)) +
  geom_point(aes(colour = site)) +
  geom_line(aes(colour = site, group = site)) +
  facet_wrap(~site)


# Rats! -------------------------------------------------------------------

dat4 <- datasets::ToothGrowth

dat5 <- dat4 %>% 
  group_by(supp, dose) %>% 
  summarise(mn.len = mean(len),
            sd.len = sd(len))

ggplot(data = dat5, aes(x = dose, y = mn.len)) +
  geom_col(aes(fill = supp), colour = "black", position = "dodge") + 
  geom_errorbar(aes(ymin = mn.len - sd.len, ymax = mn.len + sd.len, group = supp), 
                position = position_dodge(width = 0.45), width = 0.2) +
  labs(x = "Dose (mg/d)", y = "Tooth length (mm)") +
  theme(panel.grid.major = element_line(size = 0.2, linetype = 2),
        panel.grid.minor = element_line(colour = NA))


# Tidy data ---------------------------------------------------------------

load("data/SACTN_mangled.RData")

ggplot(data = SACTN1, aes(x = date, y = temp)) +
  geom_line(aes(colour = site, group = paste0(site, src))) +
  labs(x = "", y = "Temperature (°C)", colour = "Site") +
  theme_bw()


SACTN2_tidy <- SACTN2 %>%
  gather(DEA, KZNSB, SAWS, key = "src", value = "temp")


# Do this -----------------------------------------------------------------

# Using SACTN2, calculate the mean temperature (±SD)
# for the DEA and SAWS data at Port Nolloth and plot the
# means (±SD) on one set of axes
