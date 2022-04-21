library(tidyverse)

# Données temporelles convertissant le délai entre deux dates en jours

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
               values_drop_na = T)

# Version longue des données sur les paramètres 

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

# Version longue des données de laboratoire

.long_lab_data <- obj_lab_data %>%
  pivot_longer(cols = !patient,
               names_sep = '_',
               names_to = c('paramètre', 'consultation'),
               values_drop_na = TRUE) %>%
  pivot_wider(names_from = 'paramètre',
              values_from = 'value') %>%
  left_join(obj_demog_data, by = 'patient') %>%
  mutate(transition = as.factor(ifelse(sexe == 'M'|sexe == 'I',
                                       'Personnes transféminines',
                                       'Personnes transmasculines'))) %>%
  left_join(.time_diff, by = c('patient', 
                               'consultation')) %>%
  select(patient, transition, consultation, jours_THAG, 3:12)

# Version longue des données sur le traitement par androgènes 

.long_andro_data <- obj_ttmt_data %>%
  select(1, seq(2, 8, 2)) %>%
  rename(andro_type_T1 = andro_type_T0,
         andro_type_T2 = andro_type_T1,
         andro_type_T3 = andro_type_T2,
         andro_type_T4 = andro_type_T3) %>%
  pivot_longer(cols = !patient,
               names_sep = '_',
               names_to = c('type', 'variable', 'consultation'),
               values_to = 'androgène',
               values_drop_na = TRUE) %>%
  select(patient, consultation, androgène)
.long_andro_data$androgène <- as.character(.long_andro_data$androgène)

# Version longue des données sur le traitement par oestrogènes


.long_oestro_data <- obj_ttmt_data %>%
  select(1, seq(12,18, 2)) %>%
  rename(oestro_type_T1 = oestro_type_T0,
         oestro_type_T2 = oestro_type_T1,
         oestro_type_T3 = oestro_type_T2,
         oestro_type_T4 = oestro_type_T3) %>%
  pivot_longer(cols = !patient,
               names_sep = '_',
               names_to = c('type', 'variable', 'consultation'),
               values_to = 'oestrogène',
               values_drop_na = TRUE) %>%
  select(patient, consultation, oestrogène)

# Version longue des données sur le traitement par antiandrogènes 


.long_antiandro_data <- obj_ttmt_data %>%
  select(1, seq(22,28,2)) %>%
  rename(antiand_type_T1 = antiand_type_T0,
         antiand_type_T2 = antiand_type_T1,
         antiand_type_T3 = antiand_type_T2,
         antiand_type_T4 = antiand_type_T3,) %>%
  pivot_longer(cols = !patient,
               names_sep = '_',
               names_to = c('type', 'variable', 'consultation'),
               values_to = 'antiandrogène',
               values_drop_na = TRUE) %>%
  select(patient, consultation, antiandrogène)

# Version longue des outcomes

.long_data <- outcome_data %>%
  pivot_longer(cols = !patient,
               names_sep = '_',
               names_to = c('paramètre', 'consultation'),
               values_drop_na = TRUE) %>%
  pivot_wider(names_from = 'paramètre',
              values_from = 'value')
  

.long_outcome_data <- obj_date_data %>%
  pivot_longer(cols = !patient,
               names_sep = '_',
               names_to = c('text', 'consultation'),
               values_to = 'date',
               values_drop_na = T) %>%
  select(patient, consultation) %>%
  left_join(obj_demog_data, by = 'patient') %>%
  mutate(transition = as.factor(ifelse(sexe == 'M'|sexe == 'I',
                                       'Personnes transféminines',
                                       'Personnes transmasculines'))) %>%
  left_join(.long_data, by = c('patient', 'consultation')) %>%
  left_join(.long_andro_data,by = c('patient', 
                                    'consultation'))  %>%
  left_join(.long_oestro_data, by = c('patient', 
                                      'consultation')) %>%
  left_join(.long_antiandro_data, by = c('patient', 
                                         'consultation')) %>%
  left_join(.time_diff, by = c('patient', 'consultation'))