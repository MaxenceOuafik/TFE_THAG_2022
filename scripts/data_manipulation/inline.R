source('scripts/data_manipulation/create_long_data.R', encoding = 'UTF-8')
# Démographie 
.ant_genre <- obj_ant_data %>%
  left_join(obj_demog_data, by = 'patient')
.N_TSA_F <- sum(.ant_genre$elem_med_1 == 'TSA'& .ant_genre$genre == 'F', 
                na.rm = T) + 
  sum(.ant_genre$elem_med_2 == 'TSA'& .ant_genre$genre == 'F', 
      na.rm = T)

.p_BIM <- scales::percent(sum(obj_demog_data$mutuelle == 'BIM')/nrow(obj_demog_data))

# Eléments de soin 
.N_dep <- sum(obj_ant_data$elem_med_1 == "depression", na.rm = T)
.p_dep <- scales::percent(.N_dep/nrow(obj_ant_data))
.N_anx <- sum(obj_ant_data$elem_med_1 == "trouble anxieux", na.rm = T)
.N_alc <- sum(obj_ant_data$elem_med_2 == "mesusage d'alcool", na.rm = T)

# Chirurgie 
.subj_chir_data_F <- subj_chir_data %>%
  left_join(obj_demog_data, by = 'patient') %>%
  filter(genre == 'F') 

.chir_data_F <- mutate(.subj_chir_data_F, N_chir = ifelse(.subj_chir_data_F$bes_mam == 2, 1, 0) +
                         ifelse(.subj_chir_data_F$bes_vag == 2, 1, 0)+
                         ifelse(.subj_chir_data_F$bes_ffs == 2, 1, 0)+ 
                         ifelse(.subj_chir_data_F$bes_voix == 2, 1, 0)) %>%
  filter(!is.na(N_chir))
  

.subj_chir_data_M <- subj_chir_data %>%
  left_join(obj_demog_data, by = 'patient') %>%
  filter(genre == 'M')

.chir_data_M <- mutate(.subj_chir_data_M, N_chir = ifelse(.subj_chir_data_M$bes_torso == 2, 1, 0) +
                                ifelse(.subj_chir_data_M$bes_hystero == 2, 1, 0)+
                                ifelse(.subj_chir_data_M$bes_phallo == 2, 1, 0)+ 
                                ifelse(.subj_chir_data_M$bes_meta == 2, 1, 0)) %>%
  filter(!is.na(N_chir))

.N_mam <- sum(.chir_data_F$bes_mam == '2', na.rm = T)
.p_vag2 <- scales::percent(sum(.chir_data_F$bes_vag == '2', na.rm = T)/nrow(.chir_data_F))
.p_vag1 <- scales::percent(sum(.chir_data_F$bes_vag == '1', na.rm = T)/nrow(.chir_data_F))
.p_ffs2 <- scales::percent(sum(.chir_data_F$bes_ffs == '2', na.rm = T)/nrow(.chir_data_F))
.N_ffs1 <- sum(.chir_data_F$bes_ffs == '1', na.rm = T)
.N_chir0 <- sum(.chir_data_F$N_chir == '0')
.N_chir1 <- sum(.chir_data_F$N_chir == '1')
.N_chir2 <- sum(.chir_data_F$N_chir == '2')

.N_tot_attentes_chir_M <- nrow(.chir_data_M)
.p_torso2 <- scales::percent(sum(.chir_data_M$bes_torso == '2', na.rm = T)/.N_tot_attentes_chir_M)
.p_torso1 <- scales::percent(sum(.chir_data_M$bes_torso == '1', na.rm = T)/.N_tot_attentes_chir_M)
.p_hystero <- scales::percent(sum(.chir_data_M$bes_hystero == '2', na.rm = T)/.N_tot_attentes_chir_M)
.N_chir0M <- sum(.chir_data_M$N_chir == '0')
.N_chir1M <- sum(.chir_data_M$N_chir == '1')
.N_chir2M <- sum(.chir_data_M$N_chir == '2')

# Hormones
.N_tot_attentes_F <- sum(!is.na(subj_horm_data$prio_poit))
.N_tot_attentes_M <- sum(!is.na(subj_horm_data$prio_voix))

.p_prio_poit <- scales::percent((sum(subj_horm_data$prio_poit == '1', na.rm = T))/
                                  .N_tot_attentes_F)

.p_prio_pilo_F <- scales::percent((sum(subj_horm_data$prio_pilo_F == '1', na.rm = T))/
                                    .N_tot_attentes_F)

.p_prio_gras_F <- scales::percent((sum(subj_horm_data$prio_gras_F == '1', na.rm = T))/
                                    .N_tot_attentes_F)

.p_prio_alo <- scales::percent((sum(subj_horm_data$prio_alo == '1', na.rm = T))/
                                 .N_tot_attentes_F)

.p_prio_peau <- scales::percent((sum(subj_horm_data$prio_peau == '1', na.rm = T))/
                                  .N_tot_attentes_F)

.p_prio_voix <- scales::percent((sum(subj_horm_data$prio_voix == '1', na.rm = T))/
                                  .N_tot_attentes_M)

.p_prio_gras_M <- scales::percent((sum(subj_horm_data$prio_gras_M == '1', na.rm = T))/
                                    .N_tot_attentes_M)

.p_prio_pilo_M <- scales::percent((sum(subj_horm_data$prio_pilo_M == '1', na.rm = T))/
                                    .N_tot_attentes_M)

.N_voix_seul <- subj_horm_data %>%
  filter(prio_voix == 1 &
           prio_dickclit == 0 &
           prio_ameno == 0 &
           prio_pilo_M == 0 & 
           prio_gras_M == 0 &
           prio_musc_M == 0) %>%
  nrow()

# Traitement

.poso_oestro <- obj_ttmt_data %>%
  select(1, seq(13,19, 2)) %>%
  rename(oestro_pos_T1 = oestro_pos_T0,
         oestro_pos_T2 = oestro_pos_T1,
         oestro_pos_T3 = oestro_pos_T2,
         oestro_pos_T4 = oestro_pos_T3) %>%
  pivot_longer(cols = !patient,
               names_sep = '_',
               names_to = c('type', 'variable', 'consultation'),
               values_to = 'posologie',
               values_drop_na = TRUE) %>%
  left_join(.long_oestro_data, by = c('patient', 'consultation'))


.poso_gel <- .poso_oestro %>%
  filter(oestrogène == 'Oestrogel') %>%
  select(posologie) %>%
  pull()

.poso_patch <- .poso_oestro %>%
  filter(oestrogène == 'Dermestril')%>%
  select(posologie) %>%
  pull()

.poso_pill <- .poso_oestro %>%
  filter(oestrogène == 'Zumenon')%>%
  select(posologie) %>%
  pull()

.med_cout_F <- obj_ttmt_data %>% filter(!is.na(antiand_type_T0)) %>% select(cout_an) %>% pull %>% median()


.N_200 <- .long_outcome_data %>% 
  filter(O2 > 200, transition == 'Personnes transféminines') %>% 
  distinct(patient) %>% 
  count() %>% 
  pull()

.med_cout_M <- obj_ttmt_data %>% filter(!is.na(andro_type_T0)) %>% select(cout_an) %>% pull %>% median()
.min_cout_M <- obj_ttmt_data %>% filter(!is.na(andro_type_T0)) %>% select(cout_an) %>% pull %>% min()
.max_cout_M <- obj_ttmt_data %>% filter(!is.na(andro_type_T0)) %>% select(cout_an) %>% pull %>% max()


