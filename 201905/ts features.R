devtools::install_github("robjhyndman/tsfeatures")
library(tsfeatures)
AirPassengers
entropy(AirPassengers)
max_level_shift(AirPassengers)
plot(AirPassengers)

library(tsfeatures)
library(dplyr)

yahoo <- yahoo_data()
plot(yahoo[,1:10])
class(yahoo)
str(yahoo)

hwl <- bind_cols(
  tsfeatures(yahoo,
             c("acf_features","entropy","lumpiness",
               "flat_spots","crossing_points")),
  tsfeatures(yahoo,"stl_features", s.window='periodic', robust=TRUE),
  tsfeatures(yahoo, "max_kl_shift", width=48),
  tsfeatures(yahoo,
             c("mean","var"), scale=FALSE, na.rm=TRUE),
  tsfeatures(yahoo,
             c("max_level_shift","max_var_shift"), trim=TRUE)) %>%
  select(mean, var, x_acf1, trend, linearity, curvature,
         seasonal_strength, peak, trough,
         entropy, lumpiness, spike, max_level_shift, max_var_shift, flat_spots,
         crossing_points, max_kl_shift, time_kl_shift)


library(ggplot2)
hwl_pca <- hwl %>%
  na.omit() %>%
  prcomp(scale=TRUE)
hwl_pca$x %>%
  as_tibble() %>%
  ggplot(aes(x=PC1, y=PC2)) +
  geom_point()
