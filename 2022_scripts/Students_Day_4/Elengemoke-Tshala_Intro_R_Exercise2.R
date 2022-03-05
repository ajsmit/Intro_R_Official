# O Elengemoke-Tshala
# BCB 744
# Exercise_2


# load packages
library(tidyverse)
library(lubridate)

# load data
load("data/SACTNmonthly_v4.0.RData")

# filter, mutate,select,group by and summarise data needed
SACTN_KZNSB_years <- SACTNmonthly_v4.0 %>%
  filter(src == "KZNSB") %>%
  mutate(year = year(date)) %>%
  select(site, year, temp) %>%
  group_by(site, year) %>%
  summarise(temp = mean(temp, na.rm = TRUE))

# ungroup the final data
SACTN_KZNSB_years %>%
  ungroup()

# Plot graph
ggplot(data = SACTN_KZNSB_years, aes(x = year, y = temp)) +
  geom_line(colour = "red") +
  facet_wrap(~site, ncol = 5) +
labs(title = "KZNSB: series of annual means", x = "Years", y = "Temperature(°C)")



# Task 2 ------------------------------------------------------------------

# filter, mutate,select,group by and summarise data needed
SACTN_KZNSB_months <- SACTNmonthly_v4.0 %>%
  filter(src == "KZNSB") %>%
  mutate( month = lubridate::month(date),
         month_abr = lubridate::month(date, label = TRUE, abbr = TRUE),
         year = lubridate::year(date))

SACTN_KZNSB_months_1 <- SACTN_KZNSB_months %>%
  select(site, month_abr, temp) %>%
  group_by(site, month_abr) %>%
  summarise(temp = mean(temp, na.rm = TRUE))
  
# ungroup the final data
SACTN_KZNSB_months_1 %>%
  ungroup()
  
#  plot the graph
ggplot(data = SACTN_KZNSB_months_1, aes(x = month_abr, y = temp)) +
  geom_line(colour = "red") +
  facet_wrap(~site, ncol = 5) +
  labs(title = "KZNSB: series of monthly means", x = "Months", y = "Temperature(°C)")



# Task 3 ---------------------------------------------------------------

# load data
ToothGrowth <- datasets::ToothGrowth

# data help
?ToothGrowth

# plot graph
ggplot(data = ToothGrowth, aes(x = dose, y = len, colour = supp)) +
  geom_point (alpha = 0.5, size = 2.5) + 
  geom_smooth(method = "lm") +
labs(title = "Tooth growth under two types of supplements at diferent doses ",
     x = "Dose(mg/day)", y = " Tooth_length(mm)") +
  theme(legend.position = "bottom")

  

# Task 4 ----------------------------------------------------------------
# load packages
library(ggpubr)

# plot graph
box_1 <- ggplot(data = ToothGrowth, aes(x = dose, y = len)) +
  geom_boxplot(aes(fill = dose)) + 
  facet_wrap(~supp) +
labs(title = "The relationship of tooth length as a function of dose under two types of supplement ",
     x = "Dose(mg/day)", y = " Tooth_length(mm)")
box_1


# Task 5 ------------------------------------------------------------------

# load packages
library(ggplot2)

# specify data
df <- ToothGrowth
df$dose <- as.factor(df$dose)

# data summary
data_summary <- function(data = ToothGrowth, len, (supp, dose)
                         require(plyr)
        summary_func <- function(x, col){
                          c(mean = mean(x[[col]], na.rm=TRUE),
                            sd = sd(x[[col]], na.rm=TRUE))
        }
        data_sum<-ddply(data, (supp, dose), .fun=summary_func, len)
        data_sum <- rename(data_sum, c("mean" = len))
        return(data_sum)
                         
df2 <- data_summary(ToothGrowth, varname="len", 
                    groupnames=c("supp", "dose"))

# Convert dose to a factor variable
df2$dose=as.factor(df2$dose)
                         
p<- ggplot(df2, aes(x=dose, y=len, fill=supp)) + 
                           geom_bar(stat="identity", color="black", 
                                    position=position_dodge()) +
                           geom_errorbar(aes(ymin=len-sd, 
                                             ymax=len+sd), width=.2,
                                         position=position_dodge(0.9)) 

