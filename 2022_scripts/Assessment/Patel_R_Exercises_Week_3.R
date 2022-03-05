# author: Chandler Patel
# 20/02/2022
# R exercises

library(tidyverse)
library(boot)
library(colorspace)
hcl_palettes(plot = TRUE)


# Exercise A --------------------------------------------------------------

shells <- read.csv("data/shells.csv")

tidy_shells <- shells %>% 
  gather(left_length, left_width, right_length, right_width, 
         key = "measurements",
         value = values) %>% 
  arrange(species, ID)

aulacomya_graph <- shells %>% 
  filter(species == "Aulacomya") %>% 
  arrange(ID)

Choromytilus_graph <- shells %>% 
  filter(species == "Choromytilus") %>% 
  arrange(ID)


ggplot(Choromytilus_graph, aes(x = left_width)) +
  geom_histogram(colour = "Black", fill = "Blue") +
  labs(x = "Individual", y = "left width of shell")

ggplot(Choromytilus_graph, aes(x = left_length)) +
  geom_histogram(colour = "Black", fill = "Pink") +
  labs(x = "Individual", y = "left length of shell(mm)")

ggplot(Choromytilus_graph, aes(x = right_width)) +
  geom_histogram(colour = "Black", fill = "Green") +
  labs(x = "Individual", y = "right width of shell(mm)")

ggplot(Choromytilus_graph, aes(x = right_length)) +
  geom_histogram(colour = "Black", fill = "Red") +
  labs(x = "Individual", y = "right length of shell(mm)")

ggplot(aulacomya_graph, aes(x = left_width)) +
  geom_histogram(colour = "Black", fill = "purple") +
  labs(x = "Individuals", y = "left width of shells(mm)")

ggplot(aulacomya_graph, aes(x = left_length)) +
  geom_histogram(colour = "Black", fill = "orange") +
  labs(x = "Individuals", y = "lefft length of shells(mm)")

ggplot(aulacomya_graph, aes(x = right_width)) +
  geom_histogram(colour = "Black", fill = "Yellow") +
  labs(x = "Individuals", y = "right width of shells(mm)")

ggplot(aulacomya_graph, aes(x = right_length)) +
  geom_histogram(colour = "Black", fill = "white") +
  labs(x = "Individuals", y = "right length of shells(mm)")

# Exercise B --------------------------------------------------------------

install.packages("boot") 

?frets

brothers <- boot::frets

brother1 <- brothers %>% 
  select(l1, b1) %>% 
  rename(Length = l1, Breadth = b1) %>% 
  gather(Length, Breadth,
         key = "Head_Dimensions",
         value = "brother1")

brother2 <- brothers %>% 
  select(l2, b2) %>% 
  rename(Length = l2, Breadth = b2) %>% 
  gather(Length, Breadth,
         key = "Head_Dimensions",
         value = "brother2")

brother1$brother2 <- brother2$brother2

brother_tidy <- brother1 %>% 
  gather(brother1, brother2,
         key = "brother (1/2)",
         value = "value")


ggplot(brother_tidy, aes(x = Length, y = Breadth, 
                         colour = Head_Dimensions)) +
  geom_point() +
  geom_smooth(method = "lm") +
  ggtitle("Head dimensions of brothers") +
  labs(x = "Length and breadth of Brother 1 (mm)", y = "Length and Breadth of Brother 2 (mm)") +
  scale_colour_manual(values = c("blue", "green"),
                      labels = c("Brother 1", "brother2"))


# Exercise C --------------------------------------------------------------

plantgrowth <- datasets::PlantGrowth

# Scatter plot

scatter1 <- qplot(x = group, y = weight, colour = group, data = plantgrowth)
  geom_point(c("point", "smooth")) +
  labs(x = "Treatment conditions", y = "Weight (g)")
  scatter1

 # box-and-whisker plot

ggplot(data = plantgrowth, aes(x = group, y = weight)) +
  geom_boxplot(aes(fill = group)) +
  theme_bw() +
  theme(legend.position = "bottom") +
  labs(x = "Treatment conditions", y = "Weight (g)")


# bar plot

ggplot(data = plantgrowth, aes(x = group, y = weight, fill = group)) +
  labs(x = "Treatment conditions", y = "Weight (g)") +
  stat_summary(geom = "bar", fun = mean, position = "dodge") +
  stat_summary(geom = "errorbar", fun.data = mean_se, position = "dodge", width = 0.7) +
  scale_fill_manual(values = c("grey", "red", "blue")) +
  theme_classic()

# Exercise D --------------------------------------------------------------

sleep <- datasets::sleep

ggplot(data = sleep, aes(x = ID, y = extra)) +
  geom_bar(stat = "identity", position = "dodge", aes(fill = group)) +
  labs(x = "Individual", 
       y = "Additional or subtracted sleep(hours)",
       fill = "Soporific drug") +
  theme_bw() +
  theme(legend.position = "bottom")

ggplot(data = sleep, aes(x = ID, y = extra, colour = group)) +
  geom_point() +
  geom_line(aes(group = group)) +
  labs(x = "Individual", 
       y = "Additional or subtracted sleep(hours)", 
       colour = "Soporific drug") +
  theme_bw() +
  theme(legend.position = "right")
