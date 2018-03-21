library(tidyverse)
library(lubridate)
library(ggplot2)
library(data.table)
library(dplyr)

files06q1 <- dir("C:/Users/Shellee/Desktop/WOW/WoWAH/2006_01_03", recursive=TRUE, full.names=TRUE, pattern="\\.txt$")
files06q2 <- dir("C:/Users/Shellee/Desktop/WOW/WoWAH/2006_04_06", recursive=TRUE, full.names=TRUE, pattern="\\.txt$")
files06q3 <- dir("C:/Users/Shellee/Desktop/WOW/WoWAH/2006_07_09", recursive=TRUE, full.names=TRUE, pattern="\\.txt$")
files06q4 <- dir("C:/Users/Shellee/Desktop/WOW/WoWAH/2006_10_12", recursive=TRUE, full.names=TRUE, pattern="\\.txt$")

files07q1 <- dir("C:/Users/Shellee/Desktop/WOW/WoWAH/2007_01_03", recursive=TRUE, full.names=TRUE, pattern="\\.txt$")
files07q2 <- dir("C:/Users/Shellee/Desktop/WOW/WoWAH/2007_04_06", recursive=TRUE, full.names=TRUE, pattern="\\.txt$")
files07q3 <- dir("C:/Users/Shellee/Desktop/WOW/WoWAH/2007_07_09", recursive=TRUE, full.names=TRUE, pattern="\\.txt$")
files07q4 <- dir("C:/Users/Shellee/Desktop/WOW/WoWAH/2007_10_12", recursive=TRUE, full.names=TRUE, pattern="\\.txt$")

files08q1 <- dir("C:/Users/Shellee/Desktop/WOW/WoWAH/2008_01_03", recursive=TRUE, full.names=TRUE, pattern="\\.txt$")
files08q2 <- dir("C:/Users/Shellee/Desktop/WOW/WoWAH/2008_04_06", recursive=TRUE, full.names=TRUE, pattern="\\.txt$")
files08q3 <- dir("C:/Users/Shellee/Desktop/WOW/WoWAH/2008_07_09", recursive=TRUE, full.names=TRUE, pattern="\\.txt$")
files08q4 <- dir("C:/Users/Shellee/Desktop/WOW/WoWAH/2008_10_12", recursive=TRUE, full.names=TRUE, pattern="\\.txt$")



class<-c("NULL", "character", "character", "character", "character", "numeric", "character","character","character", "NULL", "NULL", "NULL")
vars<-c("NULL","time", "seq", "ID", "guild", "level", "race", "class", "zone", "NULL", "NULL", "NULL")
w6q1<-do.call(rbind,lapply(files06q1, function(x){read.csv(x, quote="", skip=2, col.names=vars,colClasses=class, na.strings=c("NA"," ", "", "<NA>"))}))
w6q2<-do.call(rbind,lapply(files06q2, function(x){read.csv(x, quote="", skip=2, col.names=vars,colClasses=class, na.strings=c("NA"," ", "", "<NA>"))}))
w6q3<-do.call(rbind,lapply(files06q3, function(x){read.csv(x, quote="", skip=2, col.names=vars,colClasses=class, na.strings=c("NA"," ", "", "<NA>"))}))
w6q4<-do.call(rbind,lapply(files06q4, function(x){read.csv(x, quote="", skip=2, col.names=vars,colClasses=class, na.strings=c("NA"," ", "", "<NA>"))}))

w7q1<-do.call(rbind,lapply(files07q1, function(x){read.csv(x, quote="", skip=2, col.names=vars,colClasses=class, na.strings=c("NA"," ", "", "<NA>"))}))
w7q2<-do.call(rbind,lapply(files07q2, function(x){read.csv(x, quote="", skip=2, col.names=vars,colClasses=class, na.strings=c("NA"," ", "", "<NA>"))}))
w7q3<-do.call(rbind,lapply(files07q3, function(x){read.csv(x, quote="", skip=2, col.names=vars,colClasses=class, na.strings=c("NA"," ", "", "<NA>"))}))
w7q4<-do.call(rbind,lapply(files07q4, function(x){read.csv(x, quote="", skip=2, col.names=vars,colClasses=class, na.strings=c("NA"," ", "", "<NA>"))}))

