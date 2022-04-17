library(ggplot2)
library(ggthemes)

.myColors <- c('#f8c291', '#6a89cc', '#82ccdd', '#b8e994')

.font = list(
  family = 'Lato',
  size = 12,
  color = 'white'
)

.label = list(
  bordercolor = 'transparent',
  font = .font
)

.TFE_theme_Word <- theme_fivethirtyeight() +
  theme(axis.title = element_text(family = 'Lato Light',
                                  size = 12,
                                  color = '#60a3bc'),
        axis.title.x = element_text(vjust = -2),
        axis.title.y = element_text(vjust = 4),
        plot.title = element_text(family = 'Lato Black',
                                  color = '#3c6382'),
        plot.background = element_rect(fill = 'white'),
        text = element_text(family = 'Lato')) 

.TFE_theme_HTML <- .TFE_theme_Word 
