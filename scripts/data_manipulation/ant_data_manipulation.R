library(tidyverse)
requireNamespace('scales')

.N_dep <- sum(obj_ant_data$elem_med_1 == "depression", na.rm = T)
.p_dep <- scales::percent(.N_dep/nrow(obj_ant_data))
.N_anx <- sum(obj_ant_data$elem_med_1 == "trouble anxieux", na.rm = T)
.N_alc <- sum(obj_ant_data$elem_med_2 == "mesusage d'alcool", na.rm = T)

.ant_genre <- obj_ant_data %>%
  left_join(obj_demog_data, by = 'patient') %>%
  select(elem_med_1, elem_med_2, elem_med_3, genre)

.N_TSA_F <- sum(.ant_genre$elem_med_1 == 'TSA'& .ant_genre$genre == 'F', 
    na.rm = T) + 
  sum(.ant_genre$elem_med_2 == 'TSA'& .ant_genre$genre == 'F', 
      na.rm = T)
