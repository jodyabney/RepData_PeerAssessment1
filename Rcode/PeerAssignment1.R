# Peer Assessment Reproducible Research

    
## read the activity.csv source data
activity <- read.csv("../data/activity.csv")

## What is the mean total number of steps taken per day?

### 1. Make a histogram of the total number of steps taken per day

#### Aggregate the total steps per day data
steps <- with(activity,
              aggregate(steps,
                        by = list(date),
                        sum
              )
) # returns "date" and "total steps per day" data

## Set up the column names
names(steps) <- c("Date", 
                  "Total.Steps")

# Review the first 5 rows of the aggregated step data
head(steps)


##```{r fig.width=7, fig.height=6}
## Plot the histogram of the total number of steps taken each day
with(steps, 
     hist(Total.Steps, 
          col = "blue", 
          breaks = 30,
          main = "Histogram: Total Steps per Day",
          xlab = "Total Steps",
          ylab = "Frequency (Number of Days)"
     )
)

### 2. Calculate and report the **mean** and **median** total number of steps taken per day

#### Mean of total steps (must ignore NA values)
steps.mean <- mean(steps$Total.Steps, na.rm = TRUE)
print(cat("Mean of Total Steps per Day is", steps.mean))

#### Median of total steps (must ignore NA values)
steps.median <- median(steps$Total.Steps, na.rm = TRUE)
print(cat("Median of Total Steps per Day is", steps.median))


### 3. What is the average daily activity pattern?

#### [1] Make a time series plot (i.e. type = "l") of the 5-minute interval
#### (x-axis) and the average number of steps taken, averaged across all days
#### (y-axis)

##### Imputing missing values

###### Calculate and report the total number of missing values in the dataset
###### (i.e. the total number of rows with NAs)
incomplete <- activity[!(complete.cases(activity)),]
cat("Total number of rows with NAs in the 'activity' dataset:", nrow(incomplete))

###### Strategy for imputing missing values will be to use the mean of the
###### 5-minute interval that corresponds to the NA value

# make a copy of activity without the missing data rows
temp <- activity[!(is.na(activity$steps)),]

missing.mean.5 <- with(temp, 
               aggregate(steps, 
                         by = list(interval), 
                         FUN = mean))
names(missing.mean.5) <- c("interval", "Missing.Mean.Interval")

###### Replace the missing values with the missing.mean.5 value
tidy.activity <- activity

for(i in 1:nrow(tidy.activity)) { #
    if(is.na(tidy.activity$steps[i])) {
        temp.5 <- tidy.activity$interval[i]
        
        ## Calculate the lookup row in missing.mean.5
        for(j in 1:nrow(missing.mean.5)) {
            if(temp.5 == missing.mean.5$interval[j]) {
                tidy.activity$steps[i] <- 
                    missing.mean.5$Missing.Mean.Interval[j]
            }
        }
        #print(cat("i =", i, "missing.mean.5.row =", missing.mean.5.row))
        
    }
}

###########################
# Mmake a histogram of total steps per day based on the tidy.activity dataset
###########################

total.tidy.activity <- with(tidy.activity,
                            aggregate(steps,
                                      by = list(date),
                                      sum
                            )
)
names(total.tidy.activity) <- c("Date", "Total.Steps")

with(total.tidy.activity, 
     hist(Total.Steps, 
          col = "blue", 
          breaks = 30,
          main = "Histogram: Total Steps per Day Based on \"tidy.activity\" Dataset",
          xlab = "Total Steps",
          ylab = "Frequency (Number of Days)"
     )
)

plot(tidy.activity$steps, type = "l")

#### [2] Which 5-minute interval, on average across all the days in the dataset,
#### contains the maximum number of steps?




#### Are there differences in activity patterns between weekdays and weekends?

tidy.activity$Weekday <- weekdays(as.Date(tidy.activity$date))
tidy.activity$Day.Type <- ifelse(weekdays(as.Date(tidy.activity$date)) %in% c("Saturday", "Sunday"), 
                                 "weekend", 
                                 "weekday")







#working area (delete for final submission)
temp <- tidy.activity
temp$Weekday <- weekdays(as.Date(temp$date))
temp$Day.Type <- ifelse(weekdays(as.Date(temp$date)) %in% c("Saturday", "Sunday"), "weekend", "weekday")

mean.5.day.type <- with(temp[!is.na(temp$steps),], 
                        aggregate(steps,
                                  by = list(Day.Type, interval),
                                  FUN = mean))
names(mean.5.day.type) <- c("Day.Type",
                            "Interval",
                            "Mean.Steps")

p <- qplot(x = Interval, 
           y = Mean.Steps, 
           data = mean.5.day.type, 
           facets = . ~ Day.Type,
           geom = "line")
#p <- p + geom_line()
print(p)

q <- ggplot(mean.5.day.type,
            aes(x = Interval, y = Mean.Steps))
q <- q + geom_line()
q <- q + facet_grid(mean.5.day.type$Day.Type ~ .)
print(q)

