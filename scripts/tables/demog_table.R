library(tidyverse)
requireNamespace('gtsummary')
requireNamespace('flextable')
requireNamespace('officer')

.demog_data_table <- obj_demog_data %>%
  mutate(pren = ifelse(obj_demog_data$adm_pren == 0, 0, 1)) %>%
  mutate(cec = ifelse(obj_demog_data$adm_cec == 0, 0, 1)) %>%
  mutate(prov = as.factor(ifelse(obj_demog_data$province == 'Liege', 1, 2)))

levels(.demog_data_table$sexe) <- c("Femelle", "Mâle", "Intersexe")
levels(.demog_data_table$genre) <- c('Femme', 'Homme', 'Non-binaire')
levels(.demog_data_table$prov) <- c("Liège", "Autre")
levels(.demog_data_table$mutuelle) <- c('BIM', 'Assuré·e ordinaire', 'Non-inscrit·e')

.demog_ft <- 
  .demog_data_table  %>%
  select(age, prov, genre, sexe, mutuelle, pren, cec) %>%
  relocate(prov, .after = age) %>%
  rename(c('Âge' = age,
           'Province' = prov,
           'Genres' = genre,
           'Sexes' = sexe,
           'Statut mutuelle' = mutuelle,
           'Changement de prénom' = pren,
           "Changement de genre à l'état-civil" = cec)) %>%
  gtsummary::tbl_summary(by = Genres, type = 'Âge' ~ 'continuous2',
                         statistic = 'Âge' ~ c('{median}', '[{min} - {max}]')) %>%
  gtsummary::modify_header(label = '**Caractéristiques**') %>%
  gtsummary::bold_labels() %>%
  gtsummary::add_overall() %>%
  gtsummary::as_flex_table()



.outer.border <- officer::fp_border(color = "#60a3bc", style = "solid", width = 2.5)

.demog_ft <- flextable::width(.demog_ft, width = 4)
.demog_ft <- flextable::bg(.demog_ft, bg = '#60a3bc', part = 'header')

.demog_ft <- .demog_ft %>%
  flextable::compose(i = 2, j = 1, flextable::as_paragraph((flextable::as_chunk('Médiane')))) %>%
  flextable::compose(i = 3, j = 1, flextable::as_paragraph((flextable::as_chunk('Minimum - Maximum')))) %>%
  flextable::set_header_labels(stat_0 = "Total, N = 26") %>%
  flextable::bold(part = "header") %>%
  flextable::bold(j = 2, part = 'body') %>%
  flextable::color(color = "white", part = "header") %>%
  flextable::border_outer(border = .outer.border, part = "body") %>%
  flextable::border_outer(border = .outer.border, part = "header") %>%
  flextable::font(fontname = 'Lato Light', part = 'body') %>%
  flextable::font(fontname = 'Lato Bold', part = 'header')

.demog_ft <- flextable::set_caption(.demog_ft,
                         "Caractéristiques démographiques des participant·e·s",
                         style = 'Légende1')

.demog_ft_word <- .demog_ft %>%
  flextable::fontsize(j=1:5, size=10, part ='body') %>%
  flextable::fontsize(i = 1, j=1:5, size = 10, part = 'header')%>%
  flextable::fontsize(i = 1, j=1, size = 10, part = 'footer')

.demog_ft_word <- flextable::width(.demog_ft_word, j= 1, width = 5, unit = "cm")
.demog_ft_word <- flextable::width(.demog_ft_word, j= 2, width = 3, unit = "cm")
.demog_ft_word <- flextable::width(.demog_ft_word, j= 3, width = 3, unit = "cm")
.demog_ft_word <- flextable::width(.demog_ft_word, j= 4, width = 3, unit = "cm")
.demog_ft_word <- flextable::width(.demog_ft_word, j= 5, width = 3.5, unit = "cm")



