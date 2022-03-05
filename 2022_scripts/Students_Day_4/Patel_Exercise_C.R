# Chandler Patel
# 11 Feb 2022
# Day 4 Intro R
# Exercise 2 

library(tidyverse)
library(lubridate)

load("data/SACTNmonthly_v4.0.RData") #loaded the data

SACTNyear <- SACTNmonthly_v4.0 %>%  #created an object in which the data can be manipulated
  filter(src == "KZNSB") %>%  #filtered the data to only record data from the KZNSB source
  mutate(year = year(date)) %>%   #mutate the data to create a new variable
  group_by(site, year) %>%  #the data was grouped by site and year
  summarise(temp = mean(temp, na.rm = TRUE)) %>%  #the mean temperature for each year was summarised
  ungroup() #the data was ungrouped

ggplot(data = SACTNyear, aes(x = year, y = temp)) + #the data from object SACTNyear was chosen to plot
  geom_line(colour = "red") + #a line graph was selected, with a red colour
  facet_wrap(~site, ncol = 5) + #using site as a facet to split the graphs into many different graphs, with 5 columns
  labs(title = "KZNSB: series of annual means",  x = "Years", y = "Temperature (°C)") #labels for the x and y axis were given as well as a title

# Task 2 ------------------------------------------------------------------

SACTNmon <- SACTNmonthly_v4.0 %>%  #created an object in which the data can be manipulated
  filter(src == "KZNSB") %>%  #filtered the data to only record data from the KZNSB source
  mutate(month_abr = lubridate::month(date, label = TRUE, abbr = TRUE),
         month = month(date)) %>%  #mutate the data to create a new variable
  group_by(site, month) %>%  #the data was grouped by site and year
  summarise(Temperature = mean(temp, na.rm = TRUE)) %>% #the mean temperature for each month throughout the years was summarised
  ungroup() #ungroup the data

ggplot(data = SACTNmon, aes(x = month, y = Temperature)) + #the data from object SACTNmon was chosen to plot
  geom_line(colour = "red") + #a line graph was selected, with a red colour
  facet_wrap(~site, ncol = 5) + #using site as a facet to split the graphs into many different graphs, with 5 columns 
  scale_x_continuous(breaks = seq(2, 12, 2)) + #added breaks in x axis values with a sequence ranging from 2 to 12 with a break of 2 in between
  labs(title = "KZNSB: monthly mean temperatures", x = "Months", y = "Temperature (°C)") #labels for the x and y axis were given as well as a title


# Task 3 ------------------------------------------------------------------

Tooth <- datasets::ToothGrowth #attached toothgrowth data to an object

ggplot(data = Tooth, aes(x = dose, y = len, colour = supp)) + #selected tooth data to be plotted
  geom_point() + #points were added on the plot
  geom_smooth(method = "lm", aes(group = supp)) + #a linear model was plotted with the groups being the supplements
  facet_wrap(~supp, ncol = 2) + #graphs separated using the supplements
  labs(x = "Dose (Mg/d)", y = "Tooth length (mm)", colour = "Supplement type") #labels were given to the x and y axis and a title was added.

# Task 4 ------------------------------------------------------------------

ggplot(data = Tooth, aes(x = dose, y = len)) + #selected tooth data to be plotted
  geom_boxplot(aes(group = supp, fill = supp)) + #a box plot was grahed grouping the data by the supplements and and using the supplements to fill the colours of the boxes
  facet_wrap(~supp, ncol = 2) + #graphs separated using the supplements
  labs(x = "Dose (mg/d)", y = "Tooth length (mm)", fill = "Supplement type") #labels were given to the x and y axis and a title was added.
 
# Task 5 ------------------------------------------------------------------

tooth2 <- ToothGrowth %>%  #a new object was greate for the tooth data
  group_by(dose, supp) %>%  #data was grouped by dose and supplement
  summarise(mean_length = mean(len), #a mean length of the teeth recorded
            sd_length = sd(len)) # a standard deviation for the length was calculated

ggplot(data = tooth2, aes(x = dose, y = mean_length, ymin = mean_length-sd_length, ymax = mean_length+sd_length, fill = supp)) + #the data from tooth2 was used to plot a graph and assigned data values to x, y, y minimum and y maximum
  geom_bar(colour = "black", stat = "identity", 
           position = "dodge", width = 0.4) + #a bar graph was plotted and position of the bars assigned
  geom_errorbar(colour = "black", stat = "identity",
                position = position_dodge(0.4), width = 0.3) + #the error bars were set
  labs(x = "Dose (mg/d)", y = "Tooth length (mm)", fill = "Supplement type") #labels were added to the graph

