library(readr)
obj_demog_data <- read_csv("./data/obj_demog_data.csv", 
                           col_types = cols(province = readr::col_factor(levels = c("Liege", "Hainaut", "Luxembourg", "Namur", "Brabant Wallon", "Brabant Flamand")), 
                                            natio = readr::col_factor(levels = c("Belge", "Francais")), 
                                            sexe = readr::col_factor(levels = c("F", "M", "I")), 
                                            genre = readr::col_factor(levels = c("F","M", "NB")), 
                                            mutuelle = readr::col_factor(levels = c("BIM", "AO", "Non-inscrit")), 
                                            adm_pren = readr::col_factor(levels = c("0", "1", "2", "3")), 
                                            adm_cec = readr::col_factor(levels = c("0", "1", "2"))))

subj_chir_data <- read_csv("./data/subj_chir_data.csv", 
                          col_types = cols(bes_mam = readr::col_factor(levels = c("0","1", "2")), 
                                           bes_vag = readr::col_factor(levels = c("0","1", "2")), 
                                           bes_ffs = readr::col_factor(levels = c("0", "1", "2")), 
                                           bes_voix = readr::col_factor(levels = c("0", "1", "2")), 
                                           bes_torso = readr::col_factor(levels = c("0", "1", "2")), 
                                           bes_hystero = readr::col_factor(levels = c("0","1", "2")), 
                                           bes_phallo = readr::col_factor(levels = c("0", "1", "2")), 
                                           bes_meta = readr::col_factor(levels = c("0", "1", "2"))))

subj_horm_data <- read_csv("./data/subj_horm_data.csv", 
                           col_types = cols(prio_poit = readr::col_factor(levels = c("0", "1")), 
                                            prio_peau = readr::col_factor(levels = c("0","1")), 
                                            prio_pilo_F = readr::col_factor(levels = c("0", "1")), 
                                            prio_gras_F = readr::col_factor(levels = c("0", "1")), 
                                            prio_musc_F = readr::col_factor(levels = c("0", "1")), 
                                            prio_erec = readr::col_factor(levels = c("0", "1")), 
                                            prio_alo = readr::col_factor(levels = c("0", "1")), 
                                            prio_voix = readr::col_factor(levels = c("0", "1")), 
                                            prio_ameno = readr::col_factor(levels = c("0", "1")), 
                                            prio_pilo_M = readr::col_factor(levels = c("0", "1")), 
                                            prio_gras_M = readr::col_factor(levels = c("0", "1")), 
                                            prio_musc_M = readr::col_factor(levels = c("0", "1")), 
                                            prio_dickclit = readr::col_factor(levels = c("0", "1")), 
                                            inq_hum = readr::col_factor(levels = c("0", "1")), 
                                            inq_alop = readr::col_factor(levels = c("0", "1")), 
                                            inq_acne = readr::col_factor(levels = c("0", "1")), 
                                            cryo = readr::col_factor(levels = c("0", "1"))))

subj_soc_data <- read_csv("./data/subj_soc_data.csv", 
                          col_types = cols(fam_pers = readr::col_factor(levels = c("0", "1", "2", "3", "4", "5", "6")), 
                                           fam_reac = readr::col_factor(levels = c("0", "1", "2", "3")), 
                                           amis_pers = readr::col_factor(levels = c("0", "1", "2", "3")), 
                                           amis_reac = readr::col_factor(levels = c("0", "1", "2", "3"))))

obj_ant_data <- read_csv("./data/obj_ant_data.csv")

obj_chir_data <- read_csv("./data/obj_chir_data.csv", 
                          col_types = cols(real_mamm = readr::col_factor(levels = c("0", "1", "2", "3")), 
                                           real_vag = readr::col_factor(levels = c("0","1", "2", "3")), 
                                           real_ffs = readr::col_factor(levels = c("0", "1", "2", "3")), 
                                           real_voix = readr::col_factor(levels = c("0", "1", "2", "3")), 
                                           real_torso = readr::col_factor(levels = c("0", "1", "2", "3")), 
                                           real_hystero = readr::col_factor(levels = c("0", "1", "2", "3")), 
                                           real_phallo = readr::col_factor(levels = c("0", "1", "2", "3")), 
                                           real_meta = readr::col_factor(levels = c("0", "1", "2", "3"))))

obj_date_data <- read_csv("./data/obj_date_data.csv", 
                          col_types = cols(date_M0 = col_date(format = "%d/%m/%Y"), 
                                           date_M3 = col_date(format = "%d/%m/%Y"), 
                                           date_M6 = col_date(format = "%d/%m/%Y"), 
                                           date_M9 = col_date(format = "%d/%m/%Y"), 
                                           date_M12 = col_date(format = "%d/%m/%Y")))

obj_lab_data <- read_csv("./data/obj_lab_data.csv")

obj_param_data <- read_csv("./data/obj_param_data.csv")

obj_ttmt_data <- read_csv("./data/obj_ttmt_data.csv", 
                          col_types = cols(andro_type_M0 = readr::col_factor(levels = c("Sustanon")),
                                           andro_type_M3 = readr::col_factor(levels = c("Sustanon", "Nebido")), 
                                           andro_type_M6 = readr::col_factor(levels = c("Sustanon", "Nebido")), 
                                           andro_type_M9 = readr::col_factor(levels = c("Sustanon", "Nebido")), 
                                           andro_type_M12 = readr::col_factor(levels = c("Sustanon","Nebido")), 
                                           oestro_type_M0 = readr::col_factor(levels = c("Oestrogel","Dermestril", "Zumenon")), 
                                           oestro_type_M3 = readr::col_factor(levels = c("Oestrogel","Dermestril", "Zumenon")), 
                                           oestro_type_M6 = readr::col_factor(levels = c("Oestrogel", "Dermestril", "Zumenon")), 
                                           oestro_type_M9 = readr::col_factor(levels = c("Oestrogel", "Dermestril", "Zumenon")), 
                                           oestro_type_M12 = readr::col_factor(levels = c("Oestrogel", "Dermestril", "Zumenon")), 
                                           antiand_type_M0 = readr::col_factor(levels = c("Aucun", "Spironolactone", "Depo-Eligard")), 
                                           antiand_type_M3 = readr::col_factor(levels = c("Aucun", "Spironolactone", "Depo-Eligard")), 
                                           antiand_type_M6 = readr::col_factor(levels = c("Aucun", "Spironolactone", "Depo-Eligard")), 
                                           antiand_type_M12 = readr::col_factor(levels = c("Aucun", "Spironolactone", "Depo-Eligard"))))

outcome_data <- read_csv("./data/outcome_data.csv")
