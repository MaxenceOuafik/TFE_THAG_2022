library(dplyr)
library(officer)
library(officedown)
library(bookdown)

render_book('index.Rmd', 
            output_format = 'bookdown::markdown_document2',
            output_dir = 'output/')

read_docx('output/TFE.docx') %>%
  body_replace_all_text("(PART) ", "", fixed = T) %>%
  print(target = 'output/TFE1.docx')

read_docx(path = 'files/cover-page.docx') %>%
  body_add_break(pos = 'after') %>%
  body_add_docx(src = 'output/TFE1.docx') %>%
  print(target = 'output/initiation_THAG_MG_TFE.docx')

unlink(c('output/TFE.docx',
         'output/TFE1.docx',
         'output/reference-keys.txt'))



