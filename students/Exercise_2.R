# Exercise 2
# A.A
# 25/02/18
# Section2

# Question 2

library(tidyverse)

read.csv2("data/laminaria.csv")
laminaria <- read.csv2("data/laminaria.csv")

sites <- c("A-Frame", "Baboon Rock", "Batsata Rock", "Betty's Bay", "Bordjiestif North", "Buffels", "Buffels South", "Miller's Point", "Roman Rock")
lam <- laminaria %>%
  filter(site %in% sites)



trial1 <- ggplot(lam, aes(x = blade_length, y = blade_weight)) +
  geom_line(aes(group = site, colour = site)) +
  geom_point(aes(colour = site)) +
  facet_wrap(~site, ncol = 3) +
  #scale_colour_brewer("Dark2")+
labs(x = "Blade length(cm)", y = "Blade mass (kg)",title = "A crazy graph of some data for False Bay sites")

trial1
ggsave(trial1, filename = "trial1.png")

# Question 3

tooth <- datasets::ToothGrowth

ggplot(tooth, aes(x = dose, y = len)) +
  geom_col(aes(fill = supp), position = "dodge") +
  labs(x = "Dose(mg/d)",y = "Tooth length")


# Error bars (In progress....)


test1 <- tooth %>% 
  group_by(dose) %>% 
  summarise(mn.ln = mean(len),
            sd.ln = sd(len))

ggplot(test1, aes(x = dose, y = mn.ln)) +
  geom_col(aes(fill = supp), position = "dodge") +
  labs(x = "Dose(mg/d)",y = "Tooth length") +
  geom_errorbar(aes(ymin = mn.ln - sd.ln,
                    ymax = mn.ln + sd.ln))


# Error....
# OJ and VC  different , possibly need to calculate seeperate means....


