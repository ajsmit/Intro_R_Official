# Intro R Exercises 
# Author: M H Tapela
# 19/02/21
# Miscellaneous exercises for the mind



# Exercise A -------------------------------------------------------------


# Load packages -----------------------------------------------------------

library("tidyverse")


# Load laminaria ----------------------------------------------------------
read.csv("laminaria.csv")
laminaria<-read.csv("laminaria.csv")


# Group laminaria dataframe by site
laminaria %>% 
  group_by(site) # Group the dataframe by site


# Create a new object for the laminaria dataframe which is grouped by site 
lam1 <- laminaria %>% 
  group_by(site) # Group the dataframe by site


# Create a basic scatterplot using linear blade length ~ blade weight with a with line of best fit grouped by site (with confidence intervals) the linear model  
Lam_plot <- ggplot(data = lam1, aes(x = blade_weight, y = blade_length, colour = site)) +
  geom_point(aes(size = blade_length)) +
  geom_smooth(method = "lm", size = 0.9, se = TRUE, alpha = 0.3) +
  labs(x = "Blade_weight (g)", y = "Blade_length (cm)", colour = "Site") + # Change the labels
  theme_light()+
  
  theme(legend.position = "bottom") # Change the legend position
Lam_plot


# Interpretation of relationship ------------------------------------------

# The figure depicts a positive relationship between blade length ~ blade weight for all sites for laminaria. This relationship between sites are not significantly different from each as confidence intervals overlap



# Exercise B --------------------------------------------------------------

# Load packages -----------------------------------------------------------

library(tidyverse)
library(ggpubr)
library(boot)


# Task 1: Load chicken data ----------------------------------------------------------
ChickWeight <- datasets::ChickWeight #assign dataset to object


# Create a basic scatterplot using a linear model (y~x) linear blade length ~ blade weight with a with lines of best fit for every site (with 95% confidence intervals)  
figure_1 <- ggplot(data = ChickWeight, aes(x = Time, y = weight, colour = Diet)) +
  geom_point(aes(size = weight)) + 
  geom_smooth(method = "lm", size = 0.95, se = TRUE, aes(fill = Diet), alpha = 0.3) + #confidence interval bands
  scale_colour_brewer(palette = "Set3") + # unique colour palette for discrete data
  labs(x = "Days", y = "Mass (g)", colour = "Diet") + # Axis labels
  theme(legend.position = "bottom") # Change the legend position
figure_1


# Task 2: Facetted Plot ---------------------------------------------------

# Load Data ---------------------------------------------------------------
#load the data using the appropriate extension 

load("data/SACTNmonthly_v4.0.RData")


# Exploratory data analysis -----------------------------------------------

unique(SACTNmonthly_v4.0$src)


# Subsetting data ---------------------------------------------------------

#filter dataset for only Port Nolloth and UTR observations and assign to an object

sites_sel <- c("Mzamba", "Port Nolloth", "T.O. Strand", "Leisure Bay" )
temps_KZNSB <- SACTNmonthly_v4.0 %>%
  filter(src == "KZNSB", site %in% sites_sel)

unique(temps_KZNSB)


# Create faceted figure: Linear Relationship between Temperature and Date with respect to type

figure_2 <- ggplot(data = temps_KZNSB, aes(x = date, y = temp)) +
  geom_line(colour = "blue") + 
  facet_wrap(~site, ncol = 2) #Faceting function into 2 columns
figure_2


# Task 3: the 'data/ecklonia.csv' data ------------------------------------

# Load Data ---------------------------------------------------------------
#load the data using the appropriate extension 

read.csv("data/ecklonia.csv")
ecklonia <- read.csv("data/ecklonia.csv") #assign data frame to object


# Making figures using ggplot2 --------------------------------------------

# Group laminaria dataframe by site

ecklonia %>% 
  group_by(site) # Group the dataframe by site

# Create a new object for the laminaria dataframe which is grouped by site 

eck1 <- ecklonia %>% 
  group_by(site) # Group the dataframe by site
eck1


# Create a basic boxplot blade length ~ blade weight with a wit lines of best fit for every site (with 95% confidence intervals)  

figure_3 <- ggplot(data = eck1, aes(x = stipe_mass, y = stipe_length, colour = site)) +
  geom_boxplot(aes(size = stipe_length)) +
  labs(x = "Stipe mass (g)", y = "Stipe length (cm)", colour = "Site") + # Change the labels
  theme(legend.position = "bottom") # Change the legend position


# Create a basic boxplot using a linear model (y~x) for Frond length ~ Frond weight with  lines of best fit for both sites (with 95% confidence intervals)  

figure_4 <- ggplot(data = eck1, aes(x = frond_mass, y = frond_length, colour = site)) +
  geom_point() +
  geom_smooth(method = "lm", aes(colour = site)) + #add confidence interval band
  labs(x = "Frond mass (g)", y = "Frond length (cm)", colour = "Site") + # Change the labels
  theme(legend.position = "bottom") # Change the legend position
figure_4


# Task 4: he last step ----------------------------------------------------

#Gridding Figures

grid <- ggarrange(figure_1, figure_2, figure_3, figure_4, #assign the code to an object name
                  ncol = 2, nrow = 2, # Set number of rows and columns
                  labels = c("A", "B", "C", "D"), # Label each figure
                  common.legend = TRUE, # Create common legend
                  legend = c("bottom"))
