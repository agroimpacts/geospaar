
patterns = c("unit1-module3.Rmd", "unit1-module2.Rmd" )

rmds <- dir(here::here("vignettes"), pattern = "Rmd", full.names = TRUE)
for (pattern in patterns){
  print(pattern)
  ifile <- rmds[grep(pattern, rmds)]
  ohtml <- here::here("docs",
                      paste0(gsub("\\.Rmd", "", basename(ifile)), ".html"))
  rmarkdown::render(input = ifile, output_file = ohtml)
}

## in docs folder

patterns = c("index.Rmd" )

rmds <- dir(here::here("docs"), pattern = "Rmd", full.names = TRUE)
for (pattern in patterns){
  print(pattern)
  ifile <- rmds[grep(pattern, rmds)]
  ohtml <- here::here("docs",
                      paste0(gsub("\\.Rmd", "", basename(ifile)), ".html"))
  rmarkdown::render(input = ifile, output_file = ohtml)
}
