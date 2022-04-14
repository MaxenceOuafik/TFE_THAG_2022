library(dplyr)
library(gtsummary)
library(flextable)
library(officer)

.demog_data_table <- obj_demog_data %>%
  dplyr::mutate(pren = ifelse(obj_demog_data$adm_pren == 0, 0, 1)) %>%
  dplyr::mutate(cec = ifelse(obj_demog_data$adm_cec == 0, 0, 1)) %>%
  dplyr::mutate(prov = as.factor(ifelse(obj_demog_data$province == 'Liege', 1, 2)))

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
  tbl_summary(by = Genres, type = all_continuous() ~ 'continuous2',
              statistic = all_continuous() ~ c('{median}', '[{min} - {max}]')) %>%
  modify_header(label = '**Caractéristiques**') %>%
  bold_labels() %>%
  add_overall() %>%
  as_flex_table()



.outer.border <- fp_border(color = "#60a3bc", style = "solid", width = 2.5)

.demog_ft <- width(.demog_ft, width = 4)
.demog_ft <- bg(.demog_ft, bg = '#60a3bc', part = 'header')

.demog_ft <- .demog_ft %>%
  compose(i = 2, j = 1, as_paragraph((as_chunk('Médiane')))) %>%
  compose(i = 3, j = 1, as_paragraph((as_chunk('Minimum - Maximum')))) %>%
  set_header_labels(stat_0 = "Total, N = 25") %>%
  bold(part = "header") %>%
  bold(j = 2, part = 'body') %>%
  color(color = "white", part = "header") %>%
  border_outer(border = .outer.border, part = "header") %>%
  font(fontname = 'Lato Light', part = 'body') %>%
  font(fontname = 'Lato Bold', part = 'header')

.demog_ft <- set_caption(.demog_ft,
                         "Caractéristiques démographiques des participant·e·s",
                         style = 'Légende1')

.demog_ft_word <- .demog_ft %>%
  fontsize(j=1:5, size=10, part ='body') %>%
  fontsize(i = 1, j=1:5, size = 10, part = 'header')%>%
  fontsize(i = 1, j=1, size = 10, part = 'footer')

.demog_ft_word <- width(.demog_ft_word, j= 1, width = 5, unit = "cm")
.demog_ft_word <- width(.demog_ft_word, j= 2, width = 3, unit = "cm")
.demog_ft_word <- width(.demog_ft_word, j= 3, width = 3, unit = "cm")
.demog_ft_word <- width(.demog_ft_word, j= 4, width = 3, unit = "cm")
.demog_ft_word <- width(.demog_ft_word, j= 5, width = 3.5, unit = "cm")



