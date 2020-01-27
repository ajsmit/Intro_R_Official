# Load libraries
library(tidyverse)
library(lubridate)

# Load data
SACTN_data <- read_csv("data/SACTN_data.csv")

# Create monthly climatologies
SACTN_monthly <- SACTN_data %>% # Tell R to use "SACTN_data" for further calculations
  mutate(month = month(date, label = T)) %>%  # Create a month only column
  group_by(site, month) %>% # Group the data by the individual site and month values
  summarise(temp = mean(temp, na.rm = T)) # Calculate one mean value per site/month

# Create a figure
ggplot(data = SACTN_monthly, aes(x = month, y = temp)) + # Tell R to use "SACTN_monthly" for visualisations
  geom_point(aes(colour = site)) + # Create dots
  geom_line(aes(colour = site, group = site)) + # Create lines
  labs(x = "", y = "Temperature (°C)") # Change x and y axis labels
