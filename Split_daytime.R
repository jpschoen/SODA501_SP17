# clear workspace
rm(list=ls())
library(doBy)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#load in data
tw <- read.csv("LA_boundingbox_tw_jan_to_jun.csv", stringsAsFactors=FALSE)        #FDI

#turn to date format to POSIXt and convert to local time
tw$create_time <- strptime(tw$create_time, "%a %b %d %H:%M:%S %z %Y", tz = "America/Los_Angeles")

#strip out day
tw$day <- weekdays(as.Date(tw$create_time))

# collapse tweets
tw$count = 1
counts <- summaryBy(count ~ userid, FUN = sum, data = tw)
# some of the tweets are clearly bots, we drop top tenth of a percent of tweeters.
counts$perday = counts$count.sum/180
count_bottom <- subset(counts, counts$perday<quantile(counts$perday, probs =0.9995))
#dropping .005% of users, but 7% of the tweets

#merge to drop bots
tw_bottom <- merge(tw, count_bottom, by = "userid", all.x =FALSE)
#calculate percentage of datadropped
length(tw_bottom$userid)/length(tw$userid)

# weekend tweets
weekend <- subset(tw_bottom, tw$day=="Saturday" | tw$day=="Sunday")
write.csv(weekend, file = "weekend.csv")

# weekday tweets
weekday<- subset(tw_bottom, tw$day!="Saturday" & tw$day!="Sunday")
write.csv(weekday, file = "weekday.csv")


# plot time distributions
weekday$hours <- weekday$create_time$hour
weekend$hours <- weekend$create_time$hour
par(mfrow=c(1,2))
#weekdays
hist_1 <- hist(weekday$hours)
hist_1$counts <- hist_1$counts/10000/5
#weekends
hist_2 <- hist(weekend$hours)
hist_2$counts <- hist_2$counts/10000/2

#plot together
plot(hist_1, col="lightgray", main = "Weekdays", ylim = c(0,20),
     xlab="Time", ylab = "Tweets per Hour, 10k", xaxt='n')
axis(side=1, at=seq(0,24, 6), labels=seq(0,24, 6))
plot(hist_2, col="lightgray", main = "Weekends", ylim = c(0,20),
     xlab="Time", ylab = "Tweets per Hour, 10k", xaxt='n')
axis(side=1, at=seq(0,24, 6), labels=seq(0,24, 6))




# plot distribution of tweets by user
par(mfrow=c(1,1)) 
hist <- hist(tw_bottom$count.sum, breaks=200)
hist$counts <- hist$counts/1000000
plot(hist, col="lightgray", main = "User Tweets for Six Months",
     xlab="Number of Tweets", ylab = "Users, in Millions")




#subset weekday data
work <- subset(weekday, weekday$hour >=8 & weekday$hour <=17)
home <- subset(weekday, weekday$hour <=7 | weekday$hour >=18)
write.csv(work, file = "work.csv") 
write.csv(home, file = "home.csv")

