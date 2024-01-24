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

Using docker, you can either build or pull the docker image you need by running the following in your terminal, assuming you have either a Mac with an Intel chip, or a Windows-based machine. If not, go to the section on Mac with M1/M2 chips. 

#### Intel-based Mac and Windows

You can either build a local image or pull a pre-built image:

- build (assuming you are in the project directory you made in step 4):

  ```bash
  cd geospaar
  LATEST=VERSION # replace VERSION with the latest version number, here 4.3.2
  docker build . -t agroimpacts/geospaar:$LATEST
  ```
  
- pull (this gets you the latest version already committed to docker hub):

  ```bash
  LATEST=VERSION # replace VERSION with the version number, currently 4.3.2
  docker pull agroimpacts/geospaar:$LATEST
  ```

#### Mac Silicon
For Macs with a Silicon chip (M1/M2/M3), it appears that your OS has to be 14.2 or higher to run the container, otherwise there are clashes with the Linux architecture that is used to build the image (which is linux/amd64, whereas M1/M2 wants to use linux/arm64). We have started an experimental build script for M1/M2 chips running OS <14.2, but this doesn't work yet, so for now we advise you to upgrade your OS, and then run the build command as:

  ```bash
  docker build --platform=linux/amd64 . -t agroimpacts/geospaar:$LATEST
  ```

If that still doesn't work, please install `R` and Rstudio desktop

#### 7. Run the container
After building, run the image using the following script that comes with the `geopaar` repo:

  ```bash
  PORT=8787 # this is the port to run on--you might want to change it
  MY_DIR=c/My\ Documents/projects/geog246346 # change to your directory!!!
  ./run-container.sh -v $LATEST -p $PORT $MY_DIR
  ```

Note: Make sure that MY_DIR is the path of the directory that your cloned `geospaar` is in. MY_DIR should not include "geospaar" at the end of the path, because then `docker` will try and mount the `geospaar` folder, which will cause problems (the script will fail). We want to mount the directory `geospaar` is in so that we can create other projects in the same directory as `geospaar` while we are working in the `docker` container. 
  
You can also (preferably) run it from your project directory containing `geospaar`, as follows:

  ```bash
  cd $MY_DIR # or, if you are in geospaar, you can one level up with cd ..
  ./geospaar/run-container.sh -v $LATEST -p $PORT `pwd`
  ```

Either approach to launching will give you a URL (https://localhost:8787) that you can copy and paste into your browser, which will then give you a fully functioning Rstudio-server instance after you log in. 

When you are finished with Rstudio server, you should stop the container:

  ```bash
  docker stop geospaar_rstudio
  ```
  
You can restart the container again with the same `./geospaar/run-container.sh ...` command you used previously.  

### 8. Additional GitHub configuration steps

Before installing the course package, there are a few more GitHub configuration steps you have to set up to set up your GitHub on your container-based Rstudio server (or your local) Rstudio desktop. These entail setting up ssh keys and adding them to your GitHub account. 

The instructions for setting those up are found [here](https://agroimpacts.github.io/geospaar/unit1-module1.html#using-git-and-github) in Unit 1, Module, specifically 4.1 on `git` configuration and 4.3 on syncing your first repository. 

Once you have completed those steps and confirmed you can access the remote repo of `geospaar`, you can install the package. 

For people launching the container from Git Bash, there are some additional steps that need to be followed:

1. First, make sure your project folder is fresh and empty, except for a new clone of `geospaar` 
2. If it isn't, the easiest and least risky is to make a new folder (e.g. geog246346b). Move into that folder, and run git clone again on the `geospaar` repo 
3. Make sure your an container is not running (`docker stop geospaar_rstudio`)
4. Run `docker image ls` and copy the image id for any existing `agroimpacts/geospaar:$LATEST` images. Then using that copied id, run `docker rmi <imageid>` (replace `<imageid>` with the id you just copied. That will remove the current image. 
5. Enter the geospaar folder (`cd geospaar`) to get into your newly cloned `geospaar`, and then rerun the docker build commands.  Then launch the container again
6. You are now in a fresh Rstudio server environment.  You should see that the "geospaar" and the "r_ver4.3.2_packages" folders are there. The Rstudio server interface should not be pointing at a new project 
7. Now, follow the steps mentioned at the top of this section: 
  - Configure your GitHub username and email in the terminal of Rstudio server
  - Then create an ssh key and add it to GitHub
8. Now, open the geospaar project using the new project dialog in Rstudio server. The opened project should show a `git` tab in the lower left pane of the IDE 
9. In the terminal in Rstudio server run the following commands:

  ```bash
  git config --global safe.directory '*'
  git config core.fileMode false
  ```
10. Next, run `git status`. It should show a bunch of files have been modified. If it does, run:
  `git stash`, followed again by `git status`. It should show no changes to the repo.  Try `git pull`, which should that you are be up to date. This should be working now

### 9. Install `geospaar` and browse the course materials

Build the `geospaar` package. To do so, first in Rstudio, go to File > Open Project, and then navigate to the `geospaar` folder, and then select the `geospaar.Rproj` file. That opens up the Rstudio project. Then, in the `R` console, run:

```R
devtools::install(build_vignettes = TRUE)
```

Or, alternatively, you can run:

```R
devtools::install_github("agroimpacts/geospaar", build_vignettes = TRUE)
```

And you don't need to open the `geospaar` project to do that. 

To browse the materials, from the R console in Rstudio:

```R
browseVignettes("geospaar")
```

In the docker container, there is an additional step you have to do to make the vignettes findable. In the browser that opens up, providing the index of vignettes, you will see an address that looks something like this:

```
http://localhost:8787/session/Rvig.17c2b221378.html
```

Change that to:

```
http://localhost:8787/help/session/Rvig.17c2b221378.html
```

And you will be able to read the individual vignettes.

On the web:
Thanks to @LLeiSong, the materials are also available through the [course website](https://agroimpacts.github.io/geospaar/).




