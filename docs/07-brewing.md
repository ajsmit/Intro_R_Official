# Brewing colours in **`ggplot2`** {#brewing}

> "Every portrait that is painted with feeling is a portrait of the artist, not of the sitter."
>
> --- Oscar Wilde
  
> "If you could say it in words, there would be no reason to paint."
>
> --- Edward Hopper



Now that we have seen the basics of **`ggplot2`**, let's take a moment to delve further into the beauty of our figures. It may sound vain at first, but the colour palette of a figure is actually very important. This is for two main reasons. The first being that a consistent colour palette looks more professional. But most importantly it is necessary to have a good colour palette because it makes the information in our figures easier to understand. The communication of information to others is central to good science.

## R Data

Before we get going on our figures, we first need to learn more about the built in data that R has. The base R program that we all have loaded on our computers already comes with heaps of example dataframes that we may use for practice. We don't need to load our own data. Additionally, whenever we install a new package (and by now we've already installed dozens) it usually comes with several new dataframes. There are many ways to look at the data that we have available from our packages. Below we show two of the many options.


```r
# To create a list of ALL available data
  # Not really recommended as the output is overwhelming
data(package = .packages(all.available = TRUE))

# To look for datasets within a single known package
  # type the name of the package followed by '::'
  # This tells R you want to look in the specified package
  # When the autocomplete bubble comes up you may scroll
  # through it with the up and down arrows
  # Look for objects that have a mini spreadsheet icon
  # These are the datasets

# Try typing the following code and see what happens...
datasets::
```

We have an amazing amount of data available to us. So the challenge is not to find a dataframe that works for us, but to just decide on one. My preferred method is to read the short descriptions of the dataframes and pick the one that sounds the funniest. But please use whatever method makes the most sense to you. One note of caution, in R there are generally two different forms of data: wide OR long. We will see in detail what this means on Day 4, and what to do about it. For now we just need to know that **`ggplot2`** works much better with long data. To look at a dataframe of interest we use the same method we would use to look up a help file for a function.

Over the years I've installed so many packages on my computer that it is difficult to chose a dataframe. The package **`boot`** has some particularly interesting dataframes with a biological focus. Please install this now to access to these data. I have decided to load the `urine` dataframe here. Note that `library(boot)` will not work on your computer if you have not installed the package yet. With these data we will now make a scatterplot with two of the variables, while changing the colour of the dots with a third variable.


```r
# Load libraries
library(tidyverse)
library(boot)

# Load data
urine <- boot::urine

# Look at help file for more info
# ?urine

# Create a quick scatterplot
ggplot(data = urine, aes(x = osmo, y = ph)) +
  geom_point(aes(colour = cond))
```

![](07-brewing_files/figure-latex/brew-1-1.pdf)<!-- --> 

And now we have a scatterplot that is showing the relationship between the osmolarity and pH of urine, with the conductivity of those urine samples shown in shades of blue. What is important to note here is that the colour scale is continuous. How can we now this by looking at the figure? Let's look at the same figure but use a discrete variable for colouring.


```r
ggplot(data = urine, aes(x = osmo, y = ph)) +
  geom_point(aes(colour = as.factor(r)))
```

![](07-brewing_files/figure-latex/brew-2-1.pdf)<!-- --> 

What is the first thing you notice about the difference in the colours? Why did we use `as.factor()` for the colour aesthetic for our points? What happens if we don't use this? Try it now.

## **`RColorBrewer`**

Central to the purpose of **`ggplot2`** is the creation of beautiful figures. For this reason there are many built in functions that we may use in order to have precise control over the colours we use, as well as additional packages that extend our options even further. The **`RColorBrewer`** package should have been installed on your computer and activated automatically when we installed and activated the **`tidyverse`**. We will use this package for its lovely colour palettes. Let's spruce up the previous continuous colour scale figure now.


```r
# The continuous colour scale figure
ggplot(data = urine, aes(x = osmo, y = ph)) +
  geom_point(aes(colour = cond)) +
  scale_colour_distiller() # Change the continuous variable colour palette
```

![](07-brewing_files/figure-latex/brew-3-1.pdf)<!-- --> 

Does this look different? If so, how? The second page of the colour cheat sheet we included in the course material shows some different colour brewer palettes. Let's look at how to use those here.


```r
ggplot(data = urine, aes(x = osmo, y = ph)) +
  geom_point(aes(colour = cond)) +
  scale_colour_distiller(palette = "Spectral")
```

![](07-brewing_files/figure-latex/brew-4-1.pdf)<!-- --> 

Does that help us to see a pattern in the data? What do we see? Does it look like there are any significant relationships here? How would we test that?

