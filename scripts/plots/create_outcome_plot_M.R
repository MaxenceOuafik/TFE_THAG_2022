source('scripts/plots/create_plot_theme.R')


.outcome_analysis_data_M <- .long_outcome_data  %>%
  filter(transition == 'Personnes transmasculines',
         !(patient == '3FQ' & consultation == 'T4'),
          !(patient == '7KQ' & consultation == 'T1'),
         !is.na(androgène)) %>%
  mutate(T_14_24 = ifelse(T < 14, '#f8c291', 
                          ifelse(T > 14 & T < 24.7, '#82ccdd', '#e55039')),
         O2_classe = cut(O2, breaks = c(0, 50, 500),
                         labels = c("< 50", "> 50")),
         FSH_classe = cut(FSH, breaks = c(0, 2, 5, 9, 70),
                         labels = c("< 2", "2-5", '6-9', '> 9')),
         T_classe = cut(T, breaks = c(0, 14, 24.7, 70),
                        labels = c('< 14', '14-24', '> 24'))) %>%
  select(-antiandrogène, -oestrogène, - Pr)

.T_time_M <- .outcome_analysis_data_M %>%
  ggplot(aes(x = consultation, y = T)) + 
  stat_summary(geom = 'col', fun = median, aes(fill = 'identity', group = consultation), alpha = 0.5)+
  geom_point(aes(color = T_14_24,
                 text = paste0("Testostéronémie : ", T, ' nmol/L \n', 'Consultation : ', consultation)), size = 2) +
  geom_smooth(method = "lm", formula = y~x,
              se = F,
              aes(group = 1),
              col = '#38ada9') +
  geom_hline(yintercept=c(14,24.7), linetype = 'dashed', col = '#82ccdd', alpha = 0.5, size = 1) + 
  labs(
       x = 'Consultations',
       y = 'Testostérone sérique (nmol/L)',
       color = 'Testostéronémie (nmol/L)') +
  scale_color_identity(guide = "legend",
                       breaks = c('#f8c291', '#82ccdd', '#e55039'),
                       labels = c('< 14', '14-24', '> 24')) +
  scale_y_continuous(minor_breaks = seq(0, 35, 2)) +
  scale_fill_manual (values = .myColors) +
  theme(axis.title = element_text(family = 'Lato Light',
                                  size = 10,
                                  color = '#60a3bc'),
        plot.background = element_rect(fill = 'white'),
        text = element_text(family = 'Lato'),
        panel.grid.minor = element_line( size=0.25),
        legend.background = element_rect(fill = 'grey95')) +
  guides(fill = 'none')

.T_O2_M <- .outcome_analysis_data_M  %>%
  filter(!is.na(T_classe)) %>%
  ggplot(aes(y = O2, x = T_classe)) + 
  stat_summary(geom = 'col', fun = median, aes(fill = 'identity', group = T_classe), alpha = 0.5)+
  geom_point(aes(color = T_14_24,
                 text = paste0("Testostéronémie : ", T, ' nmol/L \n', 'Oestradiolémie : ', O2, ' ng/L')), size = 2) +
  geom_smooth(method = "lm", formula = y~x,
              se = F,
              aes(group = 1),
              col = '#38ada9') +
  geom_hline(yintercept=50, linetype = 'dashed', col = '#82ccdd', alpha = 0.5, size = 1) + 
  labs(
       y = 'Estradiol sérique (ng/L)',
       x = 'Testostérone sérique (nmol/L)',
       color = 'Testostéronémie (nmol/L)') +
  scale_color_identity(guide = "legend",
                       breaks = c('#f8c291', '#82ccdd', '#e55039'),
                       labels = c('< 14', '14-24', '> 24')) +
  scale_y_continuous(minor_breaks = seq(0, 100, 5)) +
  scale_fill_manual (values = .myColors) +
  theme(axis.title = element_text(family = 'Lato Light',
                                  size = 10,
                                  color = '#60a3bc'),
        plot.background = element_rect(fill = 'white'),
        text = element_text(family = 'Lato'),
        panel.grid.minor = element_line( size=0.25),
        legend.background = element_rect(fill = 'grey95')) +
  guides(fill = 'none')

.O2_FSH_M <- .outcome_analysis_data_M  %>%
  filter(!is.na(FSH_classe),
         !is.na(T_classe)) %>%
  ggplot(aes(y = FSH, x = O2)) + 
  geom_point(aes(color = T_14_24, 
                 text = paste0("FSH : ", FSH, ' U/L \n', 'Oestradiolémie : ', O2, ' ng/L')), size = 2) +
  geom_smooth(method = "lm", formula = y~x,
              span = 1,
              se = F,
              aes(group = 1),
              col = '#38ada9') +
  labs(
       x = 'Estradiol (ng/L)',
       y = 'FSH (U/L)',
       color = 'Testostéronémie (nmol/L)') +
  scale_color_identity(guide = "legend",
                       breaks = c('#f8c291', '#82ccdd', '#e55039'),
                       labels = c('< 14', '14-24', '> 24')) +
  scale_y_continuous(minor_breaks = seq(0, 11, 1)) +
  theme(axis.title = element_text(family = 'Lato Light',
                                  size = 10,
                                  color = '#60a3bc'),
        plot.background = element_rect(fill = 'white'),
        text = element_text(family = 'Lato'),
        legend.background = element_rect(fill = 'grey95'),
        panel.grid.minor = element_line( size=0.25))

