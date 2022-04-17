library(dplyr)
library(tidyr)

.time_diff <- obj_date_data %>%
  transmute(patient = patient, 
            T0 = 0,
            T1 = as.double(difftime(date_T1,
                                    date_T0)),
            T2 = as.double(difftime(date_T2,
                                    date_T0)),
            T3 = as.double(difftime(date_T3,
                                    date_T0)),
            T4 = as.double(difftime(date_T4,
                                     date_T0))) %>%
  pivot_longer(!patient,
               names_to = 'consultation',
               values_to = 'jours_THAG',
               values_drop_na = TRUE)

.long_param <- obj_param_data %>%
  select(patient, 
         systol_T0, diastol_T0, 
         systol_T1, diastol_T1,
         systol_T2, diastol_T2,
         systol_T3, diastol_T3,
         systol_T4, diastol_T4) %>%
  pivot_longer(cols = !patient,
               names_to = c('tension', 'consultation'),
               names_sep = '_',
               values_to = 'valeur',
               values_drop_na = TRUE) %>%
  left_join(.time_diff, by = c('patient', 
                               'consultation')) %>%
  pivot_wider(names_from = 'tension',
              values_from = 'valeur') %>%
  left_join(obj_demog_data, by = 'patient') %>%
  mutate(transition = as.factor(ifelse(sexe == 'M'|sexe == 'I',
                                       'Personnes transféminines',
                                       'Personnes transmasculines'))) %>%
  select(patient, consultation, jours_THAG, systol, diastol, transition)
