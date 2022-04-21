source('scripts/data_manipulation/manipulate_soc_data.R', encoding = 'UTF-8')
source('scripts/plots/create_plot_theme.R')

requireNamespace('plotly')

.amis_plot <- ggplot(data = .count_amis_pers, aes(x = reorder(amis_pers, -n), 
                                                  y = n,
                                                  fill = transition,
                                                  text = paste0("Nombre de participant·e·s : ", n, '\n', 'Genre : ', transition))) +
  geom_col(position = position_dodge2(preserve = 'single'),
           width = 0.8) +
  labs(title = "Ami·e·s auxquel·le·s les participant·e·s ont annoncé leur transidentité",
       y = "Nombre de participant·e·s",
       x = "Ami·e·s",
       fill = "Genres") +
  .TFE_theme_Word + 
  scale_fill_manual (values = .myColors) +
  scale_y_continuous(breaks = c(0:7))


ggsave("output/plots/amis_plot.png",
       plot = .amis_plot,
       width = 17, 
       height = 10,
       units = 'cm',
       dpi = 300,
       scale = 1.6)

.amis_plot_HTML <- .amis_plot +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title = NULL)

.anim_amis_plot <- plotly::ggplotly(.amis_plot_HTML, tooltip = 'text') %>%
  plotly::style(hoverlabel = .label) %>%
  plotly::layout(font = .font,
         yaxis = list(fixedrange = TRUE),
         xaxis= list(fixedrange = TRUE),
         title= list(layout.title.pad = 20),
         legend = list(orientation = 'h', y = 110)) %>%
  plotly::config(displayModeBar = FALSE)