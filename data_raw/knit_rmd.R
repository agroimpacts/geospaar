
patterns = c("index.Rmd", "unit1-module3.Rmd")

rmds <- dir(here::here("vignettes"), pattern = "Rmd", full.names = TRUE)


for (pattern in patterns){
  ifile <- rmds[grep(pattern, rmds)]
  ohtml <- here::here("docs",
                      paste0(gsub("\\.Rmd", "", basename(ifile)), ".html"))
  rmarkdown::render(input = ifile, output_file = ohtml)
}

