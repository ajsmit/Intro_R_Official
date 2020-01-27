# Day_1_facet.R
# About faceting
# AJ Smit
# 21 Feb 2018


# Set-up ------------------------------------------------------------------

library(tidyverse)
library(ggpubr)


# Load data ---------------------------------------------------------------

nandos <- datasets::ChickWeight


# Make graphs -------------------------------------------------------------

plot1 <- ggplot(nandos, aes(x = Time, y = weight)) +
  geom_line(aes(colour = Diet, group = Chick), alpha = 0.5) +
  geom_point(aes(shape = Diet)) +
  labs(x = "Time (days", y = "Mass (g)")
 
plot2 <- ggplot(nandos, aes(x = Time, y = weight)) +
  geom_line(aes(colour = Diet, group = Chick), alpha = 0.5) +
  geom_point() +
  facet_wrap(~Diet, ncol = 2) +
  labs(x = "Time (days", y = "Mass (g)")

plot3 <- ggplot(nandos, aes(x = weight)) +
  geom_histogram(aes(fill = Diet), binwidth = 50) +
  labs(x = "Final Mass (g)", y = "Count")

lostLives <- nandos %>% 
  filter(Time == 21)

plot4 <- ggplot(lostLives, aes(x = Diet, y = weight)) +
  geom_boxplot(aes(fill = Diet)) +
  labs(x = "Diet", y = "Final Mass (g)")
plot4

plotLast <- ggarrange(plot1, plot2, plot3, plot4,
          ncol = 2, nrow = 2,
          labels = c("A", "B", "C", "D"),
          common.legend = TRUE)

ggsave(plotLast, filename = "chicks.png")


# Plot more colours -------------------------------------------------------

library(boot)
pee <- boot::urine
?boot::urine

ggplot(pee, aes(x = osmo, y = ph)) +
  geom_point(aes(colour = cond))

ggplot(pee, aes(x = osmo, y = ph)) +
  geom_point(aes(colour = as.factor(r)))

ggplot(pee, aes(x = osmo, y = ph)) +
  geom_point(aes(colour = cond)) +
  scale_colour_distiller(palette = "YlOrRd")

ggplot(pee, aes(x = osmo, y = ph)) +
  geom_point(aes(colour = as.factor(r))) +
  scale_colour_brewer(palette = "Dark2")

c("#D48C51", "#7D8A40", "#33775D", "#315867", "#4A3649", "#3F1E1E")

ggplot(pee, aes(x = osmo, y = ph)) +
  geom_point(aes(colour = cond)) +
  scale_colour_gradientn(colours = c("#D48C51", "#7D8A40", "#33775D",
                                     "#315867", "#4A3649", "#3F1E1E"))

ggplot(pee, aes(x = osmo, y = ph)) +
  geom_point(aes(colour = as.factor(r))) +
  scale_colour_manual(values = c("pink", "maroon"), # How to use custom palette
                      labels = c("no", "yes")) + # How to change the legend text
  labs(colour = "crystals")



# Exercise 1 --------------------------------------------------------------

# For diets 1 and 3, what is the mean mass at day 21? 
# Show this graphically.

sub1 <- nandos %>% 
  filter(Time == 21) %>% 
  group_by(Diet) %>% 
  summarise(mn.wt = mean(weight),
            sd.wt = sd(weight))

ggplot(sub1, aes(x = Diet, y = mn.wt)) +
  geom_point() +
  geom_errorbar(aes(ymin = mn.wt - sd.wt,
                    ymax = mn.wt + sd.wt),
                width=.1)


# Task 2 ------------------------------------------------------------------

load(file = "data/SACTNmonthly_v4.0.RData")
temp <- as_tibble(SACTNmonthly_v4.0)
unique(temp$site)
names(temp)
unique(temp$src)

saws.temp <- temp %>% 
  filter(src == "SAWS")

summary(aov(data = saws.temp, temp ~ site))

ggplot(saws.temp, aes(x = date, y = temp)) +
  geom_line(aes(group = site, colour = site)) +
  facet_wrap(~site, ncol = 5)
  
sub2 <- saws.temp %>% 
  group_by(site) %>% 
  summarise(mn.temp = mean(temp, na.rm = TRUE),
            sd.temp = sd(temp, na.rm = TRUE))

ggplot(sub2, aes(x = site, y = mn.temp)) +
  geom_point() +
  geom_errorbar(aes(ymin = mn.temp - sd.temp,
                    ymax = mn.temp + sd.temp),
                width=.1)
