setwd("/home/ahmoura/Documentos/datasciencecoursera/johns_hopkins_university/3_getting_and_cleaning_data")

############

download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile="microdata2006.csv")
df <- read.csv("microdata2006.csv")

sum(df$VAL == 24, na.rm = TRUE)
# 53

#############

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", destfile = "NGAP.xlsx")

install.packages("xlsx")
library(xlsx)

dat <- read.xlsx("NGAP.xlsx", sheetIndex=1, colIndex = 7:15, rowIndex = 18:23)
dat
#dat <- read_excel("NGAP.xlsx", col_names = TRUE)
sum(dat$Zip*dat$Ext,na.rm=T)
# 36534720

#############

install.packages("XML")
library(XML)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", destfile = "restaurants.xml")

parsexml_data <- xmlTreeParse("./restaurants.xml", useInternalNodes = TRUE)
root <- xmlRoot(parsexml_data)
rest <- xpathSApply(root,"//zipcode", xmlValue)
sum(rest == 21231)
#127

#############

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "ACS.csv")

install.packages("data.table")
library(data.table)
DT <- fread("ACS.csv")

sapply(split(DT$pwgtp15,DT$SEX),mean)
tapply(DT$pwgtp15,DT$SEX,mean)
mean(DT$pwgtp15,by=DT$SEX)
DT[,mean(pwgtp15),by=SEX]
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)

