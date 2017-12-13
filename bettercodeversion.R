
read
install.packages("stringr")
library(stringr)


checkfile <- read.csv("Checkfile.csv")
checkfile <- (checkfile[1:26,])
checkfile$NAME.1 <- as.character(checkfile$NAME.1)
checkfile$Email1 <- as.character(checkfile$Email1)


checkfile$Existingcombinations <- with(checkfile, interaction(NAME.1, NAME.2))
checkvector <- checkfile$Existingcombinations
checkvector <- as.character(checkvector)


names <- append(checkfile$NAME.1, checkfile$NAME.2)
names <- as.character(names)
while (!sum(donebefore) == 0) {

sample(checkfile$NAME.1)
setone <- checkfile$NAME.1[1:14]
settwo <- checkfile$NAME.1[15:26]

matches <- data.frame(setone, settwo)
combination <- with(matches, interaction(setone,settwo))
combination <- as.character(combination)

FIRSTNAME <- str_extract(combination, "[^.]+")
SECONDNAME <- str_extract(combination, "[^.]*$")

donebefore <- grepl("FIRSTNAME&&SECONDNAME", checkvector)

donebefore <- donebefore*1

}
print(combination)



Email1 <- rep(NA,7)
Email1 <- as.character(Email1)

results$Email1 <- checkfile$Email1[match(FIRSTNAME, checkfile$NAME.1)]

results <- cbind(combination, FIRSTNAME, SECONDNAME, Email1)
data.frame(results)


results$Email1 <- checkfile$Email1[match(FIRSTNAME, checkfile$NAME.1)]


?match
checkvector <- append(checkvector, combination)
print(checkvector)

                                                                