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
#  # these first 4 lines are the same steps as in the reading
#  data(cars)
#  set.seed(0)
#  brands <- c('Buick', 'Chevrolet', 'Ford')
#  b <- sample(brands, nrow(cars), replace=TRUE)
#  
#  # this is new--we are showing how to add points to an existing plot
#  cars2 <- cars  # We are copying cars to a new dataset
#  cars2$make <- b
#  cols <- c("blue", "green", "red")
#  plot(speed ~ dist, data = cars2[cars2$make == "Buick", ], pch = 20,
#       col = cols[1], ylim = c(0, max(cars2$speed)),
#       xlim = c(0, max(cars2$dist)))
#  for(i in 2:3) {
#    points(speed ~ dist, data = cars2[cars2$make == brands[i], ], pch = 20,
#           col = cols[i])
#  }
#  legend(90, 10, brands, pch = 20, pt.cex = 1, col = cols, cex = 1,
#         bty = "n")

