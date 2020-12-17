# Replace erroneous values of Property & Crop Damages EXP. & calculate Damage Values in single variable.

## Cleaning prop dmg. exp
data$PROPDMGEXP <- gsub("[^[:alnum:]]","",data$PROPDMGEXP)
data <-data %>%
  mutate(PROPDMGEXP = toupper(PROPDMGEXP)) %>%
  mutate(PROPDMGEXP = replace(PROPDMGEXP,PROPDMGEXP=="",0)) %>%
  mutate(PROPDMGEXP = replace(PROPDMGEXP,PROPDMGEXP=='H', 100)) %>%
  mutate(PROPDMGEXP = replace(PROPDMGEXP,PROPDMGEXP=='K', 1000)) %>%
  mutate(PROPDMGEXP = replace(PROPDMGEXP,PROPDMGEXP=='M', 1000000)) %>%
  mutate(PROPDMGEXP = replace(PROPDMGEXP,PROPDMGEXP=='B', 1000000000)) %>%
  mutate(PROPDMGEXP = as.double(PROPDMGEXP,na.rm=T))

## Cleaning crop dmg. exp
data$CROPDMGEXP <- gsub("[^[:alnum:]]","",data$CROPDMGEXP)
data <-data %>%
  mutate(CROPDMGEXP = toupper(CROPDMGEXP)) %>%
  mutate(CROPDMGEXP = replace(CROPDMGEXP,CROPDMGEXP=="",0)) %>%
  mutate(CROPDMGEXP = replace(CROPDMGEXP,CROPDMGEXP=='H', 100)) %>%
  mutate(CROPDMGEXP = replace(CROPDMGEXP,CROPDMGEXP=='K', 1000)) %>%
  mutate(CROPDMGEXP = replace(CROPDMGEXP,CROPDMGEXP=='M', 1000000)) %>%
  mutate(CROPDMGEXP = replace(CROPDMGEXP,CROPDMGEXP=='B', 1000000000)) %>%
  mutate(CROPDMGEXP = as.double(CROPDMGEXP,na.rm=T))

## Calculating Damage Values
cleandata <-  data %>%
  mutate(PropDmg = PROPDMG*PROPDMGEXP) %>%
  mutate(CropDmg = CROPDMG*CROPDMGEXP) %>%
  select("EVTYPE", "FATALITIES", "INJURIES", "PropDmg", "CropDmg" )
