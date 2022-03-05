# Intro R Workshop: Exercise 2 updated
# Author: M H Tapela
# Date: 10/02/22
#Intro R Workshop: Exercise 2


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

# Plot figure as shown in task 1 but date is monthly
 
month_no <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 9, 10, 11, 12) 
month_full <- month.name[month_no]


SACTN_1 <- SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB") %>% # filter out all data expect that of KZNSB
  mutate (mo = month(date)) %>% 
  group_by(site, mo) %>% # group by site and year 
  dplyr::summarise(mean_temp = mean(temp, na.rm = TRUE)) %>% # summarize to find the annual mean temperatures 
  ungroup()

SACTN_1_mo <- SACTN_1 %>% 
  mutate(mon = month.abb[mo]) %>% 
  select("site", "mean_temp", "mon")

Mon <- factor(Temp_mo$mon, levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))

  
ggplot(SACTN_1_mo, aes(x = Mon, y = mean_temp)) +
  geom_line(aes(group = "site"), colour = "red") +
  theme(axis.text.x = element_text(angle = 90, vjust = 1, hjust=1)) +
  facet_wrap (~site, ncol = 5) +
  labs(x = "Months", y = "Temperature (°C)", title = "KZNSB: series of monthly means")


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

