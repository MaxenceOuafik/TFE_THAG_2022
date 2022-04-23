source('scripts/plots/create_plot_theme.R')

.outcome_analysis_data_F <- .long_outcome_data  %>%
  filter(transition == 'Personnes transféminines',
         !(patient == 'EEG' & consultation == 'T2'),
           !is.na(antiandrogène)) %>%
  mutate(T_2.29 = ifelse(T < 2.29, '#82ccdd', '#f8c291'),
         O2_classe = cut(O2, breaks = c(30, 100, 200, 400),
                         labels = c("< 100", "100-200", '>200')),
         LH_classe = cut(LH, breaks = c(0, 1, 4, 7),
                         labels = c("< 1", "1-4", '>4')))

.T_time_F <- .outcome_analysis_data_F %>%
  ggplot(aes(x = consultation, y = T)) + 
  stat_summary(geom = 'col', fun = median, aes(fill = antiandrogène, group = consultation), alpha = 0.5)+
  geom_point(aes(color = T_2.29,
                 text = paste0("Testostéronémie : ", T, ' nmol/L \n', 'Consultation : ', consultation)), size = 2) +
  geom_smooth(method = "glm", formula = y~x,
              method.args = list(family = gaussian(link = 'log')),
               se = F,
               aes(group = 1),
              col = '#38ada9') +
  geom_hline(yintercept=2.29, linetype = 'dashed', col = '#82ccdd', alpha = 0.5, size = 1) + 
  facet_grid(. ~ antiandrogène) +
  labs(
       x = 'Consultations',
       y = 'Testostérone sérique (nmol/L)',
       color = 'Testostérone (nmol/L)') +
  scale_color_identity(guide = "legend",
                       breaks = c('#82ccdd', '#f8c291'),
                       labels = c('< 2.29', '> 2.29')) +
  scale_y_continuous(minor_breaks = seq(0, 25, 1)) +
  scale_fill_manual (values = .myColors) +
  theme(axis.title = element_text(family = 'Lato Light',
                                  size = 10,
                                  color = '#60a3bc'),
        plot.background = element_rect(fill = 'white'),
        text = element_text(family = 'Lato'),
        legend.position = 'bottom',
        legend.background = element_rect(fill = 'grey95'),
        panel.grid.minor = element_line( size=0.25)) +
  guides(fill = 'none')

.T_O2_F <- .outcome_analysis_data_F  %>%
         filter(!is.na(O2_classe)) %>%
  ggplot(aes(x = O2_classe, y = T)) + 
  stat_summary(geom = 'col', fun = median, aes(fill = antiandrogène, group = O2_classe), alpha = 0.5)+
  geom_point(aes(color = T_2.29,
                 text = paste0("Testostéronémie : ", T, ' nmol/L \n', 'Oestradiolémie : ', O2, ' ng/L')), size = 2) +
  geom_smooth(method = "glm", formula = y~x,
              method.args = list(family = gaussian(link = 'log')),
              se = F,
              aes(group = 1),
              col = '#38ada9') +
  geom_hline(yintercept=2.29, linetype = 'dashed', col = '#82ccdd', alpha = 0.5, size = 1) + 
  geom_vline(xintercept=c(100,200), col = '#82ccdd', alpha = 0.5, size = 1) + 
  facet_grid(. ~ antiandrogène) +
  labs(
       x = 'Estradiol sérique (ng/L)',
       y = 'Testostérone sérique (nmol/L)',
       color = 'Testostérone (nmol/L)') +
  scale_color_identity(guide = "legend",
                       breaks = c('#82ccdd', '#f8c291'),
                       labels = c('< 2.29', '> 2.29')) +
  scale_y_continuous(minor_breaks = seq(0, 25, 1)) +
  scale_fill_manual (values = .myColors) +
  theme(axis.title = element_text(family = 'Lato Light',
                                  size = 10,
                                  color = '#60a3bc'),
        plot.background = element_rect(fill = 'white'),
        text = element_text(family = 'Lato'),
        legend.position = 'bottom',
        legend.background = element_rect(fill = 'grey95'),
        panel.grid.minor = element_line( size=0.25)) +
  guides(fill = 'none')

.T_LH_F <- .outcome_analysis_data_F  %>%
  filter(!is.na(LH_classe)) %>%
  ggplot(aes(x = LH_classe, y = T)) + 
  stat_summary(geom = 'col', fun = median, aes(fill = antiandrogène, group = LH_classe), alpha = 0.5)+
  geom_point(aes(color = T_2.29,
                 text = paste0("Testostéronémie : ", T, ' nmol/L \n', 'LH : ', LH, ' U/L')), size = 2) +
  geom_smooth(method = "loess", formula = y ~x,
              span = 1,
              se = F,
              aes(group = 1),
              col = '#38ada9') +
  geom_hline(yintercept=2.29, linetype = 'dashed', col = '#82ccdd', alpha = 0.5, size = 1) + 
  facet_grid(. ~ antiandrogène) +
  labs(
       x = 'LH (U/L)',
       y = 'Testostérone sérique (nmol/L)',
       color = 'Testostérone (nmol/L)') +
  scale_color_identity(guide = "legend",
                       breaks = c('#82ccdd', '#f8c291'),
                       labels = c('< 2.29', '> 2.29')) +
  scale_y_continuous(minor_breaks = seq(0, 25, 1)) +
  scale_fill_manual (values = .myColors) +
  theme(axis.title = element_text(family = 'Lato Light',
                                  size = 10,
                                  color = '#60a3bc'),
        plot.background = element_rect(fill = 'white'),
        text = element_text(family = 'Lato'),
        legend.position = 'bottom',
        legend.background = element_rect(fill = 'grey95'),
        panel.grid.minor = element_line( size=0.25)) +
  guides(fill = 'none')

