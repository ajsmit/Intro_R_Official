#Day_3.R_Exersise_2
#Day_3 training on R creating geoms
#17 March 2021
#A.J Smit

library(tidyverse)
library(lubridate)
library(ggpubr)

#Load the SACTNmonthly_v4.0
"~/INTRO_R/SACTN_monthly_v4.0. R_DATA"

KZNSB_sub1 <- SACTNmonthly_v4.0 %>%
  mutate(year = year(date)) %>% 
  filter(src == "KZNSB") %>% 
  
  group_by(site, year) %>%           
  summarise (mean_temp = (mean(temp, na.rm = TRUE)))

ggplot(data = KZNSB_sub1, aes(x = year, y = mean_temp, col = "red")) +
  geom_line() +
  facet_wrap(~site, ncol = 5) +
  labs(x = "Year", y = "Temperature (degrees celcius)",
       title = "KZNSB: series of annual means") +
  theme_bw()


KZNSB_sub1 <- SACTNmonthly_v4.0 %>%
  mutate(yr = year(date),
         mo = month(date)) %>% 
  filter(src == "KZNSB") %>% 
  group_by(site, mo) %>%           
  summarise (mean_temp = (mean(temp, na.rm = TRUE)))

ggplot(data = KZNSB_sub1, aes(x = mo, y = mean_temp, col = "red")) +
  geom_line() +
  facet_wrap(~site, nrow = 9) +
  labs(x = "Year", y = "Temperature (degrees celcius)",
       title = "KZNSB: series of monthly means") +
  theme_bw()

# plot of tooth length vs. dose levels compared by supplement type
datasets::ToothGrowth
ToothGrowth$dose <- as.factor(ToothGrowth$dose)                 # change 'dose' from numeric to factor      # rename levels of supplement type
library(ggplot2)
ggplot(ToothGrowth, aes(x = dose, y = len)) + geom_line(aes(fill = dose)) + xlab("Dose in milligrams/day") + 
  ylab("Tooth length") + facet_grid(. ~ supp) + theme(plot.title = element_text(size = 16, face = "bold")) +
  theme(axis.title.x = element_text(size = 12, face = "bold"), axis.text.x = element_text(size = 10)) + 
  theme(axis.title.y = element_text(size = 12, face = "bold"), axis.text.y = element_text(size = 10)) + 
  theme(strip.text = element_text(size = 12, color = "blue", face = "bold.italic")) + 
  ggtitle("Tooth length vs. Dose levels:\nComparison by supplement type")


# plot of tooth length vs. dose levels compared by supplement type
datasets::ToothGrowth
ToothGrowth$dose <- as.factor(ToothGrowth$dose)                 # change 'dose' from numeric to factor      # rename levels of supplement type
library(ggplot2)
ggplot(ToothGrowth, aes(x = dose, y = len)) + geom_boxplot(aes(fill = dose)) + xlab("Dose in milligrams/day") + 
  ylab("Tooth length") + facet_grid(. ~ supp) + theme(plot.title = element_text(size = 16, face = "bold")) +
  theme(axis.title.x = element_text(size = 12, face = "bold"), axis.text.x = element_text(size = 10)) + 
  theme(axis.title.y = element_text(size = 12, face = "bold"), axis.text.y = element_text(size = 10)) + 
  theme(strip.text = element_text(size = 12, color = "blue", face = "bold.italic")) + 
  ggtitle("Tooth length vs. Dose levels:\nComparison by supplement type")



library(ggplot2)  # Load ggplot2 package
fig1 <- ggplot(ToothGrowth$len, geom = "histogram") + xlab("tooth length") + 
  ggtitle("Frequency of Tooth Length Measurements") + geom_vline(xintercept = mean(ToothGrowth$len), 
                                                                 colour = "red", linetype = "longdash")  # See figure 1



  