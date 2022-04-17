source('scripts/create_plot_theme.R')
requireNamespace('plotly')

.followup_time <-  .time_diff %>% 
  left_join(obj_demog_data, by = 'patient') %>%
  mutate(transition = as.factor(ifelse(sexe == 'M'|sexe == 'I',
                                       'Personnes transféminines',
                                       'Personnes transmasculines'))) %>%
  select(patient, transition, jours_THAG, consultation) %>%
  group_by(patient, transition) %>%
  summarise(followup = max(jours_THAG),
            max_cons = max(consultation)) 

.followup_plot <- .followup_time %>% 
  group_by(transition) %>%
  count(max_cons) %>%
  mutate(N_at_cons = max(cumsum(n)) - cumsum(lag(n, default = 0))) %>%
  ggplot(aes(x = max_cons,
             y = N_at_cons,
             fill = transition,
             text = paste0("Trimestre : ", max_cons, '\n',  "Nombre de participant·e·s : ", N_at_cons, '\n', 'Genre : ', transition))) + 
  geom_col(position = position_dodge2(preserve = 'single'),
           width = 0.8) + 
  labs(title = 'Nombre de patient·e·s par consultation trimestrielle et par genre',
       x = 'Consultations',
       y = 'Nombre de patient·e·s',
       fill = 'Genres') + 
  .TFE_theme_Word + 
  scale_fill_manual (values = .myColors)+
  scale_y_continuous(breaks = seq(0, 15, 2))

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

