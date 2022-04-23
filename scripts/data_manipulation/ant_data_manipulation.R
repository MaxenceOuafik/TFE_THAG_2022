library(tidyverse)
requireNamespace('scales')

.ant_genre <- obj_ant_data %>%
  left_join(obj_demog_data, by = 'patient') %>%
  select(elem_med_1, elem_med_2, elem_med_3, genre)


