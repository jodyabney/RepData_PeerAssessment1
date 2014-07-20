# Peer Assessment Reproducible Research

========================================================

This is an R Markdown document. Markdown is a simple formatting syntax for authoring web pages (click the **Help** toolbar button for more details on using R Markdown).

When you click the **Knit HTML** button a web page will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


```r
## read the activity.csv source data
activity <- read.csv("activity.csv")

## remove the NA step entries from the activity data
cleaned_activity <- activity[complete.cases(activity),]
```

## What is the mean total number of steps taken per day?

### 1. Make a histogram of the total number of steps taken per day


```r
steps_per_day <- c()

## insert the total steps per day data
steps_per_day <- with(cleaned_activity,
                      aggregate(steps,
                                by = list(date),
                                sum
                                )
                      ) # returns "date" and "total steps per day" data

## insert the mean steps per day data
steps_per_day <- cbind(steps_per_day, with(cleaned_activity,
                                           aggregate(steps,
                                                     by = list(date),
                                                     mean
                                                     )
                                           )[2] # return the mean column data
                       )

steps_per_day <- cbind(steps_per_day, with(cleaned_activity,
                                           aggregate(steps,
                                                     by = list(date),
                                                     median
                                                     )
                                           )[2] # return the median column data
                       )

names(steps_per_day) <- c("date", 
                          "total_steps_per_day", 
                          "mean_steps_per_day",
                          "median_steps_per_day"
                          )
head(steps_per_day)
```

```
##         date total_steps_per_day mean_steps_per_day median_steps_per_day
## 1 2012-10-02                 126             0.4375                    0
## 2 2012-10-03               11352            39.4167                    0
## 3 2012-10-04               12116            42.0694                    0
## 4 2012-10-05               13294            46.1597                    0
## 5 2012-10-06               15420            53.5417                    0
## 6 2012-10-07               11015            38.2465                    0
```
   
   

```r
## Plot the histogram of the total number of steps taken each day
with(steps_per_day, hist(total_steps_per_day, 
                               col = "blue", 
                               breaks = 20,
                               main = "Histogram: Total Steps per Day",
                               xlab = "Total Steps",
                               ylab = "Frequency (Number of Days)"
                         )
     )
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-21.png) 

```r
## Barplot version
with(steps_per_day, barplot(total_steps_per_day,
                            names.arg = date,
                            col = "blue",
                            xlab = "Date",
                            ylab = "Total Number of Steps"
                            )
     )
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-22.png) 

### 2. Calculate and report the **mean** and **median** total number of steps taken per day


You can also embed plots, for example:



