source('scripts/plots/create_plot_theme.R')
source('scripts/data_manipulation/create_long_data.R', encoding = 'UTF-8')
requireNamespace('plotly')

.followup_time <-  .long_outcome_data %>%
  select(patient, transition, jours_THAG, consultation) %>%
  group_by(patient, transition) %>%
  summarise(followup = max(jours_THAG),
            max_cons = max(consultation)) %>%
  mutate(time_classe = cut(followup,
                           breaks = c(0, 95, 229, 297, 469),
                           labels = c('3 mois', '6 mois', '9 mois', '12 mois')))

.followup <- .followup_time %>%
  group_by(transition, time_classe) %>%
  summarise(N = n())
  
.followup_plot <- .followup %>%
  ggplot(aes(x = time_classe,
             y = N,
             fill = transition,
             text = paste0("Durée du suivi : ", time_classe, '\n',  "Nombre de participant·e·s : ", N, '\n', 'Genre : ', transition))) + 
  geom_col(position = position_dodge2(preserve = 'single'),
           width = 0.8) + 
  labs(title = 'Durée du suivi, par genres',
       x = 'Consultations',
       y = 'Nombre de patient·e·s',
       fill = 'Genres') + 
  .TFE_theme_Word + 
  scale_fill_manual (values = .myColors)+
  scale_y_continuous(breaks = seq(0, 5, 1))

ggsave("output/plots/followup_plot.png",
       plot = .followup_plot,
       width = 17, 
       height = 10,
       units = 'cm',
       dpi = 300,
       scale = 1.6)

.followup_plot_HTML <- .followup_plot +
  labs(title = NULL)

.anim_followup_plot <- plotly::ggplotly(.followup_plot_HTML, tooltip = 'text') %>%
  plotly::style(hoverlabel = .label) %>%
  plotly::layout(font = .font,
         yaxis = list(fixedrange = TRUE),
         xaxis= list(fixedrange = TRUE),
         title= list(layout.title.pad = 20),
         legend = list(orientation = 'h', y = 110)) %>%
  plotly::config(displayModeBar = FALSE)

