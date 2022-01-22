
# Import the dataset 
# Make "Date" variable row names 
ts <- read.csv("C:/Users/azimz/Desktop/Time-Series_R/opsd_germany_daily.csv", header = TRUE, row.names = "Date")
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
tsd <- read.csv("C:/Users/azimz/Desktop/Time-Series_R/opsd_germany_daily.csv", header = TRUE)
summary(tsd)
# Correct the data type for Date 
tsd$Date <- as.Date(tsd$Date)

# Create day, month and year columns out of date column 
tsd$day <- as.numeric(format(tsd$Date, "%d"))
tsd$month <- as.numeric(format(tsd$Date, "%m"))
tsd$year <- as.numeric(format(tsd$Date, "%y"))

head(sample(tsd, 8))

# Visualize 
plot(tsd$year, tsd$Consumption, type = "l", xlab = "Year", ylab = "Energy Consumption")










