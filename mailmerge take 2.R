
install.packages("RDCOMClient")

library("devtools")
install_github('omegahat/RDCOMClient')

install.packages("RDCOMClient")
install.packages("xtable")
library(RDCOMClient)
library(xtable)

x <- head(mtcars)
y <- print(xtable(x), type="html", print.results=FALSE)

body <- paste0("<html>", y, "</html>")
#wedfrew
OutApp <- COMCreate("Outlook.Application")
outMail = OutApp$CreateItem(0)
outMail[["To"]] = "test@test.com"
outMail[["subject"]] = "TEST EMAIL"
outMail[["HTMLbody"]] = body
outMail$Send()

#How to mail merge
#What's a COM object
library(RDCOMClient)

## init com api

OutApp <- COMCreate("Outlook.Application")

## create an email 

outMail = OutApp$CreateItem(0)

## configure  email parameter 

outMail[["To"]] = "dest@dest.com"
outMail[["subject"]] = "some subject"
outMail[["body"]] = "some body"

## send it               

outMail$Send()




install.packages("devtools", dep = T)
library(devtools)
install_github("rpremraj/mailR")

library(mailR)

send.mail(from = "ardron.w@gmail.com",
          to = c("<ardron.w@gmail.com>", "<inshachaddha@gmail.com>"),
          subject = "DOES THIS WORK",
          body = "BUTTS AND CATS AND BUTTS",
          smtp = list(host.name = "aspmx.l.google.com", port = 25),
          authenticate = FALSE,
          send = TRUE)


send.mail(from = "insha.chaddha@justice.gov.uk",
          to = "insha.chaddha@justice.gov.uk",
          subject = "TESTING",
          body = "TEST", 
          authenticate = TRUE,
          smtp = list(host.name = "smtp.office365.com", port = 587,
                      user.name = "insha.chaddha@justice.gov.uk", passwd = "Glassbottle246", tls = TRUE))
