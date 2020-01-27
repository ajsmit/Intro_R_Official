# Tidier data {#tidier}
  
> "Knowing where things are, and why, is essential to rational decision making."
>
> --- Jack Dangermond
  
> "The mind commands the body and it obeys. The mind orders itself and meets resistance."
>
> --- Frank Herbert, Dune



On Day 1 already we walked ourselves through a tidy workflow. We saw how to import data, how to manipulate it, run a quick analysis or two, and create figures. In the previous session we filled in the missing piece of the workflow by also learning how to tidy up our data within R. For the remainder of today we will be revisiting the 'transform' portion of the tidy workflow. In this session we are going to go into more depth on what we learned in Day 1, and in the last session we will learn some new tricks. Over these two sessions we will also become more comfortable with the *pipe* command `%>%`, while practising writing tidy code.

There are five primary data transformation functions that we will focus on here:  

* Arrange observations (rows)  with `arrange()`  
* Filter observations (rows) with `filter()`  
* Select variables (columns) with`select()`  
* Create new variables (columns) with `mutate()`  
* Summarise variables (columns) with `summarise()`  

We will use the full South African Coastal Temperature Network dataset for these exercises. Before we begin however we will need to cover two new concepts.


```r
# Load libraries
library(tidyverse)
library(lubridate)

# Load the data from a .RData file
load("data/SACTNmonthly_v4.0.RData")

# Copy the data as a dataframe with a shorter name
SACTN <- SACTNmonthly_v4.0

# Remove the original
rm(SACTNmonthly_v4.0)
```

## Comparison operators

The assignment operator (`<-`) is a symbol that we use to assign some bit of code to an object in our environment. Likewise, comparison operators are symbols we use to compare different objects. This is how we tell R how to decide to do many different things. We will see these symbols often out in the 'real world' so let's spend a moment now getting to know them better. Most of these should be very familiar to us:  

* Greater than: `>`  
* Greater than or equal to: `>=`  
* Less than: `<`  
* Less than or equal to: `<=`  
* Equal to: `==`  
* Not equal to: `!=`  

It is important here to note that `==` is for comparisons and `=` is for maths. They are **not** interchangeable, as we may see in the following code chunk. This is one of the more common mistakes one makes when writing code. Luckily the error message this creates should provide us with the clues we need to figure out that we have made this specific mistake.


```r
SACTN %>% 
  filter(site = "Amanzimtoti")
```

```
R> Error: `site` (`site = "Amanzimtoti"`) must not be named, do you need `==`?
```

## Logical operators

Comparison operators are used to make direct comparisons between specific things, but logical operators are used more broadly when making logical arguments. Logic is central to most computing so it is worth taking the time to cover these symbols explicitly here. R makes use of the same *Boolean logic* symbols as many other platforms, including Google, so some (or all) of these will likely be familiar. We will generally only use three:  

* and: `&`  
* or: `|`  
* not: `!`  
  
When writing a line of tidy code we tend to use these logical operator to combine two or more arguments that use comparison operators. For example, the following code chunk uses the `filter()` function to find all temperatures recorded at Pollock Beach during December **OR** January. Don't worry if the following line of code is difficult to piece out, but make sure you can locate which symbols are comparison operators and which are logical operators. Please note that for purposes of brevity all of the outputs in this section are limited to ten lines, but when one runs these code chunks on ones own computer they will be much longer.


```r
SACTN %>% 
  filter(site == "Pollock Beach", month(date) == 12 | month(date) == 1)
```

```
R>             site  src       date     temp depth   type
R> 1  Pollock Beach SAWS 1999-12-01 19.95000     0 thermo
R> 2  Pollock Beach SAWS 2000-01-01 19.03333     0 thermo
R> 3  Pollock Beach SAWS 2000-12-01 19.20000     0 thermo
R> 4  Pollock Beach SAWS 2001-01-01 18.32667     0 thermo
R> 5  Pollock Beach SAWS 2001-12-01 20.59032     0 thermo
R> 6  Pollock Beach SAWS 2002-01-01 21.47097     0 thermo
R> 7  Pollock Beach SAWS 2002-12-01 19.78065     0 thermo
R> 8  Pollock Beach SAWS 2003-01-01 20.64516     0 thermo
R> 9  Pollock Beach SAWS 2003-12-01 20.48710     0 thermo
R> 10 Pollock Beach SAWS 2004-01-01 21.34839     0 thermo
```

We will look at the interplay between comparison and logical operators in more depth in the following session after we have reacquainted ourselves with the main transformation functions we need to know.

## Arrange observations (rows)  with `arrange()`

First up in our greatest hits reunion tour is the function `arrange()`. This very simply arranges the observations (rows) in a dataframe based on the variables (columns) it is given. If we are concerned with ties in the ordering of our data we provide additional columns to `arrange()`. The importance of the columns for arranging the rows is given in order from left to right.


```r
SACTN %>% 
  arrange(depth, temp)
```

