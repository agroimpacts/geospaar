# geospaar
The main repository for Clark University's Geospatial Analysis with R course (GEOG 246/346). All course materials will be presented here.

If you are here and reading this, then you already have access to the private GitHub repository on which this is hosted.  However, we want to install this as an R package. To do that, please follow the instructions here.

## Installation

#### 1. Get the `devtools` package

```R
install.packages("devtools")
library(devtools)
```

Add these ones as well, while you are at it:
```R  
install.packages(c("knitr", "kableExtra", "prettydoc"))
```

#### 2. Get a [personal access token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/) for GitHub

- Go into your GitHub account, and click settings, and then (on the left)  developer settings 
- Select personal access tokens
- Generate a new token, name it something meaningful, and check the "repo" box

<p align="center">
  <img width="793" height="328" src="vignettes/fig/pat4.png">
</p>

- Copy the token and paste it somewhere safe (e.g. a secure password manager) 


#### 3. install the `geospaar` package

Note that the code below reflects recent changes to the `devtools` package (versions > 2), which has changed the options for building vignettes. If you have an older version of `devtools`, try uncomment and then run the version that is currently commented out.
```R
library(devtools)
install_github("agroimpacts/geospaar", build = TRUE, 
               auth_token = "the-token-you-just-generated-pasted-here",
               force = TRUE, build_opts = c("--no-resave-data", "--no-manual"))
# install_github("agroimpacts/geospaar", build_vignettes = TRUE, 
#                auth_token = "the-token-you-just-generated-pasted-here")
```

#### 4. Browse the course materials

```R
browseVignettes("geospaar")
```


We'll be updating this often as the course unfolds, so you will be repeating the step 3 often.  Keep your token safe and sound somewhere. It's also easy to generate a new one when you need it.  
