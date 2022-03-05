# Day_4.R
# Exercise_C
# Cailin_Pillay
# 10/02/2022

# TASK_1 ------------------------------------------------------------------

# Load some packages ------------------------------------------------------

library(tidyverse)
library(lubridate)
library(dplyr)

# Load data
load("data/SACTNmonthly_v4.0.RData") 

SACTN <- SACTNmonthly_v4.0 # Creating a new name as the data frame is long

rm(SACTNmonthly_v4.0) # Deleting the old named file to not get confused 

year_mutate <- SACTN %>% # Assigning a new named data frame 
  filter(src == "KZNSB") %>% # Filtering out the src we only want to work with 
  mutate(year = year(date)) %>% # Creating a yearly column with reference to date
  group_by(site, year) %>% # Grouping the data by site and year 
  dplyr::summarise(mean_temp = mean(temp, na.rm = TRUE)) %>% # Using dplyr as it to manipulate the grammar of the data and summarize the mean temperatures over the years without any missing values
  ungroup()

# Create faceted figure
ggplot(year_mutate, aes(x = year, y = mean_temp)) + 
  geom_line(colour = "red") + # Changing the colour of the line to red
  facet_wrap(~site, ncol = 5, nrow = 9) + # This line creates the facet with the number of columns and rows
  labs(x = "Year", y = "Temperature (°C)", title = "KZNSB:Series of Annual Means") # Changes the labels and title

# TASK_2 ------------------------------------------------------------------

# Load some packages ------------------------------------------------------
library(tidyverse)
library(lubridate)
library(dplyr)

# Load data
load("data/SACTNmonthly_v4.0.RData")

SACTN <- SACTNmonthly_v4.0 # Creating a new name as the data frame is long

rm(SACTNmonthly_v4.0) # Deleting the old named file to not get confused 

monthly_mutate <- SACTN %>% # Assigning a new named data frame 
  filter(src == "KZNSB") %>% # Filtering out the src we only want to work with 
  mutate(day = lubridate::day(date),
         month = lubridate::month(date),
         month_abr = lubridate::month(date, label = TRUE, abbr = TRUE)) %>% # Creating a monthly column with reference to date
  group_by(site, month_abr) %>% # Grouping the data by site and month 
  dplyr::summarise(mean_temp = mean(temp, na.rm = TRUE)) %>% # Using dplyr as it to manipulate the grammar of the data and summarize the mean temperatures over the years without any missing values
  ungroup()

# Create faceted figure
ggplot(monthly_mutate, aes(x = month_abr, y = mean_temp)) + 
  geom_line(aes(group = "site"), colour = "red") +# Changing the colour of the line to red
  facet_wrap(~site, ncol = 5, nrow = 9) + # This line creates the facet with the number of columns and rows
  labs(x = "Month", y = "Temperature (°C)", title = "KZNSB:A Monthly Climatology ") # Changes the labels and title

# TASK_3 ------------------------------------------------------------------

# Load data
datasets::ToothGrowth 

ToothGrowth<-datasets::ToothGrowth # Assigning a new named data frame 

# Create faceted figure
ggplot(data = ToothGrowth, aes(x = dose, y = len, colour = supp)) +
  geom_point() + # Creates points on the figure
  geom_smooth(aes(method = "lm")) # Creating a linear model to visualize any patterns better

# Create faceted figure
ggplot(data = ToothGrowth, aes(x = dose, y = len, colour = supp)) +
  geom_point() + # Creates points on the figure
  geom_smooth(method = "lm") + # Creating a linear model to visualize any patterns better
  theme_light() + # Change theme 
  labs(x = "Dose(mg/d)" , y = "Tooth Lentgh (mm)", colour = "Supplement Type", title = "ToothGrowth data: length vs dose, given type of supplement") # Changes the labels 

# Create faceted figure
ggplot(data = ToothGrowth, aes(x = dose, y = len, colour = supp)) +
  geom_line() + # Creates points on the figure
  geom_smooth(method = "lm") + # Creating a linear model to visualize any patterns better
  theme_light() + # Change theme 
  labs(x = "Dose(mg/d)" , y = "Tooth Lentgh (mm)", colour = "Supplement Type", title = "ToothGrowth data: length vs dose, given type of supplement") # Changes the labels 


Toothmeans<- ToothGrowth %>% # Assigning a new named data frame 
  group_by(supp,dose) %>%  # Grouping the data by supp and dose
  summarize(lenmean=mean(len)) # Summarize the mean 

# Create faceted figure
ggplot(data = Toothmeans, aes(x = dose, y = lenmean, colour = supp)) +
  geom_point(aes(colour = supp)) + # Creates points on the figure
  geom_line(aes(group = supp)) + # Creating a linear model to visualize any patterns better
  theme_light() + # Change theme 
  labs(x = "Dose(mg/d)" , y = "Tooth Lentgh (mm)", colour = "Supplement Type", title = "ToothGrowth data: length vs dose, given type of supplement") # Changes the labels 


# TASK_4 ------------------------------------------------------------------

# Create a box plot
box_1 <- ggplot(data = ToothGrowth, aes(x = dose, y = len)) +
  geom_boxplot(aes(fill = supp)) + # Creates a box plot on the figure
  labs(x = "Dose(mg/d)" , y = "Tooth Lentgh (mm)", colour = "Supplement Type", title = "ToothGrowth data: length vs dose, given type of supplement") # Changes the labels 
box_1 
              
box_2 <- ggplot(data = ToothGrowth, aes(x = dose, y = len)) +
  geom_boxplot(aes(fill = supp)) + # Creates a box plot on the figure
  facet_wrap(~supp, ncol = 2) + # This line creates the facet with the number of columns 
  labs(x = "Dose(mg/d)" , y = "Tooth Lentgh (mm)", colour = "Supplement Type", title = "ToothGrowth data: length vs dose, given type of supplement") # Changes the labels 
box_2 


# TASK_5 ------------------------------------------------------------------
ToothGrowth_2<-ToothGrowth %>% # Assigning a new named data frame 
  group_by(dose, supp) %>% # Grouping the data by dose and supp 
  summarise(mean_len = mean(len), # Summarize the mean and standard deviation 
            sd_len = sd(len)) 

# Create faceted figure 
ggplot(ToothGrowth_2, aes(x = dose, y = mean_len, ymin = mean_len-sd_len, 
                               ymax = mean_len + sd_len, fill = supp)) + 
  geom_bar(colour = "black", stat = "identity", position = "dodge", width = 0.4) + # Setting error bars above the variables
  geom_errorbar(colour = "black", stat = "identity", 
                position = position_dodge(0.4), width = 0.2) + 
  labs(x = "Dose (mg/d)", y = "Tooth Lenth (mm)", fill = "Supplement/nType", 
       title = "Bar Graph showing The Effect of Vitamin C on Tooth Growth in Guinea Pigs") # Change labels and titles





