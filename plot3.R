# downloading the data
if(!file.exists("data.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip")  
}

# unzip the data if file doesn't exist
if(!file.exists("exdata_data_household_power_consumption.txt"))
  unzip("data.zip")

# read the data and adjust the classes
df <- read.csv2("household_power_consumption.txt", header = T,  dec = ".", stringsAsFactors = F,) 
df[,2] <- paste(df[,1], df[,2], sep = "/") 
df[,1] <- list(as.Date((df[,1]), format = "%d/%m/%Y"))
df[,2] <- list(strptime((df[,2]), format = "%d/%m/%Y/%H:%M:%S"))
df[,3:9] <- as.numeric(unlist(df[,3:9]))

# extract the data only from the dates 2007-02-01 and 2007-02-02
df_nec <- subset(df, df$Date == "2007-02-01" |df$Date == "2007-02-02")

# <plot3.R> : creat line graph of Energy submetring of 3 groups along with time
png("plot3.png", width = 480, height = 480)

# 1st line
x_time <- df_nec$Time
y1 <- df_nec$Sub_metering_1
plot(x = x_time, y = y1, xlab= "", ylab= "Energy submetring", ylim = c(0,40), type = "l", col = "red")

# 2nd line
par(new = T)
y2 <- df_nec$Sub_metering_2
plot(x = x_time, y = y2, type = "l", col = "blue", ann = F, ylim = c(0,40))

# 3rd line
par(new = T)
y3 <- df_nec$Sub_metering_3
plot(x = x_time, y= y3, type = "l", col = "green", ann = F, ylim = c(0,40))

# legend 
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("red", "blue", "green"), lty = 1)

dev.off()
