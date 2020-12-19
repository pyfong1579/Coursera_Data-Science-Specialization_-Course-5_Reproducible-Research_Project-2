library(data.table)
library (knitr)
library(R.utils)
library(dplyr)
library(ggplot2)
library(grid)
library(gridExtra)
library(gtable)

# Download source files from URL into and create download sub-directory on 1st run only.
url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
destfile <- "./download/StormData.csv.bz2"

if(!file.exists("./download/StormData.csv.bz2")) {
  dir.create("./download")  
  download.file(url,destfile=destfile)
}

data <- fread("./download/StormData.csv.bz2")
str(data)

# select required variables
data <- data %>% select(EVTYPE,FATALITIES,INJURIES,PROPDMG,PROPDMGEXP,CROPDMG,CROPDMGEXP)