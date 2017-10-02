## ----setup, echo=FALSE, include=FALSE------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(knitr)

## ---- echo = FALSE-------------------------------------------------------
mat <- rbind(c("Practical assignments (n=6)", "30% of grade", "20% of grade"), 
            c("Oral presentation of semester project", "20% of grade", 
              "30% of grade"),
            c("Final report on semester project", "40% of grade", 
              "40% of grade"))
colnames(mat) <- c("Component", "GEOG246", "GEOG346")
kable(mat)                 

## ---- echo = FALSE-------------------------------------------------------
gr <- c(37, 12, 40, 65, 10, 16)
ug <- c(37, 14, 50, 59, 8, 12)
DF <- cbind.data.frame(c("Class meetings", "Readings", "Practicals", 
                         "Semester projects-analysis", 
                         "Semester projects-presentation",
                         "Semester projects-final report", "Total hours"), 
                       c(gr, sum(gr)), c(ug, sum(ug)))
colnames(DF) <- c("", "GEOG246 hours", "GEOG346 hours")
kable(DF)                 


## ---- eval = FALSE-------------------------------------------------------
#  install.packages("swirl")
#  library(swirl)

