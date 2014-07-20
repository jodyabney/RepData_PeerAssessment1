Peer Assessment Reproducible Research

========================================================

This is an R Markdown document. Markdown is a simple formatting syntax for authoring web pages (click the **Help** toolbar button for more details on using R Markdown).

When you click the **Knit HTML** button a web page will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


```r
## read the activity.csv source data
activity <- read.csv("activity.csv")

## remove the NA step entries from the activity data
cleaned_activity <- activity[complete.cases(activity), ]
```


Question: What is the mean total number of steps taken per day?
1. Make a histogram of the total number of steps taken per day

```r
### Make a histogram of the total number of steps taken each day
total_steps_per_day <- with(cleaned_activity, aggregate(steps, by = list(date), 
    sum), aggregate(steps, by = list(date), mean))
## Set up the names for total_steps_per_day
names(total_steps_per_day) <- list("date", "total_steps")
head(total_steps_per_day)
```

```
##         date total_steps
## 1 2012-10-02         126
## 2 2012-10-03       11352
## 3 2012-10-04       12116
## 4 2012-10-05       13294
## 5 2012-10-06       15420
## 6 2012-10-07       11015
```

```r

## Plot the histogram of the total number of steps taken each day
with(total_steps_per_day, hist(total_steps, col = "blue"))
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-21.png) 

```r

## Barplot version
barplot(total_steps_per_day$total_steps, names.arg = total_steps_per_day$date, 
    col = "blue", xlab = "Date", ylab = "Total Number of Steps")
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-22.png) 


2. Calculate and report the **mean** and **median** total number of steps taken per day



You can also embed plots, for example:


```r
plot(cars)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 