If we want to use colour brewer with a discrete variable we use a slightly different function.


```r
ggplot(data = urine, aes(x = osmo, y = ph)) +
  geom_point(aes(colour = as.factor(r))) +
  scale_colour_brewer() # This is the different function
```

![](07-brewing_files/figure-latex/brew-5-1.pdf)<!-- --> 

The default colour scale here is not helpful at all. So let's pick a better one. If we look at our cheat sheet we will see a list of different continuous and discrete colour scales. All we need to do is copy and paste one of these names into our colour brewer function with inverted commas.


```r
ggplot(data = urine, aes(x = osmo, y = ph)) +
  geom_point(aes(colour = as.factor(r))) +
  scale_colour_brewer(palette = "Set1") # Here I used "Set1", but use what you like
```

![](07-brewing_files/figure-latex/brew-6-1.pdf)<!-- --> 

## Make your own palettes

This is all well and good. But didn't we claim that this should give us complete control over our colours? So far it looks like it has just given us a few more palettes to use. And that's nice, but it's not 'infinite choices'. That is where the Internet comes to our rescue. There are many places we may go to for support in this regard. The following links, in descending order, are very useful. And fun!

- <http://tristen.ca/hcl-picker/#/hlc/6/0.95/48B4B6/345363>
- <http://tools.medialab.sciences-po.fr/iwanthue/index.php>
- <http://jsfiddle.net/d6wXV/6/embedded/result/>

I find the first link the easiest to use. But the second and third links are better at generating discrete colour palettes. Take several minutes playing with the different websites and decide for yourself which one(s) you like.

## Use your own palettes

Now that we've had some time to play around with the colour generators let's look at how to use them with our figures. I've used the first web link to create a list of five colours. I then copy and pasted them into the code below, separating them with commas and placing them inside of `c()` and inverted commas. Be certain that you insert commas and inverted commas as necessary or you will get errors. Note also that we are using a new function to use our custom palette.


```r
ggplot(data = urine, aes(x = osmo, y = ph)) +
  geom_point(aes(colour = cond)) +
  scale_colour_gradientn(colours = c("#A5A94D", "#6FB16F", "#45B19B",
                                    "#59A9BE", "#9699C4", "#CA86AD"))
```

![](07-brewing_files/figure-latex/brew-7-1.pdf)<!-- --> 

If we want to use our custom colour palettes with a discrete colour scale we use a different function as seen in the code below. While we are at it, let's also see how to correct the title of the legend and its text labels. Sometimes the default output is not what we want for our final figure. Especially if we are going to be publishing it. Also note in the following code chunk that rather than using hexadecimal character strings to represent colours in our custom palette, we are simply writing in the human name for the colours we want. This will work for the continuous colour palettes above, too.


```r
ggplot(data = urine, aes(x = osmo, y = ph)) +
  geom_point(aes(colour = as.factor(r))) +
  scale_colour_manual(values = c("pink", "maroon"), # How to use custom palette
                     labels = c("no", "yes")) + # How to change the legend text
  labs(colour = "crystals") # How to change the legend title
```

![](07-brewing_files/figure-latex/brew-8-1.pdf)<!-- --> 

So now we have seen how to control the colours palettes in our figures. I know it is a but much. Four new functions just to change some colours! That's a bummer. Don't forget that one of the main benefits of R is that all of your code is written down, annotated and saved. You don't need to remember which button to click to change the colours, you just need to remember where you saved the code that you will need. And that's pretty great in my opinion.

## DIY figures

Today we learned the basics of **`ggplot2`**, how to facet, how to brew colours, and how to plot stats. Sjog, that's a lot of stuff to remember! Which is why we will now spend the rest of Day 2 putting our new found skills to use. Please group up as you see fit to produce your very own **`ggplot2`** figures. We've not yet learned how to manipulate/tidy up our data so it may be challenging to grab any ol' dataset and make a plan with it. To that end we recommend using the `laminaria` or `ecklonia` datasets we saw on Day 1. You are of course free to use whatever dataset you would like, including your own. The goal by the end of today is to have created at least two figures (first prize for four figures) and join them together via faceting. We will be walking the room to help with any issues that may arise.

## Session info

```r
installed.packages()[names(sessionInfo()$otherPkgs), "Version"]
```

```
R>      boot   forcats   stringr     dplyr     purrr     readr     tidyr    tibble 
R>  "1.3-26"   "0.5.1"   "1.4.0"   "1.0.5"   "0.3.4"   "1.4.0"   "1.1.3"   "3.1.0" 
R>   ggplot2 tidyverse 
R>   "3.3.3"   "1.3.0"
```
