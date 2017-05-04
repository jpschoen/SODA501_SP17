# clear workspace
rm(list=ls())

set.seed(19)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#load in data
home <- read.csv("home_stat_tra.csv", stringsAsFactors=FALSE)  
work <- read.csv("work_stat_tra.csv", stringsAsFactors=FALSE)  


par(mfrow=c(2,2))
# regression Home
home_fit1 <- lm(log(lodes_home+1) ~ log(tweets_home+1), data=home)
summary(home_fit1)
plot(log(home$lodes_home), log(home$tweets_home), xlab = "Lodes, Home", ylab = "Tweets, Home", main = "Tweets, Home")


home_fit2 <- lm(log(lodes_home+1) ~ log(user_home+1), data=home)
summary(home_fit2)
plot(log(home$lodes_home), log(home$user_home), xlab = "Lodes, Home", ylab = "User, Home", main = "Modal Location, Home")


# regression Work
work_fit1 <- lm(log(lodes_work+1) ~ log(tweets_work+1), data=work)
summary(work_fit1)
plot(log(work$lodes_work), log(work$tweets_work), xlab = "Lodes, Work", ylab = "Tweets, Work", main = "Tweets, Work")


work_fit2 <- lm(log(lodes_work+1) ~ log(user_work+1), data=work)
summary(work_fit2)
plot(log(work$lodes_work), log(work$user_work), xlab = "Lodes, Work", ylab = "User, Work", main = "Modal Location, Work")



library(stargazer)

stargazer(home_fit1, home_fit2, work_fit1, work_fit2)