.O2_LH_F <- .outcome_analysis_data_F  %>%
  filter(!is.na(LH_classe)) %>%
  ggplot(aes(x = O2_classe, y = LH)) + 
  stat_summary(geom = 'col', fun = median, aes(fill = antiandrogène, group = O2_classe), alpha = 0.5)+
  geom_point(aes(color = T_2.29,
                 text = paste0("LH : ", LH, ' U/L \n', 'Oestradiolémie : ', O2, ' ng/L')), size = 2) +
  geom_smooth(method = "glm", formula = y~x,
              method.args = list(family = gaussian(link = 'log')),
              span = 1,
              se = F,
              aes(group = 1),
              col = '#38ada9') +
  facet_grid(. ~ antiandrogène) +
  labs(
       x = 'Estradiol (ng/L)',
       y = 'LH (U/L)',
       color = 'Testostérone (nmol/L)') +
  scale_color_identity(guide = "legend",
                       breaks = c('#82ccdd', '#f8c291'),
                       labels = c('< 2.29', '> 2.29')) +
  scale_y_continuous(minor_breaks = seq(0, 7, 1)) +
  scale_fill_manual (values = .myColors) +
  theme(axis.title = element_text(family = 'Lato Light',
                                  size = 10,
                                  color = '#60a3bc'),
        plot.background = element_rect(fill = 'white'),
        text = element_text(family = 'Lato'),
        legend.position = 'bottom',
        legend.background = element_rect(fill = 'grey95'),
        panel.grid.minor = element_line( size=0.25)) +
  guides(fill = 'none')


.outcome_F_title <- cowplot::ggdraw() + 
  cowplot::draw_label(
    "Evolution de l'axe hypothalamo-hypophyso-gonadique chez les patient·e·s transféminin·e·s",
    fontfamily = 'Lato Black',
    color = '#3c6382',
    x = 0,
    hjust = 0,
  ) + 
  theme(
    plot.margin = margin(0, 0, 0, 7)
  )

.legend_F <- cowplot::get_legend(.T_time_F)


.outcome_grid_F <- cowplot::plot_grid(.T_time_F + theme(legend.position="none"),
                                      .T_O2_F + theme(legend.position="none"), 
                                      .T_LH_F + theme(legend.position="none"), 
                                      .O2_LH_F + theme(legend.position="none"),
                   ncol = 2,
                   nrow = 2,
                   labels = c('A', 'B', 'C', 'D'),
                   label_fontfamily = 'Lato',
                   label_colour = '#0a3d62'
                   ) +
theme(plot.title = element_text(family = 'Lato Black',
                                  color = '#3c6382'))

.outcome_plot_F <- cowplot::plot_grid(.outcome_F_title,
                                      .outcome_grid_F,
                                      .legend_F,
                   ncol = 1,
                   nrow = 3,
                   rel_heights = c(0.1, 1, 0.15))

ggsave("output/plots/outcome_plot_F.png",
       plot = .outcome_plot_F,
       width = 17, 
       height = 17,
       units = 'cm',
       dpi = 300,
       scale = 1.4)

.T_time_F_HTML <- .T_time_F +
  labs(title = 'A')+ 
  theme(legend.position='none')

.anim_T_time_F <- plotly::ggplotly(.T_time_F_HTML, tooltip = 'text') %>%
  plotly::style(hoverlabel = .label) %>%
  plotly::layout(font = .font,
                 yaxis = list(fixedrange = TRUE),
                 xaxis= list(fixedrange = TRUE),
                 title= list(layout.title.pad = 20),
                 legend = list(orientation = 'h', y = 110)) %>%
  plotly::config(displayModeBar = FALSE)

.T_O2_F_HTML <- .T_O2_F +
  labs(title = 'B')+ 
  theme(legend.position='none',
        axis.text.x = element_text(angle = 90))

.anim_T_O2_F <- plotly::ggplotly(.T_O2_F_HTML, tooltip = 'text') %>%
  plotly::style(hoverlabel = .label) %>%
  plotly::layout(font = .font,
                 yaxis = list(fixedrange = TRUE),
                 xaxis= list(fixedrange = TRUE),
                 title= list(layout.title.pad = 20),
                 legend = list(orientation = 'h', y = 110)) %>%
  plotly::config(displayModeBar = FALSE)

.T_LH_F_HTML <- .T_LH_F +
  labs(title = 'C')+ 
  theme(legend.position='none')

.anim_T_LH_F <- plotly::ggplotly(.T_LH_F_HTML, tooltip = 'text') %>%
  plotly::style(hoverlabel = .label) %>%
  plotly::layout(font = .font,
                 yaxis = list(fixedrange = TRUE),
                 xaxis= list(fixedrange = TRUE),
                 title= list(layout.title.pad = 20),
                 legend = list(orientation = 'h', y = 110)) %>%
  plotly::config(displayModeBar = FALSE)

.O2_LH_F_HTML <- .O2_LH_F +
  labs(title = 'D')+ 
  theme(legend.position='none',
        axis.text.x = element_text(angle = 90))

.anim_O2_LH_F <- plotly::ggplotly(.O2_LH_F_HTML, tooltip = 'text') %>%
  plotly::style(hoverlabel = .label) %>%
  plotly::layout(font = .font,
                 yaxis = list(fixedrange = TRUE),
                 xaxis= list(fixedrange = TRUE),
                 title= list(layout.title.pad = 20),
                 legend = list(orientation = 'h', y = 110)) %>%
  plotly::config(displayModeBar = FALSE)
