# GEOG 246/346 Setup Guide
## Geospatial Analysis with R

This guide prepares your computer for **GEOG 246/346: Geospatial Analysis with R**. You will connect GitHub to your terminal, install Docker, clone the course repository, build the course image, and run RStudio Server in a Docker container.

> **Windows users:** Complete all course commands in **WSL 2**, not in Command Prompt or PowerShell. Store course files in the WSL Linux filesystem, not under `/mnt/c/`.

---

## Part 1 — Connect GitHub to Your Terminal

Git tracks changes to your work, while GitHub stores repositories online. SSH securely connects your terminal to GitHub.

### Step 1 — Open the correct terminal

- **Windows:** Open your WSL Linux distribution, such as Ubuntu.
- **macOS:** Open the Terminal application.

Check whether Git is installed:

```bash
git --version
```

### Step 2 — Configure your Git identity

Git records your name and email with every commit. Replace the examples with your own information:

```bash
git config --global user.name "Your Full Name"
```

```bash
git config --global user.email "your_email@clarku.edu"
```

Confirm the settings:

```bash
git config --global --list
```

### Step 3 — Check for an SSH key

Check whether an SSH key already exists:

```bash
ls -la ~/.ssh
```

If you see `id_ed25519` and `id_ed25519.pub`, use that key and continue to Step 5. Otherwise, create a new key.

### Step 4 — Create an SSH key

Replace the example email with the email associated with your GitHub account. Press `Enter` to accept the default save location. Never share the private key file named `id_ed25519`.

```bash
ssh-keygen -t ed25519 -C "your_email@clarku.edu"
```

### Step 5 — Add the SSH key to the agent

The SSH agent makes your key available to Git during the terminal session.

**Windows with WSL:**

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

**macOS:**

```bash
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

### Step 6 — Add the public key to GitHub

Print your public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Copy the entire line beginning with `ssh-ed25519`. Do **not** copy the private key.

In GitHub, navigate to:

```text
Profile picture → Settings → SSH and GPG keys → New SSH key
```

Give the key a descriptive title, paste the public key, and select **Add SSH key**.

### Step 7 — Test the GitHub connection

Run:

```bash
ssh -T git@github.com
```

If asked whether to trust GitHub's host fingerprint, type `yes`. A successful message includes your GitHub username and explains that GitHub does not provide shell access. This is expected.

### Required setup check

Take a screenshot after the successful SSH test. It must show:

- The command `ssh -T git@github.com`.
- The successful authentication message containing your GitHub username.

Save it as:

```text
lastname_github_ssh_check.png
```

---

## Part 2 — Install and Test Docker

Docker provides the shared RStudio Server environment used in this course.

### Step 1 — Windows: install WSL 2

Skip this step on macOS. Open **PowerShell as Administrator**, then run:

```powershell
wsl --install
```

Restart if requested. Then open your Linux distribution, create a Linux username and password, and use the WSL terminal for the rest of this guide.

### Step 2 — Install Docker Desktop

Install Docker Desktop for your operating system.

- **Windows:** Enable **Use WSL 2 based engine**. Then go to **Settings → Resources → WSL Integration** and enable your Linux distribution.
- **macOS:** Install Docker Desktop for either Apple Silicon or Intel, based on your processor.

Open Docker Desktop and wait until it is fully running.

### Step 3 — Verify Docker

In your WSL or macOS terminal, run:

```bash
docker version
```

A correct installation shows both **Client** and **Server** sections. Next, run Docker's test container:

```bash
docker run --rm hello-world
```

---

## Part 3 — Create Your Course Workspace

Your workspace stores the course repository and future assignment repositories.

### Windows with WSL

Create the workspace in your Linux home directory:

```bash
mkdir -p ~/geog246346
cd ~/geog246346
pwd
```

The path shown by `pwd` should begin with `/home/`. Do not use paths beginning with `/mnt/c/`.

### macOS

Create the workspace in your home directory:

```bash
mkdir -p ~/geog246346
cd ~/geog246346
pwd
```

---

## Part 4 — Clone the Course Repository

The `geospaar` repository contains the R package, course materials, RStudio project, and Docker configuration files.

From inside the `geog246346` workspace, run:

```bash
git clone git@github.com:agroimpacts/geospaar.git
```

Confirm that the repository was downloaded:

```bash
ls
```

Enter the repository and inspect its files:

```bash
cd geospaar
ls -la
```

You should see files such as `Dockerfile`, `Dockerfile.arm64`, `geospaar.Rproj`, and `DESCRIPTION`.

---

## Part 5 — Build the Course Image

A Docker image is a reusable software environment. Building the image uses the course Dockerfile to create a local environment with the R version, spatial libraries, and packages needed for the course.

### Step 1 — Confirm your location

You must be inside the `geospaar` directory:

```bash
pwd
ls -la
```

Your path should end with `geog246346/geospaar`.

### Step 2 — Set the course version

```bash
VERSION=4.4.2
echo $VERSION
```

The expected output is `4.4.2`.

### Step 3 — Build the image

**Windows with WSL and Intel Macs:**

```bash
docker build \
  -t agroimpacts/geospaar:$VERSION \
  .
