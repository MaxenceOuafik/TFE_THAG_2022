.creat_T0 <- .long_lab_data %>%
  filter(transition == 'Personnes transmasculines',
         consultation == 'T0') %>%
  select(creat) %>%
  pull()

.creat_T1 <- .long_lab_data %>%
  filter(transition == 'Personnes transmasculines',
         consultation == 'T1') %>%
  select(creat) %>%
  pull()

.creat_Wil <- wilcox.test(.creat_T0, .creat_T1, 
            paired = T,
            exact = FALSE)

.Hb_T0 <- .long_lab_data %>%
  filter(transition == 'Personnes transmasculines',
         consultation == 'T0') %>%
  select(Hb) %>%
  pull()

.Hb_T1 <- .long_lab_data %>%
  filter(transition == 'Personnes transmasculines',
         consultation == 'T1') %>%
  select(Hb) %>%
  pull()

.Hb_Wil <- wilcox.test(.Hb_T0, .Hb_T1, 
            paired = T,
            exact = FALSE)

.Hct_T0 <- .long_lab_data %>%
  filter(transition == 'Personnes transmasculines',
         consultation == 'T0') %>%
  select(Hct) %>%
  pull()

.Hct_T1 <- .long_lab_data %>%
  filter(transition == 'Personnes transmasculines',
         consultation == 'T1') %>%
  select(Hct) %>%
  pull()

.Hct_Wil <- wilcox.test(.Hct_T0, .Hct_T1, 
                       paired = T,
                       exact = FALSE)

.LDL_T0 <- .long_lab_data %>%
  filter(transition == 'Personnes transmasculines',
         consultation == 'T0') %>%
  select(LDL) %>%
  pull()

.LDL_T1 <- .long_lab_data %>%
  filter(transition == 'Personnes transmasculines',
         consultation == 'T1') %>%
  select(LDL) %>%
  pull()

.LDL_Wil <- wilcox.test(.LDL_T0, .LDL_T1, 
                       paired = T,
                       exact = FALSE)

.HDL_T0 <- .long_lab_data %>%
  filter(transition == 'Personnes transmasculines',
         consultation == 'T0') %>%
  select(HDL) %>%
  pull()

.HDL_T1 <- .long_lab_data %>%
  filter(transition == 'Personnes transmasculines',
         consultation == 'T1') %>%
  select(HDL) %>%
  pull()

.HDL_Wil <- wilcox.test(.HDL_T0, .HDL_T1, 
                       paired = T,
                       exact = FALSE)

.TGO_T0 <- .long_lab_data %>%
  filter(transition == 'Personnes transmasculines',
         consultation == 'T0') %>%
  select(TGO) %>%
  pull()

.TGO_T1 <- .long_lab_data %>%
  filter(transition == 'Personnes transmasculines',
         consultation == 'T1') %>%
  select(TGO) %>%
  pull()

.TGO_Wil <- wilcox.test(.TGO_T0, .TGO_T1, 
                       paired = T,
                       exact = FALSE)

.TGP_T0 <- .long_lab_data %>%
  filter(transition == 'Personnes transmasculines',
         consultation == 'T0') %>%
  select(TGP) %>%
  pull()

.TGP_T1 <- .long_lab_data %>%
  filter(transition == 'Personnes transmasculines',
         consultation == 'T1') %>%
  select(TGP) %>%
  pull()

.TGP_Wil <- wilcox.test(.TGP_T0, .TGP_T1, 
                       paired = T,
                       exact = FALSE)

.tg_T0 <- .long_lab_data %>%
  filter(transition == 'Personnes transmasculines',
         consultation == 'T0') %>%
  select(tg) %>%
  pull()

.tg_T1 <- .long_lab_data %>%
  filter(transition == 'Personnes transmasculines',
         consultation == 'T1') %>%
  select(tg) %>%
  pull()

.tg_Wil <- wilcox.test(.tg_T0, .tg_T1, 
                       paired = T,
                       exact = FALSE)