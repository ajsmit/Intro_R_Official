# Imanathi Kekaya
# Exercise 2
# Purpose: check understanding of what was done in class - ggplot exploration of visuals
# Date: 09/02/222

# load some packages ------------------------------------------------------

library(tidyverse)

# Load laminaria data to make plots ---------------------------------------

laminaria <- read_csv("data/laminaria.csv")


# Create ggplot -----------------------------------------------------------


ggplot(data = laminaria, aes(x = stipe_mass, y = stipe_length, colour = region)) +
  geom_point(colour = "green", size = 2) +                #we can relate the stipe mass and stipe length by the points
  geom_line() +                                           #the points will be connected by lines, tell geom line there is a certain grouping
  geom_smooth(method = "lm") +                            #straight line shows the general trend of stipe length on the stipe mass of the kelps
  theme_classic()
  labs(x = "Stipe_mass (g)", y = "Stipe_length (cm)", colour = "Region") + # Change the labels, allows to show the units of measurement on the aes
  
  
# General trend and comments ----------------------------------------------

# General trend : as the stipe length increases, the stipe mass also increases. In the False Bay region the stipe length steeply rises with an increase in mass and the stipe length does not exceed 200 cm and the stipe mass does not exceed 3g.
# In the West Coast region, the stipe mass gradually increases with an increase in stipe length.But between 0.5 g and 1.9 cm, there seems to be no difference in the growth rate, as the stipe length of both regions is growing at the same rate.
# Overall, the stipes of the False Bay region are less in mass in and shorter in length compared to those of the West Coast region, this is due to the upwelling in the West coast region which influences the growth rate as it brings up cold nutrient-rich water to the surface thus increasing the growth rate of the kelps.