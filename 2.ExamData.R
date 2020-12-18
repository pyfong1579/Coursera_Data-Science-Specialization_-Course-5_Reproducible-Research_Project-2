#check for missing values
mean(is.na(data))

# Checking prop dmg. exp
rd <- 4
PDE <- data %>%
  count(PROPDMGEXP, name='PDEcount') %>%
  mutate (PDE_pct = round(100*PDEcount/sum(PDEcount),rd))
#t1 <- tableGrob(PDE, rows = NULL, cols = c("Prop.Dmg.Exp.","Count","%"))

# Checking crop dmg. exp
CDE <- data %>%
  count(CROPDMGEXP, name='CDEcount') %>%
  mutate (CDE_pct = round(100*CDEcount/sum(CDEcount),rd))
#t2 <- tableGrob(CDE, rows = NULL, cols = c("Crop.Dmg.Exp.","Count","%"))

# Printing tables of unique values
kable(list(PDE,CDE), format='pipe', format.args= list(big.mark = ","),
      caption = "Unique values in Property & Crop Damage EXP")#,
#      col.names = list(c("Prop.Dmg.Exp.","Count","%"),c("Prop.Dmg.Exp.","Count","%")))

#combt <- gtable_combine(t1, t2, along=1)
#txt1 <- textGrob("NB: Percentage of erroneous values for property & crop damage EXP is insignificant")
#grid.arrange (combt, txt1, ncol=1, heights= c(5,1),top=textGrob("Unique values in Property & Crop Damage EXP", gp=gpar(fontsize=20)))
#arrangeGrob(grobs=list(t1, t2), top=textGrob("Unique values in Property & Crop Damage EXP", gp=gpar(fontsize=18)))

#### Adjust formats, alignment and bold Caption