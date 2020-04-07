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
) + geom_point(alpha = .5) +
  scale_colour_brewer(palette = "Dark2") 




ggplot(data = gapminder, 
       mapping = aes(x=lifeExp, y=country, colour=year)
) + geom_point()



#some more advanced summary plots!!!!

gapminder %>% 
  group_by(continent, year) %>% 
  summarise(mean_lifeExp=mean(lifeExp)) %>% 
  ggplot(aes(x=year, y=mean_lifeExp, colour=continent))+ 
  geom_point()

gapminder %>% 
  group_by(year) %>% 
  summarise(mean_lifeExp=mean(lifeExp), mean_pop=mean(pop)) %>% 
  ggplot(aes(x=year, y=mean_lifeExp, size=mean_pop))+ 
  geom_point()


#Transformations and statistics
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.5) + 
  scale_x_log10() + 
  geom_smooth(method = "lm", size = 2)   #method used is linear model


#one line for each continent and a general line
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(mapping = aes(colour = continent)) + 
  scale_x_log10() + 
  geom_smooth(mapping = aes(colour = continent), method = "lm", size = 2) +
  geom_smooth(method = "lm") #no colour by continent


#scales applied to colour
ggplot(data = gapminder, aes(x = year, y = lifeExp, color = continent)) +
  geom_point(size = 1) + 
  scale_x_log10() +
  scale_colour_manual(values = c("red", "green", "blue", "purple", "black")) #vector of colour values

#colour_brewer
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(mapping = aes(colour = continent)) + 
  scale_x_log10() + 
  scale_colour_brewer(palette = "Reds") +
  geom_smooth(mapping = aes(colour = continent), method = "lm", size = 2) 

#separating plots
a_countries <- filter(gapminder, str_starts(country, "A"))

ggplot(data = a_countries, aes(x = year, y = lifeExp, colour = continent, group = country)) +
  geom_line() + 
  facet_wrap( ~ country)


#challenge 12

ggplot(
  data = gapminder_1977, 
  mapping = aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop)
) +
  geom_point() +
  scale_x_log10()

#separate by continent in 1977
ggplot(
  data = gapminder_1977, 
  mapping = aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop)
) +
  geom_point() +
  facet_wrap(~continent)+
  scale_x_log10()


#separate by year the full gapminder
ggplot(
  data = gapminder, 
  mapping = aes(x = gdpPercap, y = lifeExp, colour = continent, group = year)
) +
  geom_point(size = 1) +
  facet_wrap(~year)+
  scale_x_log10()+
  scale_colour_brewer(palette = "Set1")

#ggplot(<DATA>, <AESTHETIC MAPPING>) + 
#<GEOMETRY FUNCTION> +
 # <GEOMETRY FUNCTION> +
  #<SCALE FUNCTION> +
  #<FACET FUNCTION> +
  #...
