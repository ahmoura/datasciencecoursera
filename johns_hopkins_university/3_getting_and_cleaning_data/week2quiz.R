setwd("/home/ahmoura/Documentos/datasciencecoursera/johns_hopkins_university/3_getting_and_cleaning_data")

############

download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile="acs.csv")
acs <- read.csv("acs.csv")

acs

install.packages("sqldf")
library(sqldf)
sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select distinct AGEP from acs")

html_code <- readLines("http://biostat.jhsph.edu/~jleek/contact.html")
c(nchar(html_code[10]), nchar(html_code[20]), nchar(html_code[30]), nchar(html_code[100]))
# 45 31  7 25

html_code <-readLines("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for")
head(html_code)


w <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)
colNames <- c("filler", "week", "filler", "sstNino12", "filler", "sstaNino12", 
              "filler", "sstNino3", "filler", "sstaNino3", "filler", "sstNino34", "filler", 
              "sstaNino34", "filler", "sstNino4", "filler", "sstaNino4")
d <- read.fwf("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", w, header = FALSE, skip = 4, col.names = colNames)
d <- d[, grep("^[^filler]", names(d))]
sum(d[, 4])

d
