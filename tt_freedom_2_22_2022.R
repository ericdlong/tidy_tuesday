#Tidy Tuesday - 2/22/2022
#Eric Long

#####Load Libraries

library(tidytuesdayR)
library(tidyverse)

#####Read in data, code taken from https://github.com/rfordatascience/tidytuesday/tree/master/data/2022/2022-02-22

# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-02-22')
freedom <- tuesdata$freedom
