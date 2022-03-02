#R4DS Practice

#already installed
# install.packages("tidyverse")

library(tidyverse)

#install airline flight, world development, and baseball packages
install.packages(c("nycflights13", "gapminder", "Lahman"))

#load in the mpg dataframe
#this is an sample dataframe from the ggplot2 package
mpg<-ggplot2::mpg

#the first portion creates an empty graph, the "geom_point" overlays the graph w/ a scatterplot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

#empty, nothing to display
ggplot(data = mpg)

#get basic structure
str(mpg)
dim(mpg)
#234 rows, 11 columns (variables)

#help page
?mpg

#scatterplot of hwy vs. cyl
ggplot(data = mpg) + geom_point(mapping = aes(x = cyl, y = hwy))

#add an aesthetic
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class))
#can also use shape, alpha (this is transparency), or size aesthetics


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

#map a continuous variable to color, size, shape
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = cty, size = cty))
#becomes a gradient