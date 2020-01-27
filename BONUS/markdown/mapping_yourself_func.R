# This script contains the few functions used in the 'Mapping Yourself' tut.

# Load libraries ----------------------------------------------------------

library(raster)


# Functions for the mapping yourself session ------------------------------

# Clean up json dataframes for better analysis
location.clean <- function(location_history){
  # extracting the locations dataframe
  loc <-  location_history$locations
  # Convert time column from posix milliseconds into a readable time scale
  loc$time <- as.POSIXct(as.numeric(location_history$locations$timestampMs)/1000, origin = "1970-01-01")
  # Convert longitude and latitude from E7 to GPS coordinates
  loc$lat <- loc$latitudeE7 / 1e7
  loc$lon <- loc$longitudeE7 / 1e7
  loc <- loc %>%
    dplyr::select(accuracy:lon, -activitys) %>%
    mutate(date = as.Date(time, '%Y/%m/%d'),
           month_year = as.yearmon(date),
           year = year(date))
  return(loc)
}

# Shifting vectors for latitude and longitude to include end position
shift.vec <- function(vec, shift){
  if (length(vec) <= abs(shift)){
    rep(NA ,length(vec))
  } else {
    if (shift >= 0) {
      c(rep(NA, shift), vec[1:(length(vec) - shift)]) }
    else {
      c(vec[(abs(shift) + 1):length(vec)], rep(NA, abs(shift)))
    }
  }
}

# Calculate distance between points
dist.points <- function(df){
  apply(df, 1, FUN = function(row) {
    pointDistance(c(as.numeric(as.character(row["lat.p1"])),
                    as.numeric(as.character(row["lon.p1"]))),
                  c(as.numeric(as.character(row["lat"])), as.numeric(as.character(row["lon"]))),
                  lonlat = T)
  })
}

# Create distance dataframe
distance.per.month <- function(df){
  df2 <- df %>%
    mutate(lat.p1 = shift.vec(lat, -1),
           lon.p1 = shift.vec(lon, -1))
  df2$dist.to.prev <- dist.points(df2)
  df2 <- df2[complete.cases(df2$dist.to.prev),]
  distance_p_month <- df2 %>%
    group_by(month_year) %>%
    summarise(distance = sum(dist.to.prev)*0.001) %>%
    mutate(month_year = as.factor(month_year))
  return(distance_p_month)
}

# Create an activities dataframe
activities.df <- function(df){
  activities <- df$locations$activitys
  list.condition <- sapply(activities, function(x) !is.null(x[[1]]))
  activities <- activities[list.condition]
  times <- do.call("rbind", activities)
  main_activity <- sapply(times$activities, function(x) x[[1]][1][[1]][1])
  activities_2 <- data.frame(main_activity = main_activity,
                             time = as.POSIXct(as.numeric(times$timestampMs)/1000,
                                               origin = "1970-01-01"))
  return(activities_2)
}
