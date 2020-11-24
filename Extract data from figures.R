#You can now watch a video on how to metaDigitise: https://vimeo.com/manage/483279690
#Load packages
library(metaDigitise)
library(WriteXLS)

#Note that metaDigitise does *NOT* work in R Studio. Use R instead. 

#Where possible, download the original figure from the publisher 
#(try visiting the DOI to find this—type in doi.org/ followed by the DOI referenced on the paper). 
#If this isn’t possible, expand the PDF until the graph fills your screen. 
#Use a screenshot to save an image of the graph (cmd+shift+4 on a Mac, Clipping Tool on PC). 
#Repeat with all the graphs that need extracting in this paper. Save each image as author_year_fig#.png.
#Create a folder called [authoryear] and place all the figures into this folder.

#Write down the sampling replicates for each grouping on each graph.

#Copy, paste, and modify the script below for each paper

#Collect data
authoryear <- metaDigitise(dir = "authoryearfolder")

#metaDigitise will walk you through the steps you need to collect the data.
#Expand your plot viewer as large as you can for greater accuracy. 
#Don’t be afraid to play around with this—you can always try again. 
#Hit esc to abort the program.
#If you end up in a muddle, open the subfolder with the graph images and delete the caldat folder to remove the metaDigitise data.

#Export the data to Excel when you are finished to clean them.
WriteXLS(authoryear, "data/authoryearrawdata.xlsx") #Write data to XL