```

**Apple Silicon Macs:**

```bash
docker build \
  -f Dockerfile.arm64 \
  -t agroimpacts/geospaar:${VERSION}-arm64 \
  .
```

The final `.` means Docker uses the current folder as its build context. The `-t` option assigns the image name and version tag.

### Step 4 — Confirm the image exists

```bash
docker image ls agroimpacts/geospaar
```

Look for the tag `4.4.2`, or `4.4.2-arm64` on Apple Silicon.

---

## Part 6 — Start the GeoSPAAR Container

A container is a running instance of an image. The command below starts RStudio Server and mounts your local `geospaar` directory into the container.

### Step 1 — Confirm your location

Run the command from inside the local `geospaar` folder:

```bash
cd ~/geog246346/geospaar
pwd
```

### Step 2 — Run the container

Use this command on **Windows with WSL**, **macOS Intel**, and **macOS Apple Silicon**:

```bash
docker run --platform=linux/amd64 --rm -d \
  --name geospaar \
  -p 8787:8787 \
  -e PASSWORD=geospaar \
  -v "$(pwd):/home/rstudio/geospaar" \
  agroimpacts/geospaar:4.4.2
```

What the options mean:

- `--platform=linux/amd64` uses the AMD64 Linux platform; this is especially important on Apple Silicon Macs.
- `--rm` removes the container after it is stopped.
- `-d` runs the container in the background.
- `--name geospaar` gives the container a simple name.
- `-p 8787:8787` makes RStudio Server available at port 8787 on your computer.
- `-e PASSWORD=geospaar` sets the RStudio Server password.
- `-v "$(pwd):/home/rstudio/geospaar"` mounts your local course folder in the container.
- `agroimpacts/geospaar:4.4.2` identifies the course image.

A successful command returns a long container ID.

### Step 3 — Verify the container

```bash
docker ps
```

Look for a container named `geospaar` with a mapping similar to `0.0.0.0:8787->8787/tcp`.

### Step 4 — Open RStudio Server

Open this address in a browser:

```text
http://localhost:8787
```

Log in with:

```text
Username: rstudio
Password: geospaar
```

Your local course directory is available inside RStudio at:

```text
/home/rstudio/geospaar
```

Files saved there remain on your computer because that directory is mounted from your local workspace.

---

## Part 7 — Open and Install the Course Package

In RStudio Server:

1. Select **File → Open Project**.
2. Open `/home/rstudio/geospaar`.
3. Select `geospaar.Rproj`.
4. Select **Open**.

In the **R Console**, install the package and build the course vignettes:

```r
devtools::install(build_vignettes = TRUE)
```

Then browse the course materials:

```r
browseVignettes("geospaar")
```

---

## Part 8 — Stop and Troubleshoot

When you finish, stop the container:

```bash
docker stop geospaar
```

Because the container was started with `--rm`, Docker removes the stopped container automatically. Your files remain safe in the local `geospaar` folder.

To start a new session, return to the repository and rerun the command from Part 6:

```bash
cd ~/geog246346/geospaar
```

If Docker says that the name `geospaar` is already in use, remove the old container:

```bash
docker rm -f geospaar
```

If RStudio does not open, check the container status and logs:

```bash
docker ps -a
docker logs geospaar
```
