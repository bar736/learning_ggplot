library(tidyverse)

gapminder <- read_csv("data/gapminder.csv")

gapminder_1977 <- filter(gapminder, year == 1977)

#creation of plot aesthetics ggplot(<DATA>, <AESTHETIC MAPPINGS>) + <GEOMETRY LAYERS>
ggplot(
  data = gapminder_1977,
  mapping = aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop)
  
  #adding the geometry
  ) + geom_point() +
  scale_x_log10()

#There are six variables in the gapminder_1977 data frame, 
#country, year, pop, continent, lifeExp, and gdpPercap. 
#Although as year contains just the value 1977 it is not that informative.
#play with the variables

ggplot(gapminder_1977, aes(x = continent, y = gdpPercap, colour = lifeExp, size=pop)
       ) + geom_point()

#other graph
ggplot(gapminder_1977, aes(x = country, y = gdpPercap, colour = continent, size = pop)
) + geom_point()

#more graphs
gapminder_1977 %>%
  ggplot() +
  geom_point(mapping = aes(x = gdpPercap, y = lifeExp, 
                           colour = continent, size = pop, shape = continent))+
  geom_line(mapping = aes(x= gdpPercap, y = lifeExp))+
  scale_x_log10()

#find what aesthetics are understodd by geom_point...
help("geom_point")

gapminder_1977 %>%
  ggplot() +
  geom_point(mapping = aes(x = gdpPercap, y = lifeExp, 
                           shape = continent, size = pop))+
  scale_x_log10()

#only in blue colour
ggplot(gapminder_1977, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(colour = "blue", size = 5) +
  scale_x_log10()

#challenhe 6: Setting an aesthetic in the geometry overrides the mapping of that aesthetic.
ggplot(
  data = gapminder_1977, 
  mapping = aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop)
) +
  geom_point(colour = "red") +
  scale_x_log10()


#more tests making the shape transparents with alpha
ggplot(data = gapminder_1977, 
  mapping = aes(x = gdpPercap, y = lifeExp, shape = continent, size = pop)
) +
  geom_point(alpha = .4) +
  scale_x_log10()

#challenge show how lifeExp has change with time in gapminder

ggplot(data = gapminder, 
       mapping = aes(x=lifeExp, y=year, colour=continent)
) + geom_point(alpha = .2)



ggplot(data = gapminder, 
       mapping = aes(x=lifeExp, y=country, colour=year)
) + geom_point()
