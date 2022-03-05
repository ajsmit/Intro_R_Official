Libarary(tidyverse)
laminaria <- read_csv("data/laminaria.csv")
blade_thickness <- laminaria %>% 
filter(blade_thickness > 5) %>% 
select(site,region,blade_weight,blade_thickness)

laminaria %>% 
  filter(site == "kommetjie") %>% 
  nrow()

laminaria %>% 
  filter(total_length == max(total_length))

laminaria %>% 
  summarise(
    sd_bld_len = sd(blade_length),
    avg_bld_wdt = mean(blade_length))
  