grid


# Then we save the object we created
ggsave("data/grid.png", width = 1200, height = 900, units = "px", scale = 4.2)



# Exercise C --------------------------------------------------------------


# Task 1: The SACTNmonthly_v4.0.RData (A) ------------------------------------------------------------------


# Load packages ------------------------------------------------------------
library(tidyverse)
library(lubridate)

# Load Data ---------------------------------------------------------------

load("data/SACTNmonthly_v4.0.RData")

SACTN <- load("data/SACTNmonthly_v4.0.RData")


SACTNmonthly_v4.0

# Subsetting dataset to obtain mean annual temperatures

SACTN <- SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB") %>% # filter out all data expect that of KZNSB
  mutate(year = year(date)) %>% # replace date variable with yearly dates instead of monthly dates  
  group_by(site, year) %>%  #group dataset by site and year 
  dplyr::summarise(mean_temp = mean(temp, na.rm = TRUE)) %>% # convert temperature variable to mean annual temp and remove NAs
  ungroup()

# Plot figure as shown in task 1  

figure_annual <- ggplot(SACTN, aes(x = year , y = mean_temp)) +
  geom_line(colour = "red") +
  facet_wrap(~site, ncol = 5) + #arrangement of graphs per site
  labs(title = "KZNSB: series of annual means", x = "year", y = "Mean Annual Temperature (°C)")
figure_annual


# Task 2: The SACTNmonthly_v4.0.RData (B) ---------------------------------

# Plot figure date is monthly

SACTN_Mon <- SACTNmonthly_v4.0 %>%
mutate(month = lubridate::month(date,label = TRUE, abbr = TRUE))%>% 
group_by(site, month) %>% 
summarise(mean_temp = mean(temp, na.rm = TRUE))

figure_monthly <- ggplot(SACTN_Mon, aes(x = month, y = mean_temp)) +
  geom_line(aes(group = "site"), colour = "red") +
  theme(axis.text.x = element_text(angle = 90, vjust = 1, hjust=1)) +
  facet_wrap (~site, ncol = 5) +
  labs(x = "Months", y = "Temperature (°C)", title = "KZNSB: series of monthly means")
figure_monthly


# Task 3: The ToothGrowth data (A) ----------------------------------------

# Load Data ---------------------------------------------------------------

ToothGrowth <- datasets::ToothGrowth

# Plot line graphs depecting len~dose group by supp

# line graph

line_1 <- ggplot(data = ToothGrowth, aes(x = dose , y = len, colour = supp)) + 
  geom_line(size = 0.5) +
  labs(title = "The Effect of Vitamin C on Tooth Growth in Guinea Pigs", x = "Dose (mg/d)", y = "Length (mm)") +
  theme(legend.position = "bottom") # Change the legend position
line_1  

# line graph (mean length)

ToothGrowth_1 <- ToothGrowth %>% # Select 'ToothGrowth'
  group_by(dose, supp) %>% # Group the dataframe by dose DOSE and SUPP
  dplyr::summarise(mean_len = mean(len))

line_2 <- ggplot(data = ToothGrowth_1, aes(x = dose , y = mean_len, colour = supp)) + 
  geom_line(size = 0.5) +
  labs(title = "The Effect of Vitamin C on Tooth Growth in Guinea Pigs", x = "Dose (mg/d)", y = "Mean Length (mm)") +
  theme(legend.position = "bottom") # Change the legend position
line_2  


# Task 4: The ToothGrowth data (B) ----------------------------------------

# Load Data ---------------------------------------------------------------

ToothGrowth <- datasets::ToothGrowth

# Plot Boxplot graphs depecting len~dose group by supp separate facets

box_1 <- ggplot(data = ToothGrowth, aes(x = dose , y = len, colour = supp)) + 
  geom_boxplot(aes(fill = supp), alpha= 0.2) +
  facet_wrap(~supp, ncol = 2) + #facetting 
  labs(title = "The Effect of Vitamin C on Tooth Growth in Guinea Pigs", x = "Dose (mg/d)", y = "Length (mm)") +
  theme(legend.position = "bottom") # Change the legend position
box_1  


# Task 5: The ToothGrowth data (C) ----------------------------------------

# Load Data ---------------------------------------------------------------

ToothGrowth <- datasets::ToothGrowth

# More complex summaries

# SD and mean of tooth length

ToothGrowth_sd <- ToothGrowth %>% # Select 'ToothGrowth'
  group_by(dose, supp) %>% # Group the dataframe by dose DOSE and SUPP
  dplyr::summarise(mean_len = mean(len),
                   sd_len = sd(len))

# Plot Barplot w/ error bars depicting the relationship between Length~Dose with respect to Vitamin C supplement treatments

ggplot(ToothGrowth_sd, aes(x=dose, y=mean_len, ymin = mean_len-sd_len, ymax = mean_len+sd_len, fill=supp)) + 
  geom_bar(size = 1.0, stat="identity", color="black",position= "dodge", width = 0.4) +
  geom_errorbar(size = 1.0, colour = "black", stat="identity",width = 0.2, position=position_dodge(0.4)) +
  labs(x = "Dose (mg/d)", y = "Length (mm)")

