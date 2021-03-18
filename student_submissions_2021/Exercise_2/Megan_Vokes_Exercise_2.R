#DAY 3
# Homework
# Author: Megan Vokes 

library(tidyverse)
library(lubridate)
library(ggpubr)
library(ggplot2)

load("data/SACTNmonthly_v4.0.RData")



# Task 1 
KZN <- SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB") %>%
  mutate(year = year(date)) %>% 
  group_by(site,year) %>% 
  summarise(mean_temp = mean(temp, na.rm = TRUE )) %>% 
  ungroup()
  

 ggplot(data = KZN, aes(x = year, y = mean_temp)) +
  geom_line(aes(group = site), size = 1, colour = "salmon") +
  facet_wrap(~site, ncol = 5, nrow = 9) +
  labs(x = "Year", y = "Tempreture", title = "KZNSB:series of annual means") +
  scale_x_continuous(breaks = c(1980,2000)) +
  scale_y_continuous(breaks = c(20,22,24)) 
  
 


 
#Task 2 
 
 
   
   KZN_2 <- SACTNmonthly_v4.0  %>% 
   filter(src == "KZNSB") %>%
   mutate(yr = year(date),
          mo = month(date)) %>%
   group_by(site, mo) %>%
   summarise(mean_temp = mean(temp, na.rm =TRUE)) %>%
   ungroup()
   
   
  
   ggplot(data = KZN_2, aes(x = mo, y= mean_temp )) +
     geom_line(aes(group = site), colour = "navy blue" ) +
     facet_wrap(~site, nrow = 5,ncol = 9) +
     labs(x = "MONTHS", y = "TEMPERATURE (⁰C)",
          title = "KZNSB Monthly Climatology ") +
     scale_x_continuous(breaks = c(1,2,3,4,5,6,7,8,9,10,11,12)) +
     scale_y_continuous(breaks = c(20,22,24)) +
     theme(axis.text.x = element_text(angle = 90,hjust = 1)) + 
     theme(panel.background = element_rect(fill = "powder blue",color = "navy blue"))
   
   
   
#Task 3
   ToothGrowth <- datasets::ToothGrowth
   
   TG_1 <- ToothGrowth %>%
     group_by(supp,dose) %>% 
     summarise(mean_len = mean(len))
   
   
   ggplot(data=TG_1, aes(x=dose, y=mean_len, group=supp,col = supp)) +
     geom_line(aes(group = supp)) + 
     geom_point(aes(shape = supp,col = supp)) +  
     xlab("Dose(mg/day)") + ylab("Length(mm)") + ggtitle("Toothgrowth Line Graph") +
     theme(legend.position = "left",panel.background = element_rect(fill = "honeydew",color = "black"))
   
   
              
#Task 4 
    ggplot(data = ToothGrowth, aes(x = dose, y = len, col = supp, group = dose)) +
      geom_boxplot(aes(colour = supp,shape =supp )) +
      scale_color_manual(values = c("orchid", "cornflower blue")) +
      facet_wrap(~supp) +
      labs(x = "Dose", y = "Length(mm)", title = "Toothgrowth Box and Whisker Plot") +
      theme(panel.background = element_rect(fill = "lemon chiffon",color = "black"))  
    
    
    
#Task 5
   
    
    TG <- ToothGrowth %>% 
      group_by(supp,dose) %>%   
      summarise(mean_len = mean(len),  
                sd_len = sd(len), 
                n_len = n(),  
                SE_len = sd(len)/sqrt(n())) 
    
    
    
  
    ggplot(TG, aes( x= dose, y = mean_len, fill = supp)) + 
      geom_bar(stat = "identity", color = "black", 
               position = position_dodge()) +
      geom_errorbar(aes(ymin =mean_len - sd_len, ymax= mean_len + sd_len), width =.2,
                    position = position_dodge(.5)) + 
      labs(x="Dose (mg/day)", y = "Length(mm)")+
      theme_classic() +
      scale_fill_manual(values=c('lime green','purple')) +
      theme(panel.background = element_rect(fill = "pink",color = "black"))  
                          
    
    
    
    
    
    
    
    
    
    
      
 
   
   
   
   
   
 
 