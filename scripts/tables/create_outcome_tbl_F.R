requireNamespace('gtsummary')
requireNamespace('flextable')

.outcome_F_tbl_data <- .long_outcome_data %>%
  filter (transition == 'Personnes transféminines') %>%
  mutate(antiandrogène = replace_na(antiandrogène, 'Avant traitement')) %>%
  left_join(select(.long_lab_data, patient, consultation, GR:kal), by = c('patient', 'consultation')) %>%
  left_join(select(.long_param, patient, consultation, systol, diastol), by = c('patient', 'consultation')) %>%
  select(consultation, systol, diastol, FSH:Pr, antiandrogène, Hb, creat, kal, TGO, TGP, LDL, HDL,tg)
  
.outcome_F_tbl <- gtsummary::tbl_strata2(.outcome_F_tbl_data, strata = consultation,
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
  gtsummary::modify_header(label = '**Paramètres**') 

.outcome_F_ft <- .outcome_F_tbl %>%
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
  flextable::fontsize(j=1:11, size=9, part ='body') %>%
  flextable::fontsize(i = 1, j=1:11, size = 13, part = 'header')%>%
  flextable::fontsize(i = 2, j=2:11, size = 8, part = 'header') %>%
  flextable::fontsize(i = 1, j=1, size = 10, part = 'footer')

.outcome_F_ft_word <- flextable::width(.outcome_F_ft_word, j= 1, width = 4, unit = "cm")
.outcome_F_ft_word <- flextable::width(.outcome_F_ft_word, j= 2:11, width = 2.5, unit = "cm")


.outcome_F_tbl_HTML <- .outcome_F_tbl %>%
  gtsummary::as_tibble() %>%
  `colnames<-`(c('param',
                 'T0_ttmt',
                 'T1_no',
                 'T1_spiro',
                 'T2_no',
                 'T2_depo',
                 'T2_spiro',
                 'T3_no',
                 'T3_depo',
                 'T4_no',
                 'T4_depo')) %>%
  column_to_rownames(var="param") %>%
  reactable::reactable(
    columnGroups = list(
    reactable::colGroup(name = 'T0', columns = c('T0_ttmt')),
    reactable::colGroup(name = 'T1', columns = c('T1_no', 'T1_spiro')),
    reactable::colGroup(name = 'T2', columns = c('T2_no', 'T2_depo', 'T2_spiro')),
    reactable::colGroup(name = 'T3', columns = c('T3_no', 'T3_depo')),
    reactable::colGroup(name = 'T4', columns = c('T4_no', 'T4_depo'))
    ),
    columns = list(
      .rownames = reactable::colDef(style = list(borderRight = "1px solid #eee", 
                                                 backgroundColor = "#f7f7f7",
                                                 position = "sticky", left = 0)),
      T0_ttmt = reactable::colDef(name = 'Avant traitement (N = 13)'),
      T1_no = reactable::colDef(name = 'Aucun (N = 9)'),
      T1_spiro = reactable::colDef(name = 'Spironolactone (N = 3)'),
      T2_no = reactable::colDef(name = 'Aucun (N = 4)'),
      T2_depo = reactable::colDef(name = 'Depo-Eligard (N = 2)'),
      T2_spiro = reactable::colDef(name = 'Spironolactone (N = 3)'),
      T3_no = reactable::colDef(name = 'Aucun (N = 2)'),
      T3_depo = reactable::colDef(name = 'Depo-Eligard (N = 3)'),
      T4_no = reactable::colDef(name = 'Aucun (N = 1)'),
      T4_depo = reactable::colDef(name = 'Depo-Eligard (N = 1)')
      
      ),
    pagination = FALSE, 
    highlight = TRUE,
    sortable = F,
    class = "my-tbl",
    defaultColDef = reactable::colDef(headerClass = "my-header"))
