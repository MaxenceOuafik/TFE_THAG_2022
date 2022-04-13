library(dplyr)
library(officer)
library(officedown)
library(bookdown)

render_book('index.Rmd', 
            output_format = 'bookdown::markdown_document2',
            output_dir = 'output/')

read_docx(path = 'files/cover-page.docx') %>%
  body_add_break(pos = 'after') %>%
  body_add_docx(src = 'output/TFE.docx') %>%
  print(target = 'output/initiation_THAG_MG_TFE.docx')

unlink(c('output/TFE.docx', 
         'output/reference-keys.txt'))