.T_FSH_M <- .outcome_analysis_data_M  %>%
  filter(!is.na(T_classe)) %>%
  ggplot(aes(x = T_classe, y = FSH)) + 
  stat_summary(geom = 'col', fun = median, aes(fill = 'identity', group = T_classe), alpha = 0.5)+
  geom_point(aes(color = T_14_24,
                 text = paste0("Testostéronémie : ", T, ' nmol/L \n', 'LH : ', LH, ' U/L')), size = 2) +
  geom_smooth(method = "lm", formula = y ~x,
              span = 1,
              se = F,
              aes(group = 1),
              col = '#38ada9') +
  geom_hline(yintercept=2.29, linetype = 'dashed', col = '#82ccdd', alpha = 0.5, size = 1) + 
  labs(
       y = 'FSH (U/L)',
       x = 'Testostérone sérique (nmol/L)',
       color = 'Testostéronémie (nmol/L)') +
  scale_color_identity(guide = "legend",
                       breaks = c('#f8c291', '#82ccdd', '#e55039'),
                       labels = c('< 14', '14-24', '> 24')) +
  scale_y_continuous(minor_breaks = seq(0, 25, 1)) +
  scale_fill_manual (values = .myColors) +
  theme(axis.title = element_text(family = 'Lato Light',
                                  size = 10,
                                  color = '#60a3bc'),
        plot.background = element_rect(fill = 'white'),
        text = element_text(family = 'Lato'),
        panel.grid.minor = element_line( size=0.25),
        legend.background = element_rect(fill = 'grey95')) +
  guides(fill = 'none')


.outcome_M_title <- cowplot::ggdraw() + 
  cowplot::draw_label(
    "Evolution de l'axe hypothalamo-hypophyso-gonadique chez les patient·e·s transmasculin·e·s",
    fontfamily = 'Lato Black',
    color = '#3c6382',
    x = 0,
    hjust = 0,
  ) + 
  theme(
    plot.margin = margin(0, 0, 0, 7)
  )

.legend_M <- cowplot::get_legend(.T_time_M)

.outcome_grid_M <- cowplot::plot_grid(.T_time_M + theme(legend.position="none"), 
                                      .T_O2_M + theme(legend.position="none"), 
                                      .O2_FSH_M + theme(legend.position="none"),
                                      .T_FSH_M + theme(legend.position="none"),
                                      ncol = 2,
                                      nrow = 2,
                                      labels = c('A', 'B', 'C', 'D'),
                                      label_fontfamily = 'Lato',
                                      label_colour = '#0a3d62'
) +
  theme(plot.title = element_text(family = 'Lato Black',
                                  color = '#3c6382'))

.outcome_plot_M <- cowplot::plot_grid(.outcome_M_title, .outcome_grid_M, .legend_M,
                                      ncol = 1,
                                      nrow = 3,
                                      rel_heights = c(0.1, 1, 0.25))

ggsave("output/plots/outcome_plot_M.png",
       plot = .outcome_plot_M,
       width = 17, 
       height = 19,
       units = 'cm',
       dpi = 300,
       scale = 1.4)

.T_time_M_HTML <- .T_time_M +
  labs(title = 'A') + 
  theme(legend.position='none')

.anim_T_time_M <- plotly::ggplotly(.T_time_M_HTML, tooltip = 'text')  %>%
  plotly::style(hoverlabel = .label) %>%
  plotly::layout(font = .font,
                 yaxis = list(fixedrange = TRUE),
                 xaxis= list(fixedrange = TRUE),
                 title= list(layout.title.pad = 20)) %>%
  plotly::config(displayModeBar = FALSE)

.T_O2_M_HTML <- .T_O2_M +
  labs(title = 'B') + 
  theme(legend.position='none')
  

.anim_T_O2_M <- plotly::ggplotly(.T_O2_M_HTML, tooltip = 'text') %>%
  plotly::style(hoverlabel = .label) %>%
  plotly::layout(font = .font,
                 yaxis = list(fixedrange = TRUE),
                 xaxis= list(fixedrange = TRUE),
                 title= list(layout.title.pad = 20),
                 legend = list(orientation = 'h', y = 110)) %>%
  plotly::config(displayModeBar = FALSE)

.T_FSH_M_HTML <- .T_FSH_M +
  labs(title = 'C') +
  theme(legend.position='none')

.anim_T_FSH_M <- plotly::ggplotly(.T_FSH_M_HTML, tooltip = 'text') %>%
  plotly::style(hoverlabel = .label) %>%
  plotly::layout(font = .font,
                 yaxis = list(fixedrange = TRUE),
                 xaxis= list(fixedrange = TRUE),
                 title= list(layout.title.pad = 20),
                 legend = list(orientation = 'h', y = 110)) %>%
  plotly::config(displayModeBar = FALSE)

.O2_FSH_M_HTML <- .O2_FSH_M +
  labs(title = 'D')+ 
  theme(legend.position='none')

.anim_O2_FSH_M <- plotly::ggplotly(.O2_FSH_M_HTML, tooltip = 'text') %>%
  plotly::style(hoverlabel = .label) %>%
  plotly::layout(font = .font,
                 yaxis = list(fixedrange = TRUE),
                 xaxis= list(fixedrange = TRUE),
                 title= list(layout.title.pad = 20),
                 legend = list(orientation = 'h', y = 110)) %>%
  plotly::config(displayModeBar = FALSE)
