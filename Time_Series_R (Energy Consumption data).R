
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








