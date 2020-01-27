# Day_4b.R
# More stuff
# AJ Smit
# 22 Feb 2018


# Bar graphs --------------------------------------------------------------

library(readr)
library(dplyr)
library(ggplot2)
lam <- read_csv(file = "data/laminaria.csv")

dat1 <- lam %>% 
  group_by(site) %>% 
  summarise(mn.fr.len = mean(blade_length),
            sd.fr.len = sd(blade_length))

ggplot(dat1, aes(x = site, y = mn.fr.len)) +
  geom_col(aes(fill = site)) +
  geom_errorbar(aes(ymin = mn.fr.len - sd.fr.len, 
                    ymax = mn.fr.len + sd.fr.len)) +
  scale_fill_brewer(palette = "Spectral")

ggplot(dat1, aes(x = site, y = mn.fr.len, group = 1)) +
  geom_point(aes(colour = site)) +
  geom_line(colour = "salmon") +
  geom_errorbar(aes(ymin = mn.fr.len - sd.fr.len, 
                    ymax = mn.fr.len + sd.fr.len,
                    colour = site)) +
  scale_colour_discrete(guide = FALSE) +
  scale_y_continuous(limits = c(0, 190)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
