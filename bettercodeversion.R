names <- append(faststreamers$NAME.1, faststreamers$NAME.2)

while (!sum(donebefore) == 0) {

sample(names)
setone <- names[1:89]
settwo <- names[90:178]

matches <- data.frame(setone, settwo)
combination <- with(matches, interaction(setone,settwo))
donebefore <- combination %in% checkvector
faststreamers[(faststreamers$donebefore == TRUE),"donebefore"] <- 1

}
print(faststreamers$combination)
checkvector <- append(checkvector, combination)
print(faststreamers)
