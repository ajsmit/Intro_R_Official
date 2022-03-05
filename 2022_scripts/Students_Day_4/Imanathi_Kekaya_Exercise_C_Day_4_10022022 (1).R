# Author: Imanathi Kekaya
# Date: 10 February 2022
# Exercise C 
# Purpose: To manipulate and analyse data using different packages loaded thus far


# Load some packages ------------------------------------------------------

library(tidyverse)
library(lubridate)
library(dplyr)
library(ggplot2)
library(ggpubr)


# Task 1 ------------------------------------------------------------------ 

# Load some data

load("data/SACTNmonthly_v4.0.Rdata")


# Create object to filter out the source ----------------------------------


KZN_data <- SACTNmonthly_v4.0 %>% 
  filter(src== "KZNSB")

# Create an object that will contain the required data(yearly temperatures) for the graph, create new variables from the "date" 
# column using the "mutate()" function so that the year can be separated from the date (as required)

Yearly_temps <- KZN_data %>% 
  mutate(yr = year(date), 
         mon = month(date)) %>% 
group_by(site, yr) %>% 
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>% # summarise the data by calculating the mean temperatures and remove 
                                                      # the data that has no values in it.
ungroup()


# Create the plot ---------------------------------------------------------

 
ggplot(Yearly_temps, aes(x = yr, y = mean_temp)) + #create the plot using the mean temperatures for every year
  geom_line(colour = "blue") + #using a line graph
  facet_wrap(~site, ncol = 5) + # facet the sites into 5 columns
  labs(x = "Years", y = "Temperature(°C)")+  # Change the labels
ggtitle("KZNSB: series of annual means") #add a title to the graph


# Task 2 ------------------------------------------------------------------

# load some data

load("data/SACTNmonthly_v4.0.Rdata")

KZN_data <- SACTNmonthly_v4.0 %>% #Create an object to filter out the source
  filter(src== "KZNSB")

# Create an object that will contain the required data(monthly mean temperatures) for the graph, create new variables from the "date" 
# column using the "mutate()" function so that the year can be separated from the date (as required)


Monthly_temps <- KZN_data %>% 
  mutate(mon = month(date, label = TRUE, abbr = TRUE)) %>% 
  group_by(site, mon) %>% 
  summarise(mean_temp = mean(temp, na.rm = TRUE)) %>% # summarise the data by calculating the mean temperatures and remove 
                                                     # the data that has no values in it.
  mutate(month.abb[as.numeric(mon)]) %>%            # create new data from the numeric months to a data that will only have abbreviated months
  ungroup()
Monthly_temps

# Create the plot

ggplot(Monthly_temps, aes(x = mon, y = mean_temp)) +
  geom_line(aes(group= site, colour = "blue")) +
  facet_wrap(~site, ncol = 5) +                     # facet the sites into 5 columns
  theme(axis.text.x = element_text(angle= 90))+     #the axis will have a vertical label
  labs(x = "Months", y = "Temperature(°C)")+        # Change the labels
  ggtitle("KZNSB: series of monthly means")         # provide graph ttitle 

# Task 3 ------------------------------------------------------------------

#Load library
library(tidyverse)

# Load data ---------------------------------------------------------------

ToothGrowth <- datasets:: ToothGrowth

ToothGrowth_data <- ToothGrowth %>% 
  group_by(supp, dose) %>%
  summarize(mean=mean(len), sd=sd(len), count =n()) %>% 
ungroup()


# create a line graph using the data above and add required a labels 
line_1 <- ggplot(data = ToothGrowth_data, aes(x = dose, y = mean, colour = supp)) +
  geom_point() +
  geom_line() +
  labs(x = "Dose(mg/d)", y = "Len(mm)",colour= "Supplement")
line_1

# From the graph it appears that as as dosage increases, the tooth length also increases. It also appears that for lower dosages (0.5 and 1.0) OJ delivery leads to more tooth growth than VC delivery.
# At the 2.0 mg dosage, there is no significant difference between the OJ and VC supplement methods



# Task 4 ----------------------------------------------------------------
# continuation from Task 3 - create box and whisker graphs with supplements presented in separate panels (facets)

box_1 <- ggplot(data = ToothGrowth, aes(x = dose, y = len)) +
  geom_boxplot(aes(fill = supp)) +
  facet_wrap(~supp, ncol = 2)+
  labs(x = "Dose(mg/d)", y = "Length(mm)")
box_1


# Task 5 ------------------------------------------------------------------
library(ggplot2)

ToothGrowth_data <- ToothGrowth %>% 
  group_by(supp, dose) %>%
  summarize(mean=mean(len), sd=sd(len))

Bar_graph<-ggplot(ToothGrowth, aes(x=dose, y=len, fill = supp)) +
  geom_bar(stat="identity", position=position_dodge())+
  labs(x = "Dose(mg/d)", y = "Length(mm)")+
  scale_fill_brewer(palette="Blues")+
  theme_minimal() 

Bar_graph_2 <- ggplot(ToothGrowth_data, aes(x=dose, y=mean, fill = supp)) +
  geom_bar(stat="identity", position=position_dodge())+
  geom_errorbar(data = ToothGrowth_data,aes(ymin=mean-sd, ymax=mean+sd), width=.1,
                position=position_dodge(.4))+
  labs(x = "Dose(mg/d)", y = "Length(mm)")+
  scale_fill_brewer(palette="Blues")+
  theme_minimal() 
Bar_graph_2


