setwd("/Users/inshachaddha/Desktop/random-coffee-trials-master")
read
install.packages("stringr")
library(stringr)
install.packages("sprintf")

checkfile <- read.csv("Checkfile.csv")
checkfile <- checkfile[!checkfile$NAME.1=="",]
checkfile$NAME.1 <- as.character(checkfile$NAME.1)
checkfile$Email1 <- as.character(checkfile$Email1)
checkfile$ID <- seq.int(nrow(checkfile))

existing1 <- as.character(checkfile$ID[1:(length(randomised)/2)])
existing2 <- as.character(checkfile$ID[(length(randomised)/2 + 1) : length(randomised)])

checkvector <- (interaction(existing1, existing2))
checkvector <- as.character(checkvector)

#RUN BELOW
donebefore <- rep(1, 26)
while (sum(donebefore) > 0) {

  randomised <- sample(checkfile$ID)
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

ID1 <- str_extract(combination, "[^.]+")
ID2 <- str_extract(combination, "[^.]*$")

Email1 <- as.character(rep("hi",13))
Email2 <- as.character(rep("hi",13))

Department1 <- as.character(rep("hi",13))
Department2 <- as.character(rep("hi",13))

Name1 <- as.character(rep("hi",13))
Name2 <- as.character(rep("hi",13))

Pairs <- as.character(rep("hi",13))

results <- data.frame(Pairs, Name1, Email1, Department1, Name2, Email2, Department2 )

  results$Name1 <- checkfile$NAME.1[match(ID1, checkfile$ID)]
  results$Name2 <- checkfile$NAME.1[match(ID2, checkfile$ID)]

  results$Email1 <- checkfile$Email1[match(ID1, checkfile$ID)]
  results$Email2 <- checkfile$Email1[match(ID2, checkfile$ID)]

  results$Department1 <- checkfile$Department1[match(ID1, checkfile$ID)]
  results$Department2 <- checkfile$Department1[match(ID2, checkfile$ID)]
  
  Pairs <- interaction(results$Name1, results$Name2)

#Create CSV of below
print(results)