w8q1<-do.call(rbind,lapply(files06q1, function(x){read.csv(x, quote="", skip=2, col.names=vars,colClasses=class, na.strings=c("NA"," ", "", "<NA>"))}))
w8q2<-do.call(rbind,lapply(files06q2, function(x){read.csv(x, quote="", skip=2, col.names=vars,colClasses=class, na.strings=c("NA"," ", "", "<NA>"))}))
w8q3<-do.call(rbind,lapply(files06q3, function(x){read.csv(x, quote="", skip=2, col.names=vars,colClasses=class, na.strings=c("NA"," ", "", "<NA>"))}))
w8q4<-do.call(rbind,lapply(files06q4, function(x){read.csv(x, quote="", skip=2, col.names=vars,colClasses=class, na.strings=c("NA"," ", "", "<NA>"))}))

w6q1<-w6q1[!is.na(w6q1$race),]
w6q2<-w6q2[!is.na(w6q2$race),]
w6q3<-w6q3[!is.na(w6q3$race),]
w6q4<-w6q4[!is.na(w6q4$race),]

w7q1<-w7q1[!is.na(w7q1$race),]
w7q2<-w7q2[!is.na(w7q2$race),]
w7q3<-w7q3[!is.na(w7q3$race),]
w7q4<-w7q4[!is.na(w7q4$race),]

w8q1<-w8q1[!is.na(w8q1$race),]
w8q2<-w8q2[!is.na(w8q2$race),]
w8q3<-w8q3[!is.na(w8q3$race),]
w8q4<-w8q4[!is.na(w8q4$race),]

fwrite(w6q1,"C:/Users/Shellee/Desktop/WOW/WoWAH/w6q1.txt",quote=FALSE,sep=",",row.names=FALSE,col.names=TRUE,append=FALSE);
fwrite(w6q2,"C:/Users/Shellee/Desktop/WOW/WoWAH/w6q2.txt",quote=FALSE,sep=",",row.names=FALSE,col.names=TRUE,append=FALSE);
fwrite(w6q3,"C:/Users/Shellee/Desktop/WOW/WoWAH/w6q3.txt",quote=FALSE,sep=",",row.names=FALSE,col.names=TRUE,append=FALSE);
fwrite(w6q4,"C:/Users/Shellee/Desktop/WOW/WoWAH/w6q4.txt",quote=FALSE,sep=",",row.names=FALSE,col.names=TRUE,append=FALSE);

fwrite(w7q1,"C:/Users/Shellee/Desktop/WOW/WoWAH/w7q1.txt",quote=FALSE,sep=",",row.names=FALSE,col.names=TRUE,append=FALSE);
fwrite(w7q2,"C:/Users/Shellee/Desktop/WOW/WoWAH/w7q2.txt",quote=FALSE,sep=",",row.names=FALSE,col.names=TRUE,append=FALSE);
fwrite(w7q3,"C:/Users/Shellee/Desktop/WOW/WoWAH/w7q3.txt",quote=FALSE,sep=",",row.names=FALSE,col.names=TRUE,append=FALSE);
fwrite(w7q4,"C:/Users/Shellee/Desktop/WOW/WoWAH/w7q4.txt",quote=FALSE,sep=",",row.names=FALSE,col.names=TRUE,append=FALSE);

fwrite(w8q1,"C:/Users/Shellee/Desktop/WOW/WoWAH/w8q1.txt",quote=FALSE,sep=",",row.names=FALSE,col.names=TRUE,append=FALSE);
fwrite(w8q2,"C:/Users/Shellee/Desktop/WOW/WoWAH/w8q2.txt",quote=FALSE,sep=",",row.names=FALSE,col.names=TRUE,append=FALSE);
fwrite(w8q3,"C:/Users/Shellee/Desktop/WOW/WoWAH/w8q3.txt",quote=FALSE,sep=",",row.names=FALSE,col.names=TRUE,append=FALSE);
fwrite(w8q4,"C:/Users/Shellee/Desktop/WOW/WoWAH/w8q4.txt",quote=FALSE,sep=",",row.names=FALSE,col.names=TRUE,append=FALSE);