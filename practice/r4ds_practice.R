#R4DS Practice

#already installed
# install.packages("tidyverse")

library(tidyverse)

#install airline flight, world development, and baseball packages
install.packages(c("nycflights13", "gapminder", "Lahman"))

#load in the mpg dataframe
#this is an sample dataframe from the ggplot2 package
mpg<-ggplot2::mpg

########## DATA VISUALIZATION ##########

#####GGPLOT#####

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
#drv variable is drive train

#scatterplot of hwy vs. cyl
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = cyl, y = hwy))

#scatterplot of class vs. drv
ggplot(data = mpg) +
  geom_point(mapping = aes(x = drv, y = class))
#not useful at all, we don't care about drive train vs. vehicle class

#####AESTHETICS#####

#add an aesthetic
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
#can also use shape, alpha (this is transparency), or size aesthetics

#use another aesthetic
ggplot(data=mpg) +
  geom_point(mapping=aes(x=cyl, y=hwy, size=class))
#notice the warning since we're mapping a size to a discrete variable

ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ, y=hwy, alpha=class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape=class))
#notice only six shapes used by default, so some classes are missed

#manually set aesthetic properties, this will set all points blue
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
#also note the different location of the aesthetic arg

#what is wrong with this? why are the points not blue?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
#because the color argument is being hard coded to the string "blue"

#which variables in mpg are categorical? continuous?
str(mpg)
?mpg
#cat = manufacturer, model, trans, drv, fl, class
#cont = displ, cty, hwy
#cyl is discrete, year

#map a continuous variable to color, size, shape
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = cty, size = displ))
#becomes a gradient
#cannot map cont variable to a shape

#map a categorical variable
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class, shape = drv))
#becomes discrete colors

#map same variable to aes
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = drv, shape = drv))
#applies both aes

#what does the "stroke" aes do?
?geom_point
#stroke modifies border width

#what happens if you map an aes to something other than a variable?
ggplot(data = mpg) + 
  geom_point(mapping=aes(x=displ, y=hwy, color=displ<5))
#it will "filter" the color on the condition

#####FACETS#####

#facets = subplots
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
#use a discrete variable to create facets
#facet_wrap is for a single variable

#facet_grid is for two variables
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

#can use a "." to remove either rows or columns
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cyl)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ .)

#what happens if you facet on a continuous variable?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap( ~ cty)
#you get a lot of subplots

#what do the empty cells mean?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl)) +
  facet_grid(drv ~ cyl)
#there are no points that meet both conditions

#what do the following make?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
#the first creates horizontal (row) plots
#the second creates vertical (column) plots

#consider
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
#vs
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
#advantages of facets? clear separation of classes, can compare within a class
#disadvantages? harder to compare between classes
#a larger data set might make faceted better, less congestion of points

?facet_wrap
#nrow = num rows
#ncol = num columns
#facet_grid does not have these, it is already sized accordingly

#####GEOMETRIC OBJECTS#####

#geoms are the geometrical objects
# left
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# right
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

#different geoms take different aesthetic arguments

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))
#linetype is for geom_smooth

#the group function
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))
#notice it does not add a legend

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )
#using an aes will add a legend, but can disable

#can also use multiple geoms per plot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
#this works, but adds duplication
#can do this instead:
#(these are GLOBAL mappings)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

#global vs local mappings
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()

#can also map different data per layer
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

#geom for line chart?
?geom_line
#boxplot?
?geom_boxplot
#histogram?
?geom_histogram
#area chart?
?geom_area

#what does this do?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)
#removes the confidence interval around the lines

#these are the same
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#graph examples:
base<-ggplot(data = mpg, mapping = aes(x = displ, y = hwy))

#1
base + geom_point() + geom_smooth(se = FALSE)

#2
base + geom_point() + geom_smooth(mapping = aes(group = drv), se = FALSE)

#3
base + geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(color = drv), se = F)

#4
base + geom_point(mapping = aes(color = drv)) +
  geom_smooth(se = F)

#5
base + geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(linetype = drv), se = F)

#6
base + geom_point(size = 4, color = "white") +
  geom_point(aes(color = drv))

#####STATISTICAL TRANSFORMATIONS#####
?diamonds
#load in the data set
diamonds<-ggplot2::diamonds
dim(diamonds)
str(diamonds)

#more high quality cuts
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))
#notice the count (y-axis) was automatically calculated
#this is the "stat" argument
?geom_bar

#can use a stat also
ggplot(data=diamonds)+
  stat_count(aes(x=cut))
#same as geom_bar plot
#this works because geom_bar's default stat is count

#can override default stat
#this will give proportion
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))
#note: group = 1 is required to get correct proportions
#otherwise it will group based on individual x values

