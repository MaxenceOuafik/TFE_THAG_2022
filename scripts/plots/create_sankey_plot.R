requireNamespace('plotly')
requireNamespace('ggsankey')

.sankey_data <- obj_ttmt_data %>%
  select(1, seq(22,28,2)) %>%
  filter(!is.na(antiand_type_T0)) %>%
  select(-patient)

.sankey_plot_data <- ggsankey::make_long(.sankey_data, antiand_type_T0,
                           antiand_type_T1,
                           antiand_type_T2,
                           antiand_type_T3)

.sankey_plot_data_N <- .sankey_plot_data %>%
  filter(!is.na(node)) %>% 
  group_by(x, node)%>% 
  summarise(count = n())

.sankey_plot_data <- .sankey_plot_data %>%
  left_join(select(.sankey_plot_data_N, x, node, count), by = c('x', 'node')) %>%
  filter(!is.na(node))

.sankey_plot <- ggplot(.sankey_plot_data, 
       aes(x = x,
           next_x = next_x,
           node = node, 
           next_node = next_node,
           fill = factor(node)
       ),
       na.rm = T) +
  ggsankey::geom_sankey(flow.alpha = 0.5, 
              
              na.rm = T) +
  ggsankey::geom_sankey_text(aes(label = count),
                   na.rm = T) +
  ggsankey::theme_sankey(base_size = 16) +
  labs(x = NULL,
       fill = 'Antiandrogène',
       title = "Évolution du choix d'antiandrogène au fil des consultations") +
  scale_x_discrete(labels = c('T1','T2','T3', 'T4')) +
  scale_y_continuous(breaks = NULL) +
  .TFE_theme_Word + 
  scale_fill_manual (values = .myColors) +
  theme(panel.background = element_blank(),
        panel.grid.major = element_blank())

ggsave("output/plots/sankey_plot.png",
       plot = .sankey_plot,
       width = 17, 
       height = 10,
       units = 'cm',
       dpi = 300,
       scale = 1.4)

.sankey_plot_HTML <- .sankey_plot +
  labs(title = NULL) +
  theme(axis.text.y=element_blank())

.anim_sankey_plot <- plotly::ggplotly(.sankey_plot_HTML, tooltip = 'text') %>%
  plotly::style(hoverlabel = .label) %>%
  plotly::layout(font = .font,
                 yaxis = list(fixedrange = TRUE),
                 xaxis= list(fixedrange = TRUE),
                 title= list(layout.title.pad = 20),
                 legend = list(orientation = 'h', y = 110)) %>%
  plotly::config(displayModeBar = FALSE)


  

