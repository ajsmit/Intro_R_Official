#Hello
#SUBMISSION_1
#Author: Jabulile Leroko
#Feeling: Just fine. Nothing to complain about, really.


library(readr)
library(tidyverse)
library(lubridate)

#Assigning the SACTNmonthly_v4.0 to a new name that I created
sactn <- SACTNmonthly_v4.0

#But because I only want data from the src KZNSB, I will filter it and...
#assign it to another name
KZN0 <- sactn %>% filter(src == 'KZNSB')

#Here, I want a 'table' with only year, mean_temp and site
KZN1 <- KZN0 %>% 
  mutate(year = year(date)) %>% # Extracting the years from the whole date, years is what I want
  group_by(site, year) %>%
  summarise(mean_temp = mean(temp)) #Calculating mean of temp from the temperatures
  
#Now, to draw the graphs
ggplot(KZN1, aes(year, mean_temp)) + geom_line(col = "red") + facet_wrap(~site, nrow = 9) +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x = "Year", y = "Temperature (degrees celcius)", title = "KZNSB: Series of annual means")
#That's for 1.

#Now, 2.
#Same as in line18, but I want months, not years
KZN2 <- KZN0 %>% 
  mutate(month = month(date)) %>%
  group_by(site, month) %>%
  summarise(mean_temp = mean(temp))

#Now, the graph
ggplot(KZN2, aes(month, mean_temp)) + geom_line(col = "red") +
  facet_wrap(~site) + theme(plot.title = element_text(hjust = 0.5)) +
  labs(x = "Months", y = "Temperature (degrees celcius)", title = "KZNSB: Series of annual means")
#That's 2.

#Now, 3.
#Start by fetching the data and assign it
TG <- datasets::ToothGrowth

#Let me see what I'm dealing with
summary(TG)
head(TG)

#Assign TG to a new name, calc the mean of the lengths
TG1 <- TG %>% group_by(dose, supp) %>%
  summarise(mean_length = mean(len))
#Plot the lines
ggplot(TG1, aes(x = dose, y = mean_length, group = supp)) +
         geom_line(aes(colour = supp), size = 1) + geom_point() + theme_classic() +
  labs(x = "Dose (mg)", y = "Tooth length (mm)", 
       title = "Tooth length of Guinea pigs as per dosage and supplement type") +
  theme(plot.title = element_text(hjust = 0.5)) + #For my title to be in the middle
scale_colour_manual(values = c('#999999','#E69F00')) #Because I prefer...
#these colours
#And that's 3

#Now, 4.
#Boxplot, 2 supplements per dosage... 3 dosage groups
qplot(supp, len, data = TG, facets = ~dose, 
      main = "The effect of supplement type and dosage on tooth length of Guinea pigs", 
      xlab = "Supplement type", ylab = "Tooth length (mm)") + theme_classic() +
  scale_fill_manual(values = c('#999999','#E69F00')) +
  theme(plot.title = element_text(hjust = 0.5))+
  geom_boxplot(aes(fill = supp))

#And that's 4

#Now, 5.
TG2 <- TG
TG2$dose <- as.factor(TG2$dose)
head(TG2)

library(plyr)
library(reshape2)

#Start with a function to calculate the mean and the sd for each group

data_summary <- function(data, varname, groupnames){
  require(plyr)
  summary_func <- function(x, col){
    c(mean = mean(x[[col]], na.rm=TRUE),
      sd = sd(x[[col]], na.rm=TRUE))
  }
  data_sum<-ddply(data, groupnames, .fun=summary_func,
                  varname)
  data_sum <- rename(data_sum, c("mean" = varname))
  return(data_sum)
}

TG3 <- data_summary(ToothGrowth, varname="len", 
                    groupnames=c("supp", "dose"))

# Convert dose to a factor variable, numeric won't work
TG3$dose=as.factor(TG3$dose)
head(TG3)

BOX <- ggplot(TG3, aes(x = dose, y = len, fill = supp)) + 
  geom_bar(stat = "identity", color = "black", 
           position = position_dodge()) +
  geom_errorbar(aes(ymin = len - sd, ymax = len + sd), width = 0.2,
                position = position_dodge(0.9)) 
print(BOX)
#I don't like it, let's make it nicer

BOX + labs(title = "Tooth length due to dose", x = "Dose (mg)", 
           y = "Tooth length (mm)")+
  theme_classic() + theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(values = c('#999999','#E69F00'))



  
