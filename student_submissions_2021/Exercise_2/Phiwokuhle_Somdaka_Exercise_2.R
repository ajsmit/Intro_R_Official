# Exercise 2
# 17 March 2021
# Phiwokuhle Somdaka (3831469)

# Question 1

library(lubridate)
library(tidyverse)
library(readr)
library(dplyr)

NZ <- SACTNmonthly_v4.0

NZ1 <- NZ %>%  filter(src == "KZNSB")

NZ2 <- NZ1 %>% 
  mutate(year = year (date) %>% 
           group_by(site, year) %>% 
  summarise(mean_temp = mean(temp))

ggplot(KZN1, aes(year, mean_temp)) + geom_line(col = "salmon") + facet_wrap(~site) +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x = "Year", y = "Temperature (celcius)", (title = "KZNSB: Series of annual means")
       

# Question 2

library(lubridate)
library(tidyverse)
library(readr)

ZN <- SACTNmonthly_v4.0

ZN1 <- ZN %>%  filter(src == "KZNSB")

ZN2 <- ZN1 %>% 
  mutate(month = month (date) %>% 
           group_by(site, month) %>% 
           summarise(mean_temp = mean(temp))
         
view(ZN2)

ggplot(KZN1, aes(month, mean_temp)) + geom_line(col = "salmon") + facet_wrap(~site) +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x = "Month", y = "Temperature (celcius)", (title = "KZNSB: Series of monthly means")


# Question 3

library(ggplot2)
library(tidyverse)
library(lubridate)
library(Rmisc)

datasets::ToothGrowth

tg <- ToothGrowth
head(tg)

tgc <- summarySE(tg, measurevar="len", groupvars=c("supp","dose"))

ggplot(tgc, aes(x=dose, y=len, colour=supp)) + 
  geom_line() +
  geom_point()+ 
  xlab("Dose (mg)") +
  ylab("Tooth length (mm)") +
  scale_colour_hue(name="Supplement type",   
                   breaks=c("OJ", "VC"),
                   labels=c("Orange juice", "Ascorbic acid"),
                   l=40) +                    
  ggtitle("The Effect of Vitamin C on\nTooth Growths") +
  expand_limits(y=0) +                        
  scale_y_continuous(breaks=0:20*4) +         
  theme_bw() +
  theme(legend.justification=c(1,0),
        legend.position=c(1,0)) 

        

# Question 4

library(ggplot2)
library(dplyr)

datasets::ToothGrowth

head(ToothGrowth)

summary(ToothGrowth)

qplot(factor(supp), len, data = ToothGrowth, geom = "boxplot", facets = .~dose, main = "Tooth Length by Supplement within Dose", ylab = "Length")

# Question 5

library(ggplot2)

df <- ToothGrowth
df$dose <- as.factor(df$dose)
head(df)

data_summary <- function(data, varname, groupnames){require(plyr)
  summary_func <- function(x, col){
    c(mean = mean(x[[col]], na.rm = TRUE),
      sd = sd(x[[col]], na.rm = TRUE))
  }
  data_sum <- ddply(data, groupnames, .fun = summary_func,
                    varname)
  data_sum <- rename(data_sum, c("mean" = varname))
  return(data_sum)
}
df2 <- data_summary(ToothGrowth, varname = "len",
                    groupnames=c("supp", "dose"))
df2$dose = as.factor(df2$dose)
head(df2)

library(ggplot2)

p <- ggplot(df2, aes(x = dose, y = len, fill = supp)) + geom_bar(stat = "identity", color = "black",
                                                                 position = position_dodge()) +
  geom_errorbar(aes(ymin = len -sd, ymax = len +sd), width = 0.2,
                position = position_dodge
                (0.9))
print(p)
p + labs(title = "Tooth length per dose", x = "Dose (mg/d", y = "Tooth Length (mm)") +
  theme_classic()
