# Mapping with style {#mapping_style}

> "How beautiful the world was when one looked at it without searching, just looked, simply and innocently."
>
> --- Hermann Hesse, Siddartha

> "You can't judge a book by it's cover but you can sure sell a bunch of books if you have a good one."
>
> --- Jayce O'Neal



Now that we have learned the basics of creating a beautiful map in **`ggplot2`** it is time to look at some of the more particular things we will need to make our maps extra stylish. There are also a few more things we need to learn how to do before our maps can be truly publication quality.

If we have not yet loaded the **`tidyverse`** let's do so.


```r
# Load libraries
library(tidyverse)
library(scales)
library(ggsn)

# Load Africa map
load("data/africa_map.RData")
```

## Default maps

In order to access the default maps included with the **`tidyverse`** we will use the function `borders()`.


```r
ggplot() +
  borders(col = "black", fill = "cornsilk", size = 0.2) + # The global shape file
  coord_equal() # Equal sizing for lon/lat 
```

![(\#fig:maps-world)The built in global shape file.](09-mapping_style_files/figure-latex/maps-world-1.pdf) 

Jikes! It's as simple as that to load a map of the whole planet. Usually we are not going to want to make a map of the entire planet, so let's see how to focus on just the area around South Africa.


```r
sa_1 <- ggplot() +
  borders(size = 0.2, fill = "cornsilk", colour = "black") +
  coord_equal(xlim = c(12, 36), ylim = c(-38, -22), expand = 0) # Force lon/lat extent
sa_1
```

![(\#fig:maps-SA-1)A better way to get the map of South Africa.](09-mapping_style_files/figure-latex/maps-SA-1-1.pdf) 

That is a very tidy looking map of South(ern) Africa without needing to load any files.

## Specific labels

A map is almost always going to need some labels and other visual cues. We saw in the previous section how to add site labels. The following code chunk shows how this differs if we want to add just one label at a time. This can be useful if each label needs to be different from all other labels for whatever reason. We may also see that the text labels we are creating have `\n` in them. When R sees these two characters together like this it reads this as an instruction to return down a line. Let's run the code to make sure we see what this means.


```r
sa_2 <- sa_1 +
  annotate("text", label = "Atlantic\nOcean", 
           x = 15.1, y = -32.0, 
           size = 5.0, 
           angle = 30, 
           colour = "navy") +
  annotate("text", label = "Indian\nOcean", 
           x = 33.2, y = -34.2, 
           size = 5.0, 
           angle = 330, 
           colour = "red4")
sa_2
```

![(\#fig:maps-labels)Map of southern Africa with specific labels.](09-mapping_style_files/figure-latex/maps-labels-1.pdf) 

## Scale bars

With our fancy labels added, let's insert a scale bar next. There is no default scale bar function in the **`tidyverse`**, which is why we have loaded the **`ggsn`** package. This package is devoted to adding scale bars and North arrows to **`ggplot2`** figures. There are heaps of options so we'll just focus on one of them for now. It is a bit finicky so to get it looking exactly how we want it requires some guessing and checking. Please feel free to play around with the coordinates below. We may see the list of available North arrow shapes by running `northSymbols()`.


```r
sa_3 <- sa_2 +
  scalebar(x.min = 22, x.max = 26, y.min = -36, y.max = -35, # Set location of bar
           dist = 200, dist_unit = "km", height = 0.3, st.dist = 0.8, st.size = 4, # Set particulars
           transform = TRUE, border.size = 0.2, model = "WGS84") + # Set appearance
  north(x.min = 22.5, x.max = 25.5, y.min = -33, y.max = -31, # Set location of symbol
        scale = 1.2, symbol = 16)
sa_3
```

![(\#fig:maps-scale)Map of southern Africa with labels and a scale bar.](09-mapping_style_files/figure-latex/maps-scale-1.pdf) 

<!-- ## Insetting -->

<!-- In order to inset a smaller map inside of a larger map we must first create the smaller map. We have already loaded just such a map of Africa so we will use that for this example. -->

<!-- ```{r maps-mini, fig.align = "center"} -->

<!-- africa_map -->

<!-- ``` -->

<!-- And now to inset this map of Africa into our map of southern Africa we will need to learn how to create a 'grob'. This is very simple and does not require any extra work on our part. Remember that **`ggplot2`** objects are different from normal objects (i.e. dataframes), and that they have their own way of storing and accessing data. In order to convert any sort of thing into a format that ggplot understands we convert it into a grob, as shown below. Once converted, we may then plop it onto our figure/map wherever we please. Both of these steps are accomplished with the single function `annotation_custom()`. This is also a good way to add logos or any other sort of image to a map/figure. You can really go completely bananas. It's even possible to add GIFs. Such happy. Much excite. Very wonderment. -->

<!-- ```{r maps-inset, fig.cap="Map of southern Africa, with labels, scale bar, and an inset map of Africa."} -->

<!-- sa_4 <- sa_3 + -->

<!--   annotation_custom(grob = ggplotGrob(africa_map), -->

<!--                     xmin = 20.9, xmax = 26.9, -->

<!--                     ymin = -30, ymax = -24) -->

<!-- sa_4 -->

<!-- ``` -->

<!-- ## Rounding it out -->

<!-- There are a lot of exciting things going on in our figure now. To round out our adventures in mapping let's tweak the lon/lat labels to a more prestigious convention. There are two ways to do this. One of which requires us to install the **`scales`** package. Don't worry, it's a small one! -->

<!-- ```{r maps-final, fig.cap="The final map with all of the bells and whistles."} -->

<!-- sa_final <- sa_4 + -->

<!--   scale_x_continuous(breaks = seq(16, 32, 4), -->

<!--                      labels = c("16°E", "20°E", "24°E", "28°E", "32°E"), -->

<!--                      position = "bottom") + -->

<!--   scale_y_continuous(breaks = seq(-36, -24, 4), -->

<!--                      labels = c("36.0°S", "32.0°S", "28.0°S", "24.0°S"), -->

<!--                      position = "right") + -->

<!--   labs(x = "", y = "") -->

<!-- sa_final -->

<!-- ``` -->

<!-- And lastly we save the fruits of our labours. -->

<!-- ```{r maps-final-save, eval=FALSE} -->

<!-- ggsave(plot = sa_final, filename = "figures/southern_africa_final.pdf",  -->

<!--        height = 6, width = 8) -->

<!-- ``` -->

## Session inf


```r
installed.packages()[names(sessionInfo()$otherPkgs), "Version"]
```

```
R>      ggsn    scales   forcats   stringr     dplyr     purrr     readr     tidyr 
R>   "0.5.0"   "1.1.1"   "0.5.1"   "1.4.0"   "1.0.7"   "0.3.4"   "1.4.0"   "1.1.3" 
R>    tibble   ggplot2 tidyverse 
R>   "3.1.2"   "3.3.4"   "1.3.1"
```
