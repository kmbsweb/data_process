install.packages("tsibble")
library(tsibble)
library(dplyr)
library(ggplot2)

weather <- nycflights13::weather %>% 
  select(origin, time_hour, temp, humid, precip)
class(weather)
weather_tsbl <- as_tsibble(weather, key = origin, index = time_hour)
class(weather_tsbl)

pedestrian

# Multiple line plot
pedestrian %>% 
  ggplot(aes(x = Date_Time , y = Count)) + 
  geom_line(aes(color = Sensor), size = 0.2) +
  scale_color_brewer(palette = "Set1") +
  theme_minimal()


