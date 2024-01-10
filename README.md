# Geospatial Analysis with R

This is the repository for Clark University's Geospatial Analysis with R course (GEOG 246/346). The course materials are provided as an `R` package (`geospaar`), with the course material provided in the package vignettes, and, thanks to @LLeiSong, through the [course website](https://agroimpacts.github.io/geospaar/).

Although these materials were designed for a course taught at Clark University, the two modules it provides may be useful to anyone interested in learning `R` programming and basic geospatial analysis.

This course draws from a number of other `R` courses and materials that are online (e.g. blogs, tweets, etc). We have tried to give credit to those materials wherever we draw on those. If you find that we have missed giving credit where it is due, please let us know by submitting an issue (ideally with blame assigned to the specific location) and we will remedy it.

## Installation

The course materials can be installed as a standard `R` package, using a desktop Rstudio installation (or another IDE), or within a `docker` container. For the standalone case, you can simply install the course package from your Rstudio Desktop (or similar IDE) installation (which assumes you have the `devtools` package installed), per step 7 below. 

The dockerized approach, which will be followed for the full class, provides a consistent environment, making it less susceptible to the idiosyncrasies of different operating systems. The same container environment will be used for developing `R` packages for class assignments and projects. More detail on working with `docker` can be found in the materials for [Advanced Geospatial Analysis with Python](https://hamedalemo.github.io/advanced-geo-python/lectures/docker.html), taught by Professor Alemohammad. For now we will just use it for installing course materials. Please follow these steps to get started. 

### 1. Get a GitHub account

If you don't already have one, please go to [github.com](https://github.com/) and sign up for a free account. 

If you are enrolled in this course, also get a [personal access token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/) for GitHub, which is necessary for undertaking assignments (which will be on submitted in a private repo established on your own GitHub account). Use the classic token rather than the newer fine-grained tokens. 

- Go into your GitHub account, and click settings, and then (on the left)  developer settings 
- Select personal access tokens
- Generate a new token (classic), name it something meaningful, and check the "repo" box

<p align="center">
  <img width="793" height="328" src="vignettes/fig/pat4.png">
</p>

- Copy the token and paste it somewhere safe (e.g. a secure password manager) 

### 2. If you are a Windows users, install a Linux terminal emulator

- If not, skip to step 3

- If so, either install [`WSL`](https://learn.microsoft.com/en-us/windows/wsl/install), or [Git Bash](https://gitforwindows.org/). You can get away with Windows command prompt or Power Shell, but a *nix emulator is preferred.

- Either way, please **DO NOT** use the Windows command prompt or Power Shell for subsequent work (you are of course free to do so, but you will have to troubleshoot any problems that arise on your own). 

### 3. Install `docker`

Download and install the version of docker for your operating system from [here](https://www.docker.com/products/docker-desktop/), and create an account. Note: You can sign up with your Github credentials

### 4. Set up a project directory on your computer 

If you are taking this class, this will be the directory you use to install the class materials and your own assignment repositories/packages. Assuming you have a directory called something like `c:\My Documents\projects`, make a sub-folder called `geog246346`. Using your *nix terminal, navigate to it. 

```bash
cd c/My\ Documents/projects/geog246346
```

### 5. Clone the `geospaar` repository

  ```bash
  git clone https://github.com/agroimpacts/geospaar.git
  ```

### 6. Build or pull the `docker` image

Using docker, you can either build or pull the docker image you need by running the following in your terminal:

- build (assuming you are in the project directory you made in step 4):

  ```bash
  cd geospaar
  LATEST=VERSION # replace this with the version number here, here 4.3.2
  docker build . -t agroimpacts/geospaar:$LATEST
  ```
  
- pull (this gets you the latest version already committed to docker hub):

  ```bash
  LATEST=VERSION # replace this with the version number here, here 4.3.2
  docker pull agroimpacts/geospaar:$LATEST
  ```

Then run the image using the following script that comes with the `geospaar` repo:

  ```bash
  PORT=8787 # this is the port to run on--you might want to change it
  MY_DIR=c/My\ Documents/projects/geog246346 # change to yours!!!
  ./run-container.sh -v $LATEST -p $PORT $MY_DIR
  ```

Note: Make sure that MY_DIR is the path of the directory that your cloned `geospaar` is in. MY_DIR should not include geospaar at the end of the path, because then `docker` will try and mount the `geospaar` folder, which will cause problems. We want to mount the directory `geospaar` is in so that we can create other projects in the same directory as `geospaar` while we are working in the `docker` container. 

This should give you a URL (https://localhost:8787) that you can copy and paste into your browser, which will then give you a fully functioning Rstudio-server instance after you log in. 


### 7. Browse the course materials

Build the `geospaar` package...

```R
library(devtools)
install_github("agroimpacts/geospaar", build_vignettes = TRUE)
```

...and then, from the R console in Rstudio:

```R
browseVignettes("geospaar")
```

On the web:
Thanks to @LLeiSong, the materials are also available through the [course website](https://agroimpacts.github.io/geospaar/).




