## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.align = 'center', fig.height = 4, 
                      fig.width = 5)

## ------------------------------------------------------------------------
farmers <- read.csv(system.file("extdata/farmer_spatial.csv", 
                                package = "geospaar"), stringsAsFactors = FALSE)