#another example
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )
#use help pages for details
?stat_summary
#this creates a summary for each y value

#what is the problem with these two graphs?
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = after_stat(prop)))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = after_stat(prop)))
#they both show 100% proportion for each x-value
#fixed
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = after_stat(prop), group = 1))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = after_stat(count)/sum(count)))

#####POSITION ADJUSTMENTS#####

#two ways to color charts
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

#try mapping to another variable
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")
#position="identity" causes overlap w/ bars, this is because it places each object
#exactly where it falls within the graph

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")
#position="fill" will make all bars the same height
#this makes it easy to compare proportions across groups

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")
#position="dodge" places buckets next to each other

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")
#position="jitter" adds a small amount of random noise to each point
#this is useful against overplotting (where the points are so layered that we can't tell
#where the groupings are)
#there is a shorthand called "geom_jitter()"

#can read about these with ?position_jitter/dodge/etc
?position_dodge

#####COORDINATE SYSTEMS#####

#can switch x and y axis with coord_flip()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
#vs
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()

#coord_quickmap will set the aspect ratio for maps
nz <- map_data("nz")
#map_data requires the map package

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()

#coord_polar example vs bar chart
bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

#practice
ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut, fill = cut))

########## DATA TRANSFORMATION ##########

#####DPLYR#####
#this section will go over data manipulation - dplyr

library(nycflights13)
library(tidyverse)

flights
view(flights)

#five dplyr functions:
#filter, arrange, select, mutate, summarise
#can use all of these with group_by

#####FILTER#####

#using the flights data frame

#default (comma separted filters) use AND

#gets all flights from 1/1
filter(flights, month==1, day==1)

jan1<-filter(flights, month==1, day==1)
view(jan1)

#note: can get output + assignment by wrapping the whole expression in parenthesis
(jan1<-filter(flights, month==1, day==1))

#comparing int and dbl
sqrt(2) ^ 2 == 2

#can use "near"
near(sqrt(2)^2, 2)
?near

#find all flights from Nov and Dec
filter(flights, month == 11 | month == 12)
#this is the same as
filter(flights, month %in% c(11,12))

#more examples
filter(flights, !(arr_delay > 120 | dep_delay > 120))
#this is the same as
filter(flights, arr_delay <= 120, dep_delay <= 120)

#check for NA values
x<-NA
is.na(x)       

#find all flights...
#with an arrival delay of two or more hours
filter(flights, flights$arr_delay >= 120)
#that flew to Houston (IAH or HOU)
view(filter(flights, dest == "IAH" | dest == "HOU"))
#note - can use view to output to a new tab if the output is too big for terminal
#were operated by united (UA), american (AA), or delta (DL)
filter(flights, carrier == 'UA' | carrier == 'AA' | carrier == 'DL')
#departed in summer (July, August, September)
filter(flights, month == 7 | month == 8 | month == 9)
#better:
filter(flights, month %in% 7:9)
#or
filter(flights, month >= 7, month <=9)
#arrived more than two hours late, but didn't leave late
filter(flights, arr_delay > 120 & dep_delay <= 0)
#that were delayed by at least an hour but made up over 30 min in flight
filter(flights, dep_delay >= 60, dep_delay - arr_delay > 30)
#departed between 6am and midnight
#first, how is midnight represented?
summary(flights$dep_time)
#min = 1, max = 2400
filter(flights, dep_time <= 600 | dep_time == 2400)

#use the between helper
filter(flights, between(month, 7, 9))
#this is the same as the above "departed in summer" examples

#find flights missing dep_time
filter(flights, is.na(dep_time))
summary(flights$dep_time)

#find other missing values
summary(flights)
#NAs mean they are likely cancelled flights
#NAs in air_time, arr_delay, arr_time, dep_delay, dep_time

#evaluate the following NA statements and explain
NA ^ 0
#this is == 1, x ^ 0 is always 1
NA | TRUE
#this is TRUE, x OR TRUE is always TRUE
FALSE & NA
#this is FALSE, x AND FALSE is always FALSE
NA * 0
#this is NA, the reason is because x could be infinity or -infinity
Inf * 0 # == NaN
-Inf * 0 # == NaN

#####ARRANGE#####

#this is similar to filter, except it changes the order of rows

arrange(flights, year, month, day)

#desc for descending order
arrange(flights, desc(dep_delay))

#missing (NA) values are always sorted at the end
#example
df<-tibble(x=c(5,2,NA))
df
arrange(df, x)
arrange(df, desc(x))
rm(df) #remove the df object

#use arrange to put NA values at the start instead of the end
view(arrange(flights, desc(is.na(dep_delay))))
#note - the above will only put the NA values at the top but not sort the others
#use this:
view(arrange(flights, desc(is.na(dep_delay)), dep_delay))
        