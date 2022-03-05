#Author: Taufeeqah Francis
#Date: 10 February 2022
#BCB744
#Exercise


# load packages -----------------------------------------------------------

library(tidyverse)
library(lubridate)
library(dplyr)

# task 1 ------------------------------------------------------------------

load("data/SACTNmonthly_v4.0.RData")

KZNSB <- SACTNmonthly_v4.0 %>% 
  filter(src == "KZNSB")

task_1 <- KZNSB %>% 
  mutate(year = floor_date(date, "year")) %>% 
  group_by(year, site) %>% 
  na.omit() %>% 
  summarise(avg = mean(temp))

task_1_graph <- ggplot(data = task_1, aes(x = year, y = avg, colour =site)) +
  labs(x = "Year", y = "Temperature(C)") +
  facet_wrap(~site, ncol = 5) +
  geom_line(aes(group = site), colour = "green") +
  theme_grey()
task_1_graph

# task 2 ------------------------------------------------------------------

task_2 <- KZNSB %>% 
  select(date, site, temp) %>% 
  mutate(date = as.Date(date, format = "%%y-%m-%d")) %>% 
  group_by(site, date) %>% 
  na.omit() %>% 
  summarise(avg = mean(temp))

KZNSB_2 <- task_2 %>% 
  mutate(day = lubridate::day(date),
         month = lubridate::month(date),
         year = lubridate::year(date),
         month_abr = lubridate::month(date, label = TRUE, abbr = TRUE))
KZNSB_2

task_2_graph <- ggplot(data = KZNSB_2, aes(x = month_abr, y = avg, colour = site)) +
  labs(x = "Month", y = "Temperature(C)") +
  facet_wrap(~site, ncol = 5) +
  geom_line(aes(group = site), colour = "red")
task_2_graph


# task 3 ------------------------------------------------------------------

ToothGrowth <- datasets::ToothGrowth

ggplot(data = ToothGrowth, aes(x = dose, y = len, colour = supp)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "dose", y = "length", colour = "Supplementary")
  
# task 4 ------------------------------------------------------------------

box_1 <- ggplot(data = ToothGrowth, aes(x = dose, y = len)) +
  geom_boxplot(aes(fill = supp)) +
facet_wrap(~supp, ncol = 2) + 
  labs(x = "dose(mg/d)", y = "length(mm)") +
  facet_wrap(~supp, ncol = 2)
box_1

# task 5 ------------------------------------------------------------------

ToothGrowth <- ToothGrowth
ToothGrowth$dose <- as.factor(ToothGrowth$dose)

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

TG2 <- data_summary(ToothGrowth, varname="len", 
                    groupnames=c("supp", "dose"))

TG2$dose=as.factor(TG2$dose) # Convert dose to a factor variable

bar_1 <- ggplot(data = TG2, aes(x=dose, y=len, fill=supp)) + 
  geom_bar(stat="identity", color="black", 
           position=position_dodge()) +
  geom_errorbar(aes(ymin=len-sd, ymax=len+sd), width=.2,
                position=position_dodge(.9)) +
  labs(title="Tooth length per dose", x="Dose (mg)", y = "Length(mm)")+
  theme_classic() +
  scale_fill_manual(values=c("pink", "lightblue"))
bar_1
