#Day 3 Exercise 2
#Benjamin Gazeau

#########
#Task 1
library(lubridate)
library(tidyverse)


SACTN <- SACTNmonthly_v4.0 %>% 
  filter(src=="KZNSB") %>% 
  mutate(yr = year(date)) %>% 
  group_by(site, yr) %>% 
  summarise(mean_temp= mean(temp,na.rm = TRUE)) %>% 
  ungroup ()

ggplot(SACTN,aes(x= yr, y= mean_temp))+
  geom_line(aes(group=site), colour = "salmon", size=1)+
  facet_wrap(~site, ncol =5, nrow=9)+
  labs(x="Year", y = "Temperature(⁰C)",
       title= "KZNSB: Series of annual means")+
  scale_x_continuous(breaks=c(1980, 2000))+
  scale_y_continuous(breaks=c(20,22,24))

#############
#Task 2

SACTN_Mo <- SACTNmonthly_v4.0 %>% 
  filter(src=="KZNSB") %>%
  mutate(mo = month(date)) %>% 
  group_by(site, mo) %>% 
  summarise(mean_temp= mean(temp,na.rm = TRUE)) %>% 
  ungroup ()

ggplot(SACTN_Mo,aes(x= mo, y= mean_temp))+
  geom_line(aes(group=site), colour = "salmon")+
  facet_wrap(~site, ncol =5, nrow =9)+
  labs(x="Month", y = "Temperature('C)",
       title= "KZNSB:Series of monthly means")+
  scale_x_continuous(breaks=c(3,8),labels = c("March","August"))+
  scale_y_continuous(breaks=c(20,22,24))

###########
#Task 3

tooth <-datasets::ToothGrowth 

glimpse(tooth)

ggplot(tooth, aes(x= dose, y=len, colour= supp))+
  geom_point()+
  geom_smooth(method="lm")+
  labs(x="Dosage(mg/d)", y = "Tooth length(mm)",
       title= "The effect of Vitamin C on the tooth growth in Guinea Pigs")

###########
#Task 4


library(ggplot2)

ggplot(tooth,aes(x=dose, y=len, group=dose))+
     geom_boxplot(outlier.colour = "red",outlier.shape = 8,outlier.size = 1 )+ 
  facet_wrap(~supp, ncol = 2)+
         xlab("Dosage(mg/d") + ylab("Tooth length (mm)") +
         labs(title ="Whisker box plot showing the effects of vitamin C\n
              on the tooth growth of Guinea Pigs" )+
         theme_bw()+
         theme(axis.text.x = element_text(angle = 45, hjust = 1))


tooth_means <- tooth %>% 
  group_by(dose,supp) %>% 
  summarise(mean_length = mean(len),sd_length = sd(len))

ggplot(data= tooth_means) +
  geom_col(aes(x=dose, y= mean_length,fill = supp), col = "black",position= "dodge")+
  geom_errorbar(aes(ymin= mean_length - sd_length, 
                    ymax= mean_length +sd_length,
                    x= dose),position= position_dodge2(0.5),
                col="black",
                width= 0.2 )




