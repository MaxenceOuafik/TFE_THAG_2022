library(dplyr)
library(gtsummary)
library(flextable)
library(officer)

.demog_data_table <- obj_demog_data
levels(.demog_data_table$sexe) <- c("Femelle", "Mâle", "Intersexe")
levels(.demog_data_table$genre) <- c('Femme', 'Homme', 'Non-binaire')
levels(.demog_data_table$province) <- c("Liège", "Hainaut", "Luxembourg", "Namur", "Brabant Wallon", "Brabant Flamand")
levels(.demog_data_table$mutuelle) <- c('BIM', 'Assuré·e ordinaire', 'Non-inscrit·e')
levels(.demog_data_table$adm_pren) <- c('Non effectué', 'Effectué après le THAG', 'Effectué avant le THAG', "Uniquement à l'université") 
levels(.demog_data_table$adm_cec) <- c('Non effectué', 'Effectué après le THAG', 'Effectué avant le THAG') 

.demog_ft <- 
.demog_data_table %>%
  select(-patient, -natio, -sexe) %>%
  rename(c('Âge' = age,
           'Province' = province,
           'Genres' = genre,
           'Statut mutuelle' = mutuelle,
           'Changement de prénom' = adm_pren,
           "Changement de genre à l'état-civil" = adm_cec)) %>%
  tbl_summary(type = all_continuous() ~ 'continuous2',
              statistic = all_continuous() ~ c('{mean} ({sd})', '{min} - {max}')) %>%
  modify_header(label = '**Caractéristiques**') %>%
  bold_labels() %>%
  as_flex_table()

.outer.border <- fp_border(color = "#60a3bc", style = "solid", width = 2.5)

.demog_ft <- width(.demog_ft, width = 3)
.demog_ft <- bg(.demog_ft, bg = '#60a3bc', part = 'header')

.demog_ft <- .demog_ft %>%
  compose(i = 2, j = 1, as_paragraph((as_chunk('Moyenne (SD)')))) %>%
  compose(i = 3, j = 1, as_paragraph((as_chunk('Étendue')))) %>%
  bold(part = "header") %>%
  color(color = "white", part = "header") %>%
  border_outer(border = .outer.border, part = "header") %>%
  align(j = 2, align = 'right', part = 'header') %>%
  align(j = 2, align = 'right', part = 'body') %>%
  font(fontname = 'Lato Light')

.demog_ft <- set_caption(.demog_ft,
                       "Caractéristiques démographiques des participant·e·s",
                       style = 'Légende1')

.demog_ft_word <- .demog_ft %>%
  fontsize(j=1:2, size=9, part ='body') %>%
  fontsize(i = 1, j=1:2, size = 9, part = 'header')%>%
  fontsize(i = 1, j=1, size = 9, part = 'footer')
