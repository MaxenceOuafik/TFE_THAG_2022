library(tidyverse)
requireNamespace('scales')

.subj_chir_data_F <- subj_chir_data %>%
  select (2:5) %>%
  filter(!is.na(bes_mam))

.chir_data_F <- mutate(.subj_chir_data_F, N_chir = ifelse(.subj_chir_data_F$bes_mam == 2, 1, 0) +
                         ifelse(.subj_chir_data_F$bes_vag == 2, 1, 0)+
                         ifelse(.subj_chir_data_F$bes_ffs == 2, 1, 0)+ 
                         ifelse(.subj_chir_data_F$bes_voix == 2, 1, 0))

.subj_chir_data_M <- subj_chir_data %>%
  select (6:9) %>%
  filter(!is.na(bes_torso))

.chir_data_M <- dplyr::mutate(.subj_chir_data_M, N_chir = ifelse(.subj_chir_data_M$bes_torso == 2, 1, 0) +
           ifelse(.subj_chir_data_M$bes_hystero == 2, 1, 0)+
           ifelse(.subj_chir_data_M$bes_phallo == 2, 1, 0)+ 
           ifelse(.subj_chir_data_M$bes_meta == 2, 1, 0))