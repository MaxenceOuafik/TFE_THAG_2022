requireNamespace('gtsummary')
requireNamespace('flextable')

.outcome_F_ft <- .long_outcome_data %>%
  filter (transition == 'Personnes transféminines') %>%
  mutate(antiandrogène = replace_na(antiandrogène, 'Avant traitement')) %>%
  left_join(select(.long_lab_data, patient, consultation, GR:kal), by = c('patient', 'consultation')) %>%
  left_join(select(.long_param, patient, consultation, systol, diastol), by = c('patient', 'consultation')) %>%
  select(consultation, systol, diastol, FSH:Pr, antiandrogène, Hb, creat, kal, TGO, TGP, LDL, HDL,tg) %>%
  gtsummary::tbl_strata2(strata = consultation,
                      .tbl_fun = ~ .x %>% gtsummary::tbl_summary(by = antiandrogène,
                                                                 type = list(FSH ~ 'continuous',
                                                                             LH ~ 'continuous',
                                                                             O2 ~ 'continuous',
                                                                             T ~ 'continuous',
                                                                             Pr ~ 'continuous',
                                                                             systol ~ 'continuous',
                                                                             diastol ~ 'continuous',
                                                                             Hb ~ 'continuous',
                                                                             creat ~ 'continuous',
                                                                             TGO ~ 'continuous',
                                                                             TGP ~ 'continuous',
                                                                             LDL ~ 'continuous',
                                                                             HDL ~ 'continuous',
                                                                             tg ~ 'continuous',
                                                                             kal ~ 'continuous'),
                                                                 missing = 'no',
                                                                 statistic = c(FSH, LH, O2, T, Pr, 
                                                                               systol, diastol, 
                                                                               Hb, creat, TGO, TGP, LDL, HDL, tg, kal) ~ "{median}",
                                                                 digits = list(LDL ~ 1,
                                                                               creat ~ 2,
                                                                               T ~ 1,
                                                                               diastol ~ 0,
                                                                               systol ~ 0,
                                                                               Hb ~ 1,
                                                                               tg ~1,
                                                                               TGO ~1),
                                                                 label = list(systol ~ 'Systolique (mmHg)',
                                                                               FSH ~ 'FSH (U/L)',
                                                                               LH ~ 'LH (U/L)',
                                                                               O2 ~ 'Estradiol (ng/L)',
                                                                               T ~ 'Testostérone totale (nmol/L)',
                                                                               TGP ~ 'TGP (U/L)',
                                                                               TGO ~ 'TGO (U/L)',
                                                                               LDL ~ 'LDL-cholestérol (mg/dL)',
                                                                               HDL ~ 'HDL-cholestérol (mg/dL)',
                                                                               tg ~ 'Triglycérides (mg/dL)',
                                                                               kal ~ 'Potassium (mmol/L)',
                                                                               diastol ~ 'Diastolique (mmHg)',
                                                                               Pr ~ 'Prolactine (mUI/L)',
                                                                               Hb ~ 'Hémoglobine (g/dL)',
                                                                               creat ~ 'Créatinine (mg/dL)'))) %>%
  gtsummary::modify_header(label = '**Paramètres**') %>%
  gtsummary::bold_labels() %>%
  gtsummary::as_flex_table()

.outer.border <- officer::fp_border(color = "#60a3bc", style = "solid", width = 2.5)
.header.border <- officer::fp_border(color = "#3c6382", style = "solid", width = 2.5)
.inner.border_v <- officer::fp_border(color = "#3c6382", style = "dashed", width = .5)
.inner.border_h <- officer::fp_border(color = "#3c6382", style = "solid", width = .5)


.outcome_F_ft <- flextable::width(.outcome_F_ft, width = 4)
.outcome_F_ft <- flextable::bg(.outcome_F_ft, bg = '#60a3bc', part = 'header')
.outcome_F_ft <- .outcome_F_ft %>%
  flextable::bold(part = "header") %>%
  flextable::color(color = "white", part = "header") %>%
  flextable::border_outer(border = .outer.border, part = "body") %>%
  flextable::border_outer(border = .outer.border, part = "header") %>%
  flextable::border_inner_h(border = .header.border, part = "header") %>%
  flextable::vline(j = c(2,4,7, 9), border = .inner.border_v, part = "body") %>%
  flextable::hline(i = c(2,7,8,10,12), border = .inner.border_h, part = "body") %>%
  flextable::font(fontname = 'Lato Light', part = 'body') %>%
  flextable::font(fontname = 'Lato Bold', part = 'header')

.outcome_F_ft <- flextable::set_caption(.outcome_F_ft,
                                    "Évolution des paramètres des patient·e·s transféminin·e·s, par consultation et par traitement",
                                    style = 'Légende1')

.outcome_F_ft_word <- .outcome_F_ft %>%
  flextable::fontsize(j=1:11, size=10, part ='body') %>%
  flextable::fontsize(i = 1, j=1:11, size = 10, part = 'header')%>%
  flextable::fontsize(i = 1, j=1, size = 10, part = 'footer')

.outcome_F_ft_word <- flextable::width(.outcome_F_ft_word, j= 1, width = 5, unit = "cm")
.outcome_F_ft_word <- flextable::width(.outcome_F_ft_word, j= 2:11, width = 2.5, unit = "cm")