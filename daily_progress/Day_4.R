# Day_4.R
# Recap earlier stuff
# AJ Smit
# 22 Feb 2018


# Set-up ------------------------------------------------------------------

library(tidyverse)


# Load the data -----------------------------------------------------------

load("data/SACTNmonthly_v4.0.RData")
temp <- SACTNmonthly_v4.0
head(SACTNmonthly_v4.0, 2)
head(temp, 2)
rm(SACTNmonthly_v4.0)


# What sources are available? ---------------------------------------------

unique(temp$src)

# Subset the data ---------------------------------------------------------

saws.temp <- temp %>%
  filter(src == "SAWS")


# Plot the data -----------------------------------------------------------

ggplot(temp, aes(x = temp)) +
  geom_histogram() +
  facet_wrap(~site)


# Select specific sites ---------------------------------------------------

sites <- c("Gordons Bay", "Muizenberg", "Kalk Bay", "Fish Hoek")

sub2 <- temp %>%
  filter(site %in% sites)


