
checkfile <- read.csv("Checkfile.csv")
checkfile <- (checkfile[1:89,])
checkfile$Existingcombinations <- with(checkfile, interaction(NAME.1, NAME.2))
checkvector <- checkfile$Existingcombinations
checkvector <- as.character(checkvector)