
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

send.mail(from = "inshachaddha@gmail.com",
          to = c("Recipient 1 <inshachaddha@gmail.com>"),
          subject = "Subject of the email",
          body = "Body of the email",
          smtp = list(host.name = "aspmx.l.google.com", port = 25),
          authenticate = FALSE,
          send = TRUE)

