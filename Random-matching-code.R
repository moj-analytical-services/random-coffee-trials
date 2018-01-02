setwd("/Users/inshachaddha/Desktop/random-coffee-trials-master")
read
install.packages("stringr")
library(stringr)
install.packages("sprintf")

checkfile <- read.csv("Checkfile.csv")
checkfile <- checkfile[!checkfile$NAME.1=="",]
checkfile$NAME.1 <- as.character(checkfile$NAME.1)
checkfile$Email1 <- as.character(checkfile$Email1)



existing <- read.csv("Existing combinations.csv")
checkvector <- with(existing, interaction(NAME.1, NAME.2))
checkvector <- as.character(checkvector)

#RUN BELOW
donebefore <- rep(1, 26)
while (sum(donebefore) > 0) {

  randomised <- sample(checkfile$NAME.1)
    setone <- randomised[1:(length(randomised)/2)]
    settwo <- randomised[(length(randomised)/2 + 1) : length(randomised)]

  matches <- data.frame(setone, settwo)
    combination <- as.character(with(matches, interaction(setone,settwo)))
    combinationreverse <- as.character(with(matches, interaction(settwo,setone)))
    
  donebefore <- (append(combination %in% checkvector, combinationreverse %in% checkvector))*1
}

checkvector <- append(checkvector, combination)
print(combination)
print(checkvector)



#Creating CSV of below

FIRSTNAME <- str_extract(combination, "[^.]+")
SECONDNAME <- str_extract(combination, "[^.]*$")

Email1 <- rep("hi",13)
Email1 <- as.character(Email1)

Email2 <- rep("hi",13)
Email2 <- as.character(Email2)

Department1 <- rep("hi",13)
Department1 <- as.character(Department1)


Department2 <- rep("hi",13)
Department2 <- as.character(Department2)

results <- data.frame(combination, FIRSTNAME, Email1, Department1, SECONDNAME, Email2, Department2 )

results$Email1 <- checkfile$Email1[match(results$FIRSTNAME, checkfile$NAME.1)]

results$Email2 <- checkfile$Email1[match(results$SECONDNAME, checkfile$NAME.1)]

results$Department1 <- checkfile$Department1[match(results$FIRSTNAME, checkfile$NAME.1)]
results$Department2 <- checkfile$Department1[match(results$FIRSTNAME, checkfile$NAME.1)]

#Create CSV of below
print(results)


