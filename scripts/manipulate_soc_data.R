library(dplyr)
requireNamespace('scales')


.count_fam_pers <- subj_soc_data %>%
  left_join(obj_demog_data, by = 'patient') %>%
  filter(!is.na(fam_pers)) %>%
  select(patient, fam_pers, sexe, genre) %>%
  mutate(transition = as.factor(ifelse(sexe == 'M'|sexe == 'I',
                                       'Personnes transféminines',
                                       'Personnes transmasculines'))) %>%
  group_by(transition) %>%
  count(fam_pers)


levels(.count_fam_pers$fam_pers) <- c("Personne", 
                                      "Mère seulement",
                                      "Père seulement",
                                      "Les deux parents",
                                      "Parents + famille",
                                      "Quelques membres mais pas les parents",
                                      "Toute la famille") 

.count_fam_reac <- subj_soc_data %>%
  left_join(obj_demog_data, by = 'patient') %>%
  filter(!is.na(fam_reac)) %>%
  select(patient, fam_reac, genre, sexe) %>%
  mutate(transition = as.factor(ifelse(sexe == 'M'|sexe == 'I',
                                       'Personne transféminine',
                                       'Personne transmasculine'))) %>%
  group_by(transition) %>%
  count(fam_reac)

levels(.count_fam_reac$fam_reac) <- c("Réaction négative",
                                      "Quelques difficultés",
                                      "Réaction neutre",
                                      "Réaction positive")

.N_transfem <- sum(.count_fam_pers$n[.count_fam_pers$transition=='Personnes transféminines'])
.N_transfem_conceal <- sum(.count_fam_pers$n[.count_fam_pers$fam_pers!='Toute la famille' & 
                                               .count_fam_pers$fam_pers!='Les deux parents' & 
                                               .count_fam_pers$transition=='Personnes transféminines'])

.p_reac_neg <- scales::percent(sum(.count_fam_reac$n[.count_fam_reac$fam_reac != 'Réaction positive'])/
                         sum(.count_fam_reac$n))

.N_transmasc_neg <- sum(.count_fam_reac$n[.count_fam_reac$transition=='Personne transmasculine' &
                                            .count_fam_reac$fam_reac != 'Réaction positive'])


.count_amis_pers <- subj_soc_data %>%
  left_join(obj_demog_data, by = 'patient') %>%
  select(patient, amis_pers, sexe, genre) %>%
  mutate(transition = as.factor(ifelse(sexe == 'M'|sexe == 'I',
                                       'Personnes transféminines',
                                       'Personnes transmasculines'))) %>%
  filter(!is.na(amis_pers)) %>%
  group_by(transition) %>%
  count(amis_pers)

levels(.count_amis_pers$amis_pers) <- c("Aucun·e",
                              "Seulement les ami·e·s proches",
                              "La plupart",
                              "Tou·te·s ou presque")