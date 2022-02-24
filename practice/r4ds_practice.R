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