# Replace erroneous values of Property & Crop Damages EXP.

## Cleaning prop & crop dmg. exp
data$PROPDMGEXP <- gsub("[^[:alnum:]]","",data$PROPDMGEXP)
data$CROPDMGEXP <- gsub("[^[:alnum:]]","",data$CROPDMGEXP)
data <-data %>%
  mutate(PROPDMGEXP = toupper(PROPDMGEXP),CROPDMGEXP = toupper(CROPDMGEXP)) %>%
  mutate(PROPDMGEXP = replace(PROPDMGEXP,PROPDMGEXP=="",0),
         CROPDMGEXP = replace(CROPDMGEXP,CROPDMGEXP=="",0)) %>%
  mutate(PROPDMGEXP = replace(PROPDMGEXP,PROPDMGEXP=='H', 100),
         CROPDMGEXP = replace(CROPDMGEXP,CROPDMGEXP=='H', 100)) %>%
  mutate(PROPDMGEXP = replace(PROPDMGEXP,PROPDMGEXP=='K', 1000),
         CROPDMGEXP = replace(CROPDMGEXP,CROPDMGEXP=='K', 1000)) %>%
  mutate(PROPDMGEXP = replace(PROPDMGEXP,PROPDMGEXP=='M', 1000000),
         CROPDMGEXP = replace(CROPDMGEXP,CROPDMGEXP=='M', 1000000)) %>%
  mutate(PROPDMGEXP = replace(PROPDMGEXP,PROPDMGEXP=='B', 1000000000),
         CROPDMGEXP = replace(CROPDMGEXP,CROPDMGEXP=='B', 1000000000)) %>%
  mutate(PROPDMGEXP = as.double(PROPDMGEXP),CROPDMGEXP = as.double(CROPDMGEXP))

## Calculating Damage Values and combining into new variables.
cleandata <-  data %>%
  mutate(PropDmg = PROPDMG*PROPDMGEXP, CropDmg = CROPDMG*CROPDMGEXP) %>%
  select("EVTYPE", "FATALITIES", "INJURIES", "PropDmg", "CropDmg" )
head(cleandata)
