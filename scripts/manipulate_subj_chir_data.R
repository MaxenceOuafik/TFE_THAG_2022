library(dplyr)
requireNamespace('scales')

.subj_chir_data_F <- subj_chir_data %>%
  select (2:5) %>%
  filter(!is.na(bes_mam))

.chir_data_F <- mutate(.subj_chir_data_F, N_chir = ifelse(.subj_chir_data_F$bes_mam == 2, 1, 0) +
                         ifelse(.subj_chir_data_F$bes_vag == 2, 1, 0)+
                         ifelse(.subj_chir_data_F$bes_ffs == 2, 1, 0)+ 
                         ifelse(.subj_chir_data_F$bes_voix == 2, 1, 0))


.N_mam <- sum(.chir_data_F$bes_mam == '2', na.rm = T)
.p_vag2 <- scales::percent(sum(.chir_data_F$bes_vag == '2', na.rm = T)/nrow(.chir_data_F))
.p_vag1 <- scales::percent(sum(.chir_data_F$bes_vag == '1', na.rm = T)/nrow(.chir_data_F))
.p_ffs2 <- scales::percent(sum(.chir_data_F$bes_ffs == '2', na.rm = T)/nrow(.chir_data_F))
.N_ffs1 <- sum(.chir_data_F$bes_ffs == '1', na.rm = T)
.N_chir0 <- sum(.chir_data_F$N_chir == '0')
.N_chir1 <- sum(.chir_data_F$N_chir == '1')
.N_chir2 <- sum(.chir_data_F$N_chir == '2')

.subj_chir_data_M <- subj_chir_data %>%
  select (6:9) %>%
  filter(!is.na(bes_torso))

.chir_data_M <- dplyr::mutate(.subj_chir_data_M, N_chir = ifelse(.subj_chir_data_M$bes_torso == 2, 1, 0) +
           ifelse(.subj_chir_data_M$bes_hystero == 2, 1, 0)+
           ifelse(.subj_chir_data_M$bes_phallo == 2, 1, 0)+ 
           ifelse(.subj_chir_data_M$bes_meta == 2, 1, 0))

.N_tot_attentes_chir_M <- nrow(.chir_data_M)
.p_torso2 <- scales::percent(sum(.chir_data_M$bes_torso == '2', na.rm = T)/.N_tot_attentes_chir_M)
.p_torso1 <- scales::percent(sum(.chir_data_M$bes_torso == '1', na.rm = T)/.N_tot_attentes_chir_M)
.p_hystero <- scales::percent(sum(.chir_data_M$bes_hystero == '2', na.rm = T)/.N_tot_attentes_chir_M)
.N_chir0M <- sum(.chir_data_M$N_chir == '0')
.N_chir1M <- sum(.chir_data_M$N_chir == '1')
.N_chir2M <- sum(.chir_data_M$N_chir == '2')