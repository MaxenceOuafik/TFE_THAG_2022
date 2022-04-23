library(dplyr)
library(officer)
library(officedown)
library(bookdown)

render_book('index.Rmd', 
            output_format = 'bookdown::markdown_document2',
            output_dir = 'output/')

read_docx('output/TFE.docx') %>%
  body_replace_all_text("(PART) ", "", fixed = T) %>%
  print(target = 'output/initiation_THAG_MG_TFE.docx')

unlink(c('output/TFE.docx',
         'output/reference-keys.txt'))

render_book('index.Rmd', output_format = 'bookdown::gitbook')
