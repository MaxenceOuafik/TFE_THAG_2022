library(dplyr)
library(plotly)
source('scripts/create_plot_theme.R')

.count_fam_pers <- subj_soc_data %>%
  left_join(obj_demog_data, by = 'patient') %>%
  filter(!is.na(fam_pers)) %>%
  select(patient, fam_pers, sexe, genre) %>%
  mutate(transition = as.factor(ifelse(sexe == 'M'|sexe == 'I',
                       'Personne transféminine',
                       'Personne transmasculine'))) %>%
  group_by(transition) %>%
  count(fam_pers)
 

levels(.count_fam_pers$fam_pers) <- c("Personne", 
                                "Mère seulement",
                                "Père seulement",
                                "Les deux parents",
                                "Parents + famille",
                                "Quelques membres mais pas les parents",
                                "Toute la famille") 

.count_fam_reac <- subj_soc_data %>%
  left_join(obj_demog_data, by = 'patient') %>%
  filter(!is.na(fam_reac)) %>%
  select(patient, fam_reac, genre, sexe) %>%
  mutate(transition = as.factor(ifelse(sexe == 'M'|sexe == 'I',
                                       'Personne transféminine',
                                       'Personne transmasculine'))) %>%
  group_by(transition) %>%
  count(fam_reac)

levels(.count_fam_reac$fam_reac) <- c("Réaction négative",
                               "Quelques difficultés",
                               "Réaction neutre",
                               "Réaction positive")

.fam_plot <- ggplot(data = .count_fam_pers, aes(x = reorder(fam_pers, -n), 
                                                y = n,
                                                fill = transition,
                                                text = paste0("Nombre de participant·e·s : ", n))) +
  geom_col(position = position_dodge2(preserve = 'single'),
           width = 0.8) +
  labs(title = "Personnes de la famille auxquelles les participant·e·s ont annoncé leur transidentité",
       y = "Nombre de participant·e·s",
       x = "Personnes de la famille",
       fill = "Genres") +
  .TFE_theme_Word + 
  scale_fill_manual (values = .myColors) +
  scale_y_continuous(breaks = c(0:6))


ggsave("output/plots/fam_plot.png",
       plot = .fam_plot,
       width = 17, 
       height = 10,
       units = 'cm',
       dpi = 300,
       scale = 1.6)

.fam_plot_HTML <- .fam_plot +
  .TFE_theme_HTML

.anim_fam_plot <- ggplotly(.fam_plot_HTML, tooltip = "text") %>%
  plotly::style(hoverlabel = .label) %>%
  layout(font = .font,
         yaxis = list(fixedrange = TRUE),
         xaxis= list(fixedrange = TRUE),
         title= list(layout.title.pad = 20)) %>%
  config(displayModeBar = FALSE)
  


