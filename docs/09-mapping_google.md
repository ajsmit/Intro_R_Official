# Mapping with Google {#mapping_google}
  
> "The only thing Google has failed to do, so far, is fail."
>
> --- John Battelle

> "I'm afraid that if you look at a thing long enough, it loses all of its meaning."
> 
> --- Andy Warhol



Now that we've seen how to produce complex maps with **`ggplot2`** we are going to learn how to bring Google maps into the mix. Some kind hearted person has made a package for R that allows us to do this relatively easily. But that means we will need to install another new package.

After we learn how to use Google maps we will take some time to learn additional mapping techniques that we may want for creating publication quality figures.

## **`ggmap`**

The package we will need for this tut is **`ggmap`**. It is a bit beefy so let's get started on installing it now. Once it's done we will activated the packages we need and load some site points for mapping.


```r
# Load libraries
library(tidyverse)
library(ggmap)

# Load data
load("data/cape_point_sites.RData")
```

Take a moment to look at the data we loaded. What does it show?

## Mapping Cape Point

We will be creating our Google map in two steps. The first step is to use the `get_map()` function to tell Google what area of the world we want a map of, as well as what sort of map we want. Remember how Google maps can be switched from satellite view to map view? We may do that in R as well. For now we are only going to use the satellite view so that we may insert out own labels. But if we look in the help file we may see a description of all the different map types available. There are a bunch!

The `get_map()` function relies on a healthy Internet connection to run. The downloading of Google maps can be a tenuous process without a stable connection. For that reason, if your Internet connection is not great you may run the commented out line of code in favour of loading the Google map. This is a pre-saved file of the output of the code chunk below. Please rather run the `get_map()` function first, and if it won't connect only then load the saved file as shown below.


```r
cape_point <- get_map(location = c(lon = 18.36519, lat = -34.2352581),
                        zoom = 10, maptype = 'satellite')
# load("data/cape_point.RData")
```


If we look in the environment panel in the top right corner, what do we see? What do we think the code above is doing?

The second step in the process is to treat the Google data we downloaded as though it is just any ordinary **`ggplot2`** object. The same as the ones we created yesterday and today. For this reason we may use `+` to add new lines of **`ggplot2`** code to the Google object we downloaded in order to show site locations etc. Let's first just see how the map looks when we add some points. Note that we do not use the function `ggplot()` at the beginning of our code, but rather `ggmap()`.


```r
cp_1 <- ggmap(cape_point) +
  geom_point(data = cape_point_sites, aes(x = lon+0.002, y = lat-0.007), 
             colour = "red", size =  2.5) +
  labs(x = "", y = "")
cp_1
```

<div class="figure">
<img src="09-mapping_google_files/figure-html/ggmap-1-1.png" alt="Google map of Cape Point with some site locations highlighted with red points." width="672" />
<p class="caption">(\#fig:ggmap-1)Google map of Cape Point with some site locations highlighted with red points.</p>
</div>

Pretty cool huh?! You may do this for anywhere in the world just as easy as this. The only thing you need to keep in mind is that the lon/lat coordinates for Google appear to be slightly different than the global standard. This is why the x and y `aes()` values in the code above have a little bit added or subtracted from them. That one small issue aside, this is a  nice quick workflow for adding your site locations to a Google map background. Play around with the different map types you can download and try it for any place you can think of.

## Site labels

The previous figure shows our sites along Cape Point, which is great, but which site is which?! We need site labels. This is a relatively straightforward process, so we've given a complicated example of how to do so here.


```r
cp_2 <- cp_1 +
  geom_text(data = cape_point_sites, # Choose dataframe
            aes(lon+0.002, lat-0.007, label = site), # Set aesthetics
            hjust = 1.15, vjust = 0.5, # Adjust vertical and horizontal
            size = 3, colour = "white") # Adjust appearance
cp_2
```

<div class="figure">
<img src="09-mapping_google_files/figure-html/ggmap-2-1.png" alt="Google map of Cape Point with site point labeled" width="672" />
<p class="caption">(\#fig:ggmap-2)Google map of Cape Point with site point labeled</p>
</div>

## DIY maps

Now that we have learned how to make conventional maps, as well as fancy Google maps, it is time for us to branch out once again at let our creative juices flow. Please group up as you see fit and create your own beautiful map of wherever you like. Bonus points for faceting in additional figures showing supplementary information. Feel free to use either conventional maps or the Google alternative. Same as yesterday, we will be walking the room to help with any issues that may arise.

## Session info

```r
installed.packages()[names(sessionInfo()$otherPkgs), "Version"]
```

```
R>     ggmap   forcats   stringr     dplyr     purrr     readr     tidyr    tibble 
R>   "3.0.0"   "0.4.0"   "1.4.0"   "0.8.3"   "0.3.3"   "1.3.1"   "1.0.0"   "2.1.3" 
R>   ggplot2 tidyverse 
R>   "3.2.1"   "1.3.0"
```
