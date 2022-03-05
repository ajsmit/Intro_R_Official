# Author: Taufeeqah Francis
# Date: 8 Feb 2022
# Day_2.R
# Exercise
# #do various data manipulations and analyses

laminaria <- read.csv("data/laminaria.csv")

laminaria %>%
  filter(blade_thickness > 5) %>% #filters data to show regions where blade thickness is greater than 5cm
  select(site, region, blade_weight, blade_thickness) #only shows the selected columns

laminaria %>% 
  filter(site == "Kommetjie") %>% #only shows the area Kommetjie
  nrow() #counts number of rows left after being filtered

laminaria %>% # Tell R which dataset to use
  filter(total_length == max(total_length)) #greatest length found at Kommetjie

summary(laminaria)  #provides summary of data

laminaria %>% 
  summarise(avg_bld_wdt = mean(blade_length)) #calculate average blade length

laminaria %>% # Tell R that we want to use the 'laminaria' dataframe
  summarise(
    avg_tot_ln = mean(total_length), # Create a summary of the mean of the total lengths
    sd_tot_ln = sd(total_length), #standard deviation of stipe length
    min_tot_ln = min(total_length), #shortest length
    max_tot_ln = max(total_length), #longest length
    med_tot_ln = median(total_length)) #middle length
            
laminaria %>% 
  summarise(
    avg_bld_thk = mean(blade_thickness), #average blade thickness
    sd_bld_thk = sd(blade_thickness)) #standard deviation of blade thickness

laminaria %>% 
  summarise(avg_stp_ms = mean(stipe_mass, na.rm = T)) #na.rm = T shows average mass of stipe without the NAs in the data

laminaria %>% 
  group_by(site) %>% #groups the data by site
  summarise(var_bl = var(blade_length), #calculates the variance of the blade length
            n_bl = n()) %>% #counts the number of values there are per site for the blade length column
  mutate(se_bl = sqrt(var_bl / n_bl)) #calculates standard error of blade length

laminaria %>% 
  select(stipe_mass) %>% 
  summarise(n = n()) #shows summary of stipe mass data including those NA

laminaria %>% 
  select(stipe_mass) %>% 
  na.omit() %>% #takes out the NA variables
  summarise(n = n())






