requireNamespace('gtsummary')
requireNamespace('flextable')

.outcome_M_tbl <- .long_outcome_data %>%
  filter (transition == 'Personnes transmasculines') %>%
  mutate(androgène = replace_na(androgène, 'Avant traitement')) %>%
  left_join(select(.long_lab_data, patient, consultation, GR:tg), by = c('patient', 'consultation')) %>%
  left_join(select(.long_param, patient, consultation, systol, diastol), by = c('patient', 'consultation')) %>%
  select(consultation, systol, diastol, FSH:T, Hb, Hct, creat, TGO, TGP, LDL, HDL,tg) %>%
  gtsummary::tbl_summary(by = consultation, type = list(FSH ~ 'continuous',
                                                         LH ~ 'continuous',
                                                         O2 ~ 'continuous',
                                                         T ~ 'continuous',
                                                         systol ~ 'continuous',
                                                         diastol ~ 'continuous',
                                                         Hb ~ 'continuous',
                                                         Hct ~ 'continuous',
                                                         creat ~ 'continuous',
                                                         TGO ~ 'continuous',
                                                         TGP ~ 'continuous',
                                                         LDL ~ 'continuous',
                                                         HDL ~ 'continuous',
                                                         tg ~ 'continuous'),
                                                                    missing = 'no',
                                                                    statistic = c(FSH, LH, O2, T, 
                                                                                  systol, diastol, 
                                                                                  Hb, Hct, creat, TGO, TGP, LDL, HDL, tg) ~ "{median}",
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
                                                                                 diastol ~ 'Diastolique (mmHg)',
                                                                                 Hb ~ 'Hémoglobine (g/dL)',
                                                                                 Hct ~ 'Hématocrite (%)',
                                                                                 creat ~ 'Créatinine (mg/dL)')) %>%
  gtsummary::modify_header(label = '**Paramètres**') 

.outcome_M_ft <- .outcome_M_tbl %>%
  gtsummary::bold_labels() %>%
  gtsummary::as_flex_table()

.outer.border <- officer::fp_border(color = "#60a3bc", style = "solid", width = 2.5)
.header.border <- officer::fp_border(color = "#3c6382", style = "solid", width = 2.5)
.inner.border_v <- officer::fp_border(color = "#3c6382", style = "dashed", width = .5)
.inner.border_h <- officer::fp_border(color = "#3c6382", style = "solid", width = .5)


.outcome_M_ft <- flextable::width(.outcome_M_ft, width = 4)
.outcome_M_ft <- flextable::bg(.outcome_M_ft, bg = '#60a3bc', part = 'header')
.outcome_M_ft <- .outcome_M_ft %>%
  flextable::bold(part = "header") %>%
  flextable::color(color = "white", part = "header") %>%
  flextable::border_outer(border = .outer.border, part = "body") %>%
  flextable::border_outer(border = .outer.border, part = "header") %>%
  flextable::border_inner_h(border = .header.border, part = "header") %>%
  flextable::hline(i = c(2,6,8,10,12), border = .inner.border_h, part = "body") %>%
  flextable::font(fontname = 'Lato Light', part = 'body') %>%
  flextable::font(fontname = 'Lato Bold', part = 'header')

.outcome_M_ft <- flextable::set_caption(.outcome_M_ft,
                                        "Évolution des paramètres des patient·e·s transmasculin·e·s, par consultation",
                                        style = 'Légende1')

.outcome_M_ft_word <- .outcome_M_ft %>%
  flextable::fontsize(j=1:6, size=10, part ='body') %>%
  flextable::fontsize(i = 1, j=1:6, size = 10, part = 'header')%>%
  flextable::fontsize(i = 1, j=1, size = 10, part = 'footer')

.outcome_M_ft_word <- flextable::width(.outcome_M_ft_word, j= 1, width = 4.4, unit = "cm")
.outcome_M_ft_word <- flextable::width(.outcome_M_ft_word, j= 2:6, width = 2.1, unit = "cm")

.outcome_M_tbl_HTML <- .outcome_M_tbl %>%
  gtsummary::as_tibble() %>%
  column_to_rownames(var="**Paramètres**") %>%
  `colnames<-`(c('T0, N=13',
                 'T1, N=12',
                 'T2, N=9',
                 'T3, N=3',
                 'T4, N=3')) %>%
  reactable::reactable(columns = list(
    .rownames = reactable::colDef(style = list(borderRight = "1px solid #eee", 
                                               backgroundColor = "#f7f7f7",
                                               position = "sticky", left = 0))),
    pagination = FALSE, 
    highlight = TRUE, 
    sortable = F,
    class = "my-tbl",
    defaultColDef = reactable::colDef(headerClass = "my-header"))
