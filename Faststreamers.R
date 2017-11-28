getwd ()
setwd("/Users/inshachaddha/Documents/Life/Continued Learning/Coding and R")

faststreamers <- read.csv("Coffee-trails.csv")
faststreamers <- (faststreamers[1:89,])

#Create two variables (keeping existing list intact)
demand <- with(faststreamers,rep(NAME.1))
supply <- faststreamers$NAME.2

#Create a randomising tool. One column gets randomised while the other remains the same
randmatch <- function(demand,supply){
  n_demand  <- length(demand)
  n_supply  <- length(supply)
  n_matches <- min(n_demand,n_supply)
  
  if (n_demand >= n_supply) 
data.frame(d=sample(demand,n_matches),s=supply)
  else 
data.frame(d=demand,s=sample(supply,n_matches))

}


#A while loop checks to see if the new combinations have been before and prints only combinations
#Which cannot be found in the existing combo list 'checkvector'
while (!sum(faststreamers$donebefore) == 0) {
  
  randmatch(demand,supply)
  
  matches <- data.frame(randmatch(demand,supply))
  
  faststreamers$combination <- with(matches,interaction(d,s))
  
  faststreamers$combination <- as.character(faststreamers$combination)
  
  faststreamers$donebefore <- faststreamers$combination %in% checkvector
  
  faststreamers[(faststreamers$donebefore == TRUE),"donebefore"] <- 1
  
  print(faststreamers$combination)
}

#The existing combo list 'checkvector' is updated with the new combinations so that the while loop
#works next time.
checkvector <- append(checkvector, faststreamers$combination)
