#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 1L) {
  stop("Usage: Rscript tools/copy-slide-assets.R <site-directory>", call. = FALSE)
}

site_dir <- normalizePath(args[[1]], mustWork = TRUE)
slide_files <- list.files("docs", pattern = "^class.*\\.html$", full.names = TRUE)
asset_dirs <- file.path("docs", c("libs", "themes", "class9_files"))
asset_dirs <- asset_dirs[dir.exists(asset_dirs)]
extra_files <- file.path("docs", "rmarkdown_demo.html")

copy_into_site <- function(paths) {
  copied <- file.copy(paths, site_dir, recursive = TRUE, overwrite = TRUE)
  if (!all(copied)) {
    stop("Could not copy all slide files into ", site_dir, call. = FALSE)
  }
}

copy_into_site(slide_files)
copy_into_site(asset_dirs)
copy_into_site(extra_files)

write_redirect <- function(name, target) {
  writeLines(
    c(
      "<!doctype html>",
      sprintf('<meta http-equiv="refresh" content="0; url=%s">', target),
      "<title>Redirecting</title>",
      sprintf('<p>Continue to <a href="%s">the course page</a>.</p>', target)
    ),
    file.path(site_dir, name)
  )
}

write_redirect("syllabus.html", "articles/syllabus.html")
write_redirect("projects.html", "articles/projects.html")
