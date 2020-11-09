#Set working directory
setwd("~/OneDrive - University of Oregon/EWEB Meta analysis") #Hilary Rose
setwd() #Sydney

#Load packages
library(metaDigitise)
library(WriteXLS)

#Copy, paste, and modify the script below for each paper

#[author year]----
authoryear <- metaDigitise(dir = "graphs/authoryear") #Gather data
WriteXLS(authoryear, "data/authoryearrawdata.xlsx") #Write data to XL

#Graham 2017----
graham2017 <- metaDigitise(dir = "graphs/graham2017") #Gather data

graham2017

WriteXLS(graham2017, "data/graham2017rawdata.xlsx") #Write data to XL

#Perry 2017----
perry2017 <- metaDigitise(dir = "graphs/perry2017") #Gather data
WriteXLS(perry2017, "data/perry2017rawdata.xlsx") #Write data to XL

#Cairns 2009----
cairns2009 <- metaDigitise(dir = "graphs/cairns2009") #Gather data
WriteXLS(cairns2009, "data/cairns2009rawdata.xlsx") #Write data to XL

#McCreesh 2019----
mccreesh2019 <- metaDigitise(dir = "graphs/mccreesh2019") #Gather data
WriteXLS(cairns2009, "data/cairns2009rawdata.xlsx") #Write data to XL
