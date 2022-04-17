library(dplyr)
.N_tot_attentes_F <- sum(!is.na(subj_horm_data$prio_poit))
.N_tot_attentes_M <- sum(!is.na(subj_horm_data$prio_voix))

.p_prio_poit <- percent((sum(subj_horm_data$prio_poit == '1', na.rm = T))/
                     .N_tot_attentes_F)

.p_prio_pilo_F <- percent((sum(subj_horm_data$prio_pilo_F == '1', na.rm = T))/
                     .N_tot_attentes_F)

.p_prio_gras_F <- percent((sum(subj_horm_data$prio_gras_F == '1', na.rm = T))/
                       .N_tot_attentes_F)

.p_prio_alo <- percent((sum(subj_horm_data$prio_alo == '1', na.rm = T))/
                                      .N_tot_attentes_F)

.p_prio_peau <- percent((sum(subj_horm_data$prio_peau == '1', na.rm = T))/
                                       .N_tot_attentes_F)

.p_prio_voix <- percent((sum(subj_horm_data$prio_voix == '1', na.rm = T))/
                          .N_tot_attentes_M)

.p_prio_gras_M <- percent((sum(subj_horm_data$prio_gras_M == '1', na.rm = T))/
                            .N_tot_attentes_M)

.p_prio_pilo_M <- percent((sum(subj_horm_data$prio_pilo_M == '1', na.rm = T))/
                       .N_tot_attentes_M)
                     