source('scripts/data_manipulation/manipulate_soc_data.R', encoding = 'UTF-8')
source('scripts/plots/create_plot_theme.R')
requireNamespace('plotly')

.fam_plot <- ggplot(data = .count_fam_pers, aes(x = reorder(fam_pers, -n), 
                                                y = n,
                                                fill = transition,
                                                text = paste0("Nombre de participant·e·s : ", n, '\n', 'Genre : ', transition))) +
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
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title = NULL)

.anim_fam_plot <- plotly::ggplotly(.fam_plot_HTML, tooltip = 'text') %>%
  plotly::style(hoverlabel = .label) %>%
  plotly::layout(font = .font,
         yaxis = list(fixedrange = TRUE),
         xaxis= list(fixedrange = TRUE),
         title= list(layout.title.pad = 20),
         legend = list(orientation = 'h', y = 110)) %>%
  plotly::config(displayModeBar = FALSE)
  


