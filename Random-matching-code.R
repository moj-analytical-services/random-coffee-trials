
#Always do this bit for stringr
install.packages("stringr")
library(stringr)
install.packages("sprintf")

#Reload this whenever you update
name_data <- read.csv("FSNAMES.csv")
name_data <- name_data[!name_data$NAME.1=="",]

name_data$NAME.1 <- as.character(name_data$NAME.1)
name_data$Primary.Email <- as.character(name_data$Primary.Email)

#This step is to give everyone a unique ID (I matched by IDs not names)
name_data$ID <- seq.int(nrow(name_data))

#Check if odd or even numbers of participants. We decided that if there were odd numbers, we would remove Tom
is.even <- function(x) x %% 2 == 0
even <- is.even(length(name_data$NAME.1))
if (even == FALSE) {
 name_data <- name_data[ ! (name_data$NAME.1 == "Thomas Grant") , ]
}
length(name_data$NAME.1)

#Load all the combinations done previously
existingcombinations <- read.csv("Existingcombinations.csv")

#Check to make sure all names match up from old combos to full FS database
consistencycheck <- setdiff(existingcombinations$NAME.1, name_data$NAME.1)
print(consistencycheck)
consistencycheck2 <- setdiff(existingcombinations$NAME.2, name_data$NAME.1)
print(consistencycheck)

#This is to make a single vector of the existing combinations by just joining them with (Dot) in between
existing1 <- name_data$ID[match(existingcombinations$NAME.1, name_data$NAME.1)]
existing2 <- name_data$ID[match(existingcombinations$NAME.2, name_data$NAME.1)]
comb_verify <- as.character((interaction(existing1, existing2)))


#RUN BELOW- This is the random matching code
donebefore <- rep(1, 26)
while (sum(donebefore) > 0 && sum(closeby) > 0) {

  randomised <- sample(name_data$ID)
    setone <- randomised[1:(length(randomised)/2)]
    settwo <- randomised[(length(randomised)/2 + 1) : length(randomised)]

  matches <- data.frame(setone, settwo)
    combination <- as.character(with(matches, interaction(setone,settwo)))
    combinationreverse <- as.character(with(matches, interaction(settwo,setone)))
  
  donebefore <- (append(combination %in% comb_verify, combinationreverse %in% comb_verify))*1
  
}

#This bit needs editing. I prefer to update existing combos manually to prevent errors in testing
comb_verify <- append(comb_verify, combination)
print(combination)
print(comb_verify)

#Creating CSV of results, pretty

ID1 <- str_extract(combination, "[^.]+")
ID2 <- str_extract(combination, "[^.]*$")

results <- data.frame(matrix(ncol = 11, nrow = length(name_data$NAME.1)/2))
x <- c("Pairs", "Name1", "Email1", "SecondaryEmail1", "Department1", 
       "Location1", "Name2", "Email2", "SecondaryEmail2", "Department2", "Location2")
colnames(results) <- x

  results$Name1 <- name_data$NAME.1[match(ID1, name_data$ID)]
  results$Name2 <- name_data$NAME.1[match(ID2, name_data$ID)]

  results$Email1 <- name_data$Primary.Email[match(ID1, name_data$ID)]
  results$Email2 <- name_data$Primary.Email[match(ID2, name_data$ID)]
  
  results$SecondaryEmail1 <- name_data$Secondary.Email[match(ID1, name_data$ID)]
  results$SecondaryEmail2 <- name_data$Secondary.Email[match(ID2, name_data$ID)]

  results$Department1 <- name_data$DEPARTMENT[match(ID1, name_data$ID)]
  results$Department2 <- name_data$DEPARTMENT[match(ID2, name_data$ID)]
  
  results$Location1 <- name_data$Location[match(ID1, name_data$ID)]
  results$Location2 <- name_data$Location[match(ID2, name_data$ID)]
  
  results$Pairs <- interaction(results$Name1, results$Name2)
  
#Create CSV of below
print(results)
write.csv(results, "Newcombination.csv")