```
R>             site  src       date      temp depth   type
R> 1      Sea Point SAWS 1990-07-01  9.635484     0 thermo
R> 2     Muizenberg SAWS 1984-07-01  9.708333     0 thermo
R> 3     Doringbaai SAWS 2000-12-01  9.772727     0 thermo
R> 4  Hondeklipbaai SAWS 2003-06-01  9.775000     0 thermo
R> 5      Sea Point SAWS 1984-06-01 10.000000     0 thermo
R> 6     Muizenberg SAWS 1992-07-01 10.193548     0 thermo
R> 7  Hondeklipbaai SAWS 2005-07-01 10.333333     0 thermo
R> 8  Hondeklipbaai SAWS 2003-07-01 10.340909     0 thermo
R> 9      Sea Point SAWS 2000-12-01 10.380645     0 thermo
R> 10    Muizenberg SAWS 1984-08-01 10.387097     0 thermo
```

If we would rather arrange our data in descending order, as is perhaps more often the case, we simply wrap the column name we are arranging by with the `desc()` function as shown below.


```r
SACTN %>% 
  arrange(desc(temp))
```

```
R>             site   src       date     temp depth type
R> 1        Sodwana   DEA 2000-02-01 28.34648    18  UTR
R> 2        Sodwana   DEA 1999-03-01 28.04890    18  UTR
R> 3        Sodwana   DEA 1998-03-01 27.87781    18  UTR
R> 4        Sodwana   DEA 1998-02-01 27.76452    18  UTR
R> 5        Sodwana   DEA 1996-02-01 27.73637    18  UTR
R> 6        Sodwana   DEA 2000-03-01 27.52637    18  UTR
R> 7        Sodwana   DEA 2000-01-01 27.52291    18  UTR
R> 8  Leadsmanshoal EKZNW 2007-02-01 27.48132    10  UTR
R> 9        Sodwana EKZNW 2005-01-01 27.45619    12  UTR
R> 10       Sodwana EKZNW 2007-02-01 27.44054    12  UTR
```

It must also be noted that when arranging data in this way, any rows with `NA` values will be sent to the bottom of the dataframe. This is not always ideal and so must be kept in mind.

## Filter observations (rows) with `filter()`

When simply arranging data is not enough, and we need to remove rows of data we do not want, `filter()` is the tool to use. For example, we can select all monthly temperatures recorded at the `site` Humewood during the `year` 1990 with the following code chunk:


```r
SACTN %>% 
  filter(site == "Humewood", year(date) == 1990)
```

```
R>        site  src       date     temp depth   type
R> 1  Humewood SAWS 1990-01-01 21.87097     0 thermo
R> 2  Humewood SAWS 1990-02-01 18.64286     0 thermo
R> 3  Humewood SAWS 1990-03-01 18.61290     0 thermo
R> 4  Humewood SAWS 1990-04-01 17.30000     0 thermo
R> 5  Humewood SAWS 1990-05-01 16.35484     0 thermo
R> 6  Humewood SAWS 1990-06-01 15.93333     0 thermo
R> 7  Humewood SAWS 1990-07-01 15.70968     0 thermo
R> 8  Humewood SAWS 1990-08-01 16.09677     0 thermo
R> 9  Humewood SAWS 1990-09-01 16.41667     0 thermo
R> 10 Humewood SAWS 1990-10-01 17.14194     0 thermo
```

Remember to use the assignment operator (`<-`, keyboard shortcut **alt -**) if one wants to create an object in the environment with the new results.


```r
humewood_90s <- SACTN %>% 
  filter(site == "Humewood", year(date) %in% seq(1990, 1999, 1))
```

It must be mentioned that `filter()` also automatically removes any rows in the filtering column that contain `NA` values. Should one want to keep rows that contain missing values, insert the `is.na()` function into the line of code in question. To illustrate this let's filter the temperatures for the Port Nolloth data collected by the DEA that were at or below 11°C OR were missing values. We'll put each argument on a separate line to help keep things clear. Note how R automatically indents the last line in this chunk to help remind us that they are in fact part of the same argument. Also note how I have put the last bracket at the end of this argument on it's own line. This is not required, but I like to do so as it is a very common mistake to forget the last bracket.


```r
SACTN %>% 
  filter(site == "Port Nolloth", # First give the site to filter
         src == "DEA", # Then specify the source
         temp <= 11 | # Temperatures at or below 11°C OR
           is.na(temp) # Include missing values
         )
```

## Select variables (columns) with`select()`

When one loads a dataset that contains more columns than will be useful or required it is preferable to shave off the excess. We do this with the `select()` function. In the following four examples we are going to remove the `depth` and `type` columns. There are many ways to do this and none are technically better or faster. So it is up to the user to find a favourite technique.


```r
# Select columns individually by name
SACTN %>% 
  select(site, src, date, temp)

# Select all columns between site and temp like a sequence
SACTN %>% 
  select(site:temp)

# Select all columns except those stated individually
SACTN %>% 
  select(-date, -depth)

# Select all columns except those within a given sequence
  # Note that the '-' goes outside of a new set of brackets
  # that are wrapped around the sequence of columns to remove
SACTN %>% 
  select(-(date:depth))
```

