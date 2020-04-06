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




