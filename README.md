# geospaar
The main repository for Clark University's Geospatial Analysis with R course (GEOG 246/346). All course materials will be presented here.

If you are here and reading this, then you already have access to the private GitHub repository on which this is hosted.  However, we want to install this as an R package. To do that, please follow the instructions here.

# Installation

1. Get the `devtools` package:

```R
install.packages("devtools")
library(devtools)
```

2. Get a personal access token for GitHub

We'll cheat a little bit here and direct you to the directions in the [help file](https://www.dropbox.com/s/pbf9phn8h4rl09d/help.html?dl=0) vignette, before it is installed. That shows you how to get an access token. 

3. Once you have that, install the `geospaar` package

```R
library(devtools)
install_github("agroimpacts/geospaar", build_vignettes = TRUE, 
               auth_token = "the-token-you-just-generated-pasted-here")
```

4. Browse the course materials

```R
browseVignettes("geospaar")
```


We'll be updating this often as the course unfolds, so you will be repeating the step 3 often.  Keep your token safe and sound somewhere. It's also easy to generate a new one when you need it.  
