
read
install.packages("stringr")
library(stringr)
install.packages("sprintf")

checkfile <- read.csv("Checkfile.csv")
checkfile <- (checkfile[1:26,])
checkfile$NAME.1 <- as.character(checkfile$NAME.1)
checkfile$Email1 <- as.character(checkfile$Email1)



existing <- read.csv("Existing combinations.csv")
checkvector <- with(existing, interaction(NAME.1, NAME.2))
checkvector <- as.character(checkvector)

#RUN BELOW


while (sum(donebefore) > 0) {

randomised <- sample(checkfile$NAME.1)
setone <- randomised[1:13]
settwo <- randomised[14:26]

matches <- data.frame(setone, settwo)
combination <- with(matches, interaction(setone,settwo))
combinationreverse <- with(matches, interaction(settwo,setone))

combination <- as.character(combination)
combinationreverse <- as.character((combinationreverse))

part1 <- combination %in% checkvector

part2 <- combinationreverse %in% checkvector

donebefore <- append(part1, part2)

donebefore <- donebefore*1

FIRSTNAME <- str_extract(combination, "[^.]+")
SECONDNAME <- str_extract(combination, "[^.]*$")


}


print(combination)
checkvector <- append(checkvector, combination)

print(checkvector)



Email1 <- rep(NA,13)
Email1 <- as.character(Email1)

results <- cbind(combination, FIRSTNAME, SECONDNAME, Email1)

results$Email1 <- checkfile$Email1[match(results[FIRSTNAME], checkfile$NAME.1)]


data.frame(results)



results$Email1 <- checkfile$Email1[match(FIRSTNAME, checkfile$NAME.1)]

results
?match



                                                                