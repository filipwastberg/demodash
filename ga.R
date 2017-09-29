# Google analytics data

devtools::install_github("Tatvic/RGoogleAnalytics")

#Update the client.id and client.secret from the file you downloaded
library(RGoogleAnalytics)
client.id  <- "112916653416353510329"
client.secret <- ""
token <- Auth(client.id,client.secret)