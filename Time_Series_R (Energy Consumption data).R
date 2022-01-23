
# Import the dataset 
# Make "Date" variable row names 
ts <- read.csv("C:/Users/azimz/Desktop/Time-Series_R/Time-Series_R/opsd_germany_daily.csv", header = TRUE, row.names = "Date")
# Explore and summarize the data
str(ts)
dim(ts)
summary(ts)
row.names(ts)
ts$Date
head(ts)
tail(ts)

# Access specific data 
# Multiple 
ts[c("2006-01-01", "2006-01-04"), ]

# For visualization purposes we keep "Date" as a column 
tsd <- read.csv("C:/Users/azimz/Desktop/Time-Series_R/Time-Series_R/opsd_germany_daily.csv", header = TRUE)
summary(tsd)
# Correct the data type for Date 
tsd$Date <- as.Date(tsd$Date)

# Create day, month and year columns out of date column 
tsd$day <- as.numeric(format(tsd$Date, "%d"))
tsd$month <- as.numeric(format(tsd$Date, "%m"))
tsd$year <- as.numeric(format(tsd$Date, "%Y"))



# Visualize 
plot(tsd$year, tsd$Consumption, type = "l", xlab = "Year", ylab = "Energy Consumption",
     lty = 1, xlim = c(2006, 2017), ylim = c(800, 1700))

plot(tsd$Consumption, 
     xlim = c(2006, 2017), ylim = c(800, 1700), type = "l",
     xlab = "Year", ylab = "Consumption",
     main = "Energy consumption in Germany")

# use log values of consumption and take differences of log 
plot(10*diff(log(tsd$Consumption)), type = "l", col = "orange", 
     main = "Energy consumption in Germany",
     ylab = "Consumption",
     ylim = c(-5, 5))

# Same plots with another package 
# ggplot plots 

library(ggplot2)

ggplot(data = tsd, aes(x = year, y = Consumption, group = 1))+
  geom_line(linetype = "dashed")+
  geom_point()
ggplot(data = tsd, mapping = aes(x = year, y = Consumption, col = 'red'))+
  geom_point()

# Plot including wind and solar data 

plot(tsd[,1], tsd[,2], type = 'l')
# convert the date column from char to Date format
tsd$Date <- as.Date(tsd$Date, format = "%d-%m-%Y")
# Check  the data class
data.class(tsd$Date)

# Plot maximum consumtion for each year 
# Query the data with SQL (sqldf)

library(sqldf)
mxPerYear <- sqldf("SELECT year AS Year, MAX(Consumption) AS Maximum_Energy_Consumtion FROM tsd GROUP BY year")
mxPerYear

plot(mxPerYear, type = 'b', xlab = "Years", ylab = "Max Energy Consumtion")

# Plot maximum consumtion per month in the year of 2006
Cons2006 <- sqldf("SELECT month AS Month, MAX(Consumption) AS Maximum_Energy_Consumtion FROM tsd WHERE year = 2006 GROUP BY month")
Cons2006

plot(Cons2006, type = 'b', xlab = "Months in 2006", ylab = "Max Energy Consumtion")


Cons2006d <- sqldf("SELECT date AS Date, MAX(Consumption) AS Maximum_Energy_Consumtion FROM tsd WHERE year = 2006 GROUP BY Date")
Cons2006d

plot(Cons2006d, type = 'l', col = "orange")
grid()

# Create a subset of data for only Jan and Feb of 2017 
ts_sub1 <- subset(tsd, subset =  tsd$Date >= "2017-01-01" & tsd$Date <= "2017-02-28")

# Seqsonality analysis
# Visualize the data distribution using Boxplots

boxplot(tsd$Consumption ~ tsd$year, las = 2, cex.names = 0.7)


par(mfrow = c(3, 1))
# Monthly 
boxplot(tsd$Consumption ~ tsd$month, las = 2, cex.names = 0.7, col = 'red')
# Wind
boxplot(tsd$Wind ~ tsd$month, las = 2, cex.names = 0.7, col = 'blue')
# Solar
boxplot(tsd$Solar ~ tsd$month, las = 2, cex.names = 0.7, col = 'yellow')

#Visualize consumption per day of the week 

boxplot(tsd$Consumption ~ tsd$day)

# Day of Week column added to the dataframe 
tsd$dayOfWeek <- weekdays(as.Date(tsd$Date))

boxplot(tsd$Consumption ~ tsd$dayOfWeek, 
        col=c(rgb(0.3,0.1,0.4,0.6) , rgb(0.3,0.5,0.4,0.6)))

# Frequencies 
# Number of records in each column 
# Excluding missing variables 
colSums(!is.na(tsd))
# Number of missing values 
colSums(is.na(tsd))

# Locate the missing values 
library(dplyr)
missed_wind <- tsd[which(is.na(tsd$Wind)), names(tsd)]
head(missed_wind)
































