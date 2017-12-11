
read
install.packages("stringr")
library(stringr)


checkfile <- read.csv("Checkfile.csv")
checkfile <- (checkfile[1:14,])
checkfile$NAME.1 <- as.character(checkfile$NAME.1)
checkfile$NAME.2 <- as.character(checkfile$NAME.2)
checkfile$Existingcombinations <- with(checkfile, interaction(NAME.1, NAME.2))
checkvector <- checkfile$Existingcombinations
checkvector <- as.character(checkvector)


names <- append(checkfile$NAME.1, checkfile$NAME.2)
names <- as.character(names)

while (!sum(donebefore) == 0) {

sample(names)
setone <- names[1:14]
settwo <- names[15:28]

matches <- data.frame(setone, settwo)
combination <- with(matches, interaction(setone,settwo))
combination <- as.character(combination)

FIRSTNAME <- str_extract(combination, "[^.]+")
SECONDNAME <- str_extract(combination, "[^.]*$")

donebefore <- grepl("FIRSTNAME&&SECONDNAME", checkvector)

donebefore <- donebefore*1

}
print(combination)
checkvector <- append(checkvector, combination)
print(checkvector)

                                                                