
#Always do this bit for stringr
install.packages("stringr")
library(stringr)
install.packages("sprintf")

#Reload this whenever you update
checkfile <- read.csv("FSNAMES.csv")
checkfile <- checkfile[!checkfile$NAME.1=="",]

checkfile$NAME.1 <- as.character(checkfile$NAME.1)
checkfile$Primary.Email <- as.character(checkfile$Primary.Email)

#This step is to give everyone a unique ID (I matched by IDs not names)
checkfile$ID <- seq.int(nrow(checkfile))

#Check if odd or even numbers of participants. We decided that if there were odd numbers, we would remove Tom
is.even <- function(x) x %% 2 == 0
even <- is.even(length(checkfile$NAME.1))
if (even == FALSE) {
 checkfile <- checkfile[ ! (checkfile$NAME.1 == "Thomas Grant") , ]
}
length(checkfile$NAME.1)

#Load all the combinations done previously
existingcombinations <- read.csv("Existingcombinations.csv")

#Check to make sure all names match up from old combos to full FS database
consistencycheck <- setdiff(existingcombinations$NAME.1, checkfile$NAME.1)
print(consistencycheck)
consistencycheck2 <- setdiff(existingcombinations$NAME.2, checkfile$NAME.1)
print(consistencycheck)

#This is to make a single vector of the existing combinations by just joining them with (Dot) in between
existing1 <- checkfile$ID[match(existingcombinations$NAME.1, checkfile$NAME.1)]
existing2 <- checkfile$ID[match(existingcombinations$NAME.2, checkfile$NAME.1)]
checkvector <- as.character((interaction(existing1, existing2)))


#RUN BELOW- This is the random matching code
donebefore <- rep(1, 26)
while (sum(donebefore) > 0 && sum(closeby) > 0) {

  randomised <- sample(checkfile$ID)
    setone <- randomised[1:(length(randomised)/2)]
    settwo <- randomised[(length(randomised)/2 + 1) : length(randomised)]

  matches <- data.frame(setone, settwo)
    combination <- as.character(with(matches, interaction(setone,settwo)))
    combinationreverse <- as.character(with(matches, interaction(settwo,setone)))
  
  donebefore <- (append(combination %in% checkvector, combinationreverse %in% checkvector))*1
  
}

#This bit needs editing. I prefer to update existing combos manually to prevent errors in testing
checkvector <- append(checkvector, combination)
print(combination)
print(checkvector)

#Creating CSV of results, pretty

ID1 <- str_extract(combination, "[^.]+")
ID2 <- str_extract(combination, "[^.]*$")

results <- data.frame(matrix(ncol = 11, nrow = length(checkfile$NAME.1)/2))
x <- c("Pairs", "Name1", "Email1", "SecondaryEmail1", "Department1", 
       "Location1", "Name2", "Email2", "SecondaryEmail2", "Department2", "Location2")
colnames(results) <- x

  results$Name1 <- checkfile$NAME.1[match(ID1, checkfile$ID)]
  results$Name2 <- checkfile$NAME.1[match(ID2, checkfile$ID)]

  results$Email1 <- checkfile$Primary.Email[match(ID1, checkfile$ID)]
  results$Email2 <- checkfile$Primary.Email[match(ID2, checkfile$ID)]
  
  results$SecondaryEmail1 <- checkfile$Secondary.Email[match(ID1, checkfile$ID)]
  results$SecondaryEmail2 <- checkfile$Secondary.Email[match(ID2, checkfile$ID)]

  results$Department1 <- checkfile$DEPARTMENT[match(ID1, checkfile$ID)]
  results$Department2 <- checkfile$DEPARTMENT[match(ID2, checkfile$ID)]
  
  results$Location1 <- checkfile$Location[match(ID1, checkfile$ID)]
  results$Location2 <- checkfile$Location[match(ID2, checkfile$ID)]
  
  results$Pairs <- interaction(results$Name1, results$Name2)
  
#Create CSV of below
print(results)
write.csv(results, "Newcombination.csv")






