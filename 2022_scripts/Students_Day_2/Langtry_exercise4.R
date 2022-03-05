# 4.4_Exercise ------------------------------------------------------------

laminaria %>% 
  filter(blade_thickness >5) %>% 
  select(site, region, blade_weight, blade_thickness)

laminaria %>% 
  filter(site == "Kommetjie") %>% 
  nrow()

laminaria %>% 
  filter(blade_length == max(blade_length))