We may also use `select()` to reorder the columns in a dataframe. In this case the inclusion of the `everything()` function may be a useful shortcut as illustrated below.


```r
# Change up order by specifying individual columns
SACTN %>% 
  select(temp, src, date, site)

# Use the everything function to grab all columns 
# not already specified
SACTN %>% 
  select(type, src, everything())

# Or go bananas and use all of the rules at once
  # Remember, when dealing with tidy data,
  # everything may be interchanged
SACTN %>% 
  select(temp:type, everything(), -src)
```

## Create new variables (columns) with `mutate()`

When one is performing data analysis/statistics in R this is likely because it is necessary to create some new values that did not exist in the raw data. The previous three functions we looked at (`arrange()`, `filter()`, `select()`) will prepare us to create new data, but do not do so themselves. This is when we need to use `mutate()`. We must however be very mindful that `mutate()` is only useful if we want to create new variables (columns) that are a function of one or more *existing* columns. This means that any column we create with `mutate()` will always have the same number of rows as the dataframe we are working with. In order to create a new column we must first tell R what the name of the column will be, in this case let's create a column named `kelvin`. The second step is to then tell R what to put in the new column. AS you may have guessed, we are going to convert the `temp` column into Kelvin (°K) by adding 273.15 to every row.


```r
SACTN %>% 
  mutate(kelvin = temp + 273.15))
```

```
R>            site src       date     temp depth type   kelvin
R> 1  Port Nolloth DEA 1991-02-01 11.47029     5  UTR 284.6203
R> 2  Port Nolloth DEA 1991-03-01 11.99409     5  UTR 285.1441
R> 3  Port Nolloth DEA 1991-04-01 11.95556     5  UTR 285.1056
R> 4  Port Nolloth DEA 1991-05-01 11.86183     5  UTR 285.0118
R> 5  Port Nolloth DEA 1991-06-01 12.20722     5  UTR 285.3572
R> 6  Port Nolloth DEA 1991-07-01 12.53810     5  UTR 285.6881
R> 7  Port Nolloth DEA 1991-08-01 11.25202     5  UTR 284.4020
R> 8  Port Nolloth DEA 1991-09-01 11.29208     5  UTR 284.4421
R> 9  Port Nolloth DEA 1991-10-01 11.37661     5  UTR 284.5266
R> 10 Port Nolloth DEA 1991-11-01 10.98208     5  UTR 284.1321
```

This is a very basic example and `mutate()` is capable of much more than simple addition. We will get into some more exciting examples during the next session.

## Summarise variables (columns) with `summarise()`

Finally this brings us to the last tool for this section. To create new columns we use `mutate()`, but to calculate any sort of summary/statistic from a column that will return fewer rows than the dataframe has we will use `summarise()`. This makes `summarise()` much more powerful than the other functions in this section, but because it is able to do more, it can also be more unpredictable, making it's use potentially more challenging. We will almost always end op using this function in our work flows however so it behoves us to become well acquainted with it. The following chunk very simply calculates the overall mean temperature for the entire SACTN.


```r
SACTN %>% 
  summarise(mean_temp = mean(temp, na.rm = TRUE))
```

```
R>   mean_temp
R> 1  19.26955
```

Note how the above chunk created a new dataframe. This is done because it cannot add this one result to the previous dataframe due to the mismatch in the number of rows. Were we to want to create additional columns with other summaries we may do so within the same `summarise()` function. These multiple summaries are displayed on individual lines in the following chunk to help keep things clear.


```r
SACTN %>% 
  summarise(mean_temp = mean(temp, na.rm = TRUE),
            sd_temp = sd(temp, na.rm = TRUE),
            min_temp = min(temp, na.rm = TRUE),
            max_temp = max(temp, na.rm = TRUE)
            )
```

```
R>   mean_temp  sd_temp min_temp max_temp
R> 1  19.26955 3.682122 9.136322 28.34648
```

Creating summaries of the *entire* SACTN dataset in this way is not appropriate as we should not be combining time series from such different parts of the coast. In order to calculate summaries within variables we will need to learn how to use `group_by()`, which in turn will first require us to learn how to chain multiple functions together within a pipe (`%>%`). That is how we will begin the next session for today. Finishing with several tips on how to make our data the tidiest that it may be.

## Session info

```r
installed.packages()[names(sessionInfo()$otherPkgs), "Version"]
```

```
R>  bindrcpp lubridate   forcats   stringr     dplyr     purrr     readr 
R>     "0.2"   "1.7.3"   "0.3.0"   "1.3.0"   "0.7.4"   "0.2.4"   "1.1.1" 
R>     tidyr    tibble   ggplot2 tidyverse 
R>   "0.8.0"   "1.4.2"   "2.2.1"   "1.2.1"
```
