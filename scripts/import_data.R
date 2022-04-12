library(readr)
obj_demog_data <- read_csv("./data/obj_demog_data.csv", 
                           col_types = cols(province = col_factor(levels = c("Liege", "Hainaut", "Luxembourg", "Namur", "Brabant Wallon", "Brabant Flamand")), 
                                            natio = col_factor(levels = c("Belge", "Francais")), 
                                            sexe = col_factor(levels = c("F", "M", "I")), 
                                            genre = col_factor(levels = c("F","M", "NB")), 
                                            mutuelle = col_factor(levels = c("BIM", "AO", "Non-inscrit")), 
                                            adm_pren = col_factor(levels = c("0", "1", "2")), 
                                            adm_cec = col_factor(levels = c("0", "1", "2"))))

sub_chir_data <- read_csv("./data/sub_chir_data.csv", 
                          col_types = cols(bes_mam = col_factor(levels = c("0","1", "2")), 
                                           bes_vag = col_factor(levels = c("0","1", "2")), 
                                           bes_ffs = col_factor(levels = c("0", "1", "2")), 
                                           bes_voix = col_factor(levels = c("0", "1", "2")), 
                                           bes_torso = col_factor(levels = c("0", "1", "2")), 
                                           bes_hystero = col_factor(levels = c("0","1", "2")), 
                                           bes_phallo = col_factor(levels = c("0", "1", "2")), 
                                           bes_meta = col_factor(levels = c("0", "1", "2"))))

subj_horm_data <- read_csv("./data/subj_horm_data.csv", 
                           col_types = cols(prio_poit = col_factor(levels = c("0", "1")), 
                                            prio_peau = col_factor(levels = c("0","1")), 
                                            prio_pilo_F = col_factor(levels = c("0", "1")), 
                                            prio_gras_F = col_factor(levels = c("0", "1")), 
                                            prio_musc_F = col_factor(levels = c("0", "1")), 
                                            prio_erec = col_factor(levels = c("0", "1")), 
                                            prio_alo = col_factor(levels = c("0", "1")), 
                                            prio_voix = col_factor(levels = c("0", "1")), 
                                            prio_ameno = col_factor(levels = c("0", "1")), 
                                            prio_pilo_M = col_factor(levels = c("0", "1")), 
                                            prio_gras_M = col_factor(levels = c("0", "1")), 
                                            prio_musc_M = col_factor(levels = c("0", "1")), 
                                            prio_dickclit = col_factor(levels = c("0", "1")), 
                                            inq_hum = col_factor(levels = c("0", "1")), 
                                            inq_alop = col_factor(levels = c("0", "1")), 
                                            inq_acne = col_factor(levels = c("0", "1")), 
                                            cryo = col_factor(levels = c("0", "1"))))

subj_soc_data <- read_csv("./data/subj_soc_data.csv", 
                          col_types = cols(fam_pers = col_factor(levels = c("0", "1", "2", "3", "4", "5", "6")), 
                                           fam_reac = col_factor(levels = c("0", "1", "2", "3")), 
                                           amis_pers = col_factor(levels = c("0", "1", "2", "3")), 
                                           amis_reac = col_factor(levels = c("0", "1", "2", "3"))))

obj_ant_data <- read_csv("./data/obj_ant_data.csv")

obj_chir_data <- read_csv("./data/obj_chir_data.csv", 
                          col_types = cols(real_mamm = col_factor(levels = c("0", "1", "2", "3")), 
                                           real_vag = col_factor(levels = c("0","1", "2", "3")), 
                                           real_ffs = col_factor(levels = c("0", "1", "2", "3")), 
                                           real_voix = col_factor(levels = c("0", "1", "2", "3")), 
                                           real_torso = col_factor(levels = c("0", "1", "2", "3")), 
                                           real_hystero = col_factor(levels = c("0", "1", "2", "3")), 
                                           real_phallo = col_factor(levels = c("0", "1", "2", "3")), 
                                           real_meta = col_factor(levels = c("0", "1", "2", "3"))))

obj_date_data <- read_csv("./data/obj_date_data.csv", 
                          col_types = cols(date_M0 = col_date(format = "%d/%m/%Y"), 
                                           date_M3 = col_date(format = "%d/%m/%Y"), 
                                           date_M6 = col_date(format = "%d/%m/%Y"), 
                                           date_M9 = col_date(format = "%d/%m/%Y"), 
                                           date_M12 = col_date(format = "%d/%m/%Y")))

obj_lab_data <- read_csv("./data/obj_lab_data.csv")

obj_param_data <- read_csv("./data/obj_param_data.csv")

obj_ttmt_data <- read_csv("./data/obj_ttmt_data.csv", 
                          col_types = cols(andro_type_M0 = col_factor(levels = c("Sustanon")),
                                           andro_type_M3 = col_factor(levels = c("Sustanon", "Nebido")), 
                                           andro_type_M6 = col_factor(levels = c("Sustanon", "Nebido")), 
                                           andro_type_M9 = col_factor(levels = c("Sustanon", "Nebido")), 
                                           andro_type_M12 = col_factor(levels = c("Sustanon","Nebido")), 
                                           oestro_type_M0 = col_factor(levels = c("Oestrogel","Dermestril", "Zumenon")), 
                                           oestro_type_M3 = col_factor(levels = c("Oestrogel","Dermestril", "Zumenon")), 
                                           oestro_type_M6 = col_factor(levels = c("Oestrogel", "Dermestril", "Zumenon")), 
                                           oestro_type_M9 = col_factor(levels = c("Oestrogel", "Dermestril", "Zumenon")), 
                                           oestro_type_M12 = col_factor(levels = c("Oestrogel", "Dermestril", "Zumenon")), 
                                           antiand_type_M0 = col_factor(levels = c("Aucun", "Spironolactone", "Depo-Eligard")), 
                                           antiand_type_M3 = col_factor(levels = c("Aucun", "Spironolactone", "Depo-Eligard")), 
                                           antiand_type_M6 = col_factor(levels = c("Aucun", "Spironolactone", "Depo-Eligard")), 
                                           antiand_type_M12 = col_factor(levels = c("Aucun", "Spironolactone", "Depo-Eligard"))))

outcome_data <- read_csv("./data/outcome_data.csv")
