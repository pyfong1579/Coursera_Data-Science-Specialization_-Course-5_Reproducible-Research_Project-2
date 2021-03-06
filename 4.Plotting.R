# Options for Figures
mytheme <- ttheme_default(base_size=10,
                          core= list(fg_params= list(hjust=0,x=0.1)),
                          colhead= list(fg_params=list(hjust=0, x=0.1)))
top <-5

## Fatalities
fatal <- cleandata %>%
  group_by(EVTYPE) %>%
  summarise(totfatal = sum(FATALITIES)) %>%
  arrange(desc(totfatal)) %>%
  filter(totfatal !=0) %>%
  mutate(pct=round(100*totfatal/sum(totfatal),1)) %>%
  slice_max(totfatal, n=top)

p1f <- ggplot(fatal,aes(x=totfatal, y=reorder(EVTYPE, totfatal)))
p1f <- p1f + geom_col(fill ='red')
p1f <- p1f + labs(title= paste('Fatal (Top',top, '=', sum(fatal$pct),'%)'),
                  y=NULL, x= 'Count')
fatal$totfatal <- format(fatal$totfatal, big.mark=",",core.just= "right")
tb1 <- tableGrob(fatal, theme= mytheme, rows = NULL, cols= c("Event Type","Fatalities","%"))

## Injured
injured <- cleandata %>%
  group_by(EVTYPE) %>%
  summarise(totinjured = sum(INJURIES)) %>%
  arrange(desc(totinjured)) %>%
  filter(totinjured !=0) %>%
  mutate(pct=round(100*totinjured/sum(totinjured),1)) %>%
  slice_max(totinjured,n=top)

p2i <- ggplot(injured, aes(y=reorder(EVTYPE, totinjured), x=totinjured))
p2i <- p2i + geom_col(fill ='orange')
p2i <- p2i + labs(title = paste('Injured (Top',top, '=', sum(fatal$pct),'%)'),
                  y=NULL, x= 'Count')
injured$totinjured <- format(injured$totinjured, big.mark=",",core.just= "right")
tb2 <- tableGrob(injured, theme= mytheme, rows = NULL, cols= c("Event Type","Injured","%"))

grid.arrange(p1f, p2i, tb1, tb2, heights= unit(c(120,80), c("mm", "mm")),
             widths= unit(c(120,120), c("mm", "mm")),
             top= "Weather Events Harmful to Population Health")

PDmg <- cleandata %>%
  group_by(EVTYPE) %>%
  summarise(totPDmg = round(sum(PropDmg)/1e9,3)) %>%
  arrange(desc(totPDmg)) %>%
  filter(totPDmg !=0) %>%
  mutate(pct=round(100*totPDmg/sum(totPDmg),1)) %>%
  slice_max(totPDmg,n=top)

p3p <- ggplot(PDmg, aes(y=reorder(EVTYPE, totPDmg), x= totPDmg))
p3p <- p3p + geom_col(fill ='Purple')
p3p <- p3p + labs(title= paste('Property Damage (Top', top, '=', sum(PDmg$pct),'%)'),
                  y= NULL, x= 'Value ($B)')
PDmg$totPDmg <- format(PDmg$totPDmg, big.mark=",",core.just= "right")
tb3 <- tableGrob(PDmg, theme= mytheme, rows = NULL, cols= c("Event Type","Value ($B)","%"))

## Crop Damage
CDmg <- cleandata %>%
  group_by(EVTYPE) %>%
  summarise(totCDmg = round(sum(CropDmg)/1e9,3)) %>%
  arrange(desc(totCDmg)) %>%
  filter(totCDmg !=0) %>%
  mutate(pct=round(100*totCDmg/sum(totCDmg),1)) %>%
  slice_max(totCDmg,n=top)

p4c <- ggplot(CDmg,aes(y=reorder(EVTYPE, totCDmg), x=totCDmg))
p4c <- p4c + geom_col(fill ='Steel Blue')
p4c <- p4c + labs(title= paste('Crop Damage (Top',top, '=', sum(CDmg$pct),'%)'),
                  y= NULL, x= 'Value ($B)')
CDmg$totCDmg <- format(CDmg$totCDmg, big.mark=",",core.just= "right")
tb4 <- tableGrob(CDmg, theme= mytheme, rows = NULL, cols= c("Event Type","Value ($B)","%"))

grid.arrange(p3p,p4c, tb3, tb4, heights= unit(c(120,80), c("mm", "mm")),
             widths= unit(c(120,120), c("mm", "mm")),
             top= "Weather Events with Damaging Economic Consequences")
