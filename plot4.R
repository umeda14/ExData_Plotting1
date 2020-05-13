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

# <plot4.R> : creat multiple graphs
png("pot4.png", width = 480, height = 480)
split.screen(figs = c(2,2))

#upper left screen
screen(1)
x1 <- df_nec$Time
y1 <- df_nec$Global_active_power
plot(x = x1, y = y1, xlab= "", ylab= "Global Active Power", type = "l")

#upper right screen
screen(2)
x2 <- df_nec$Time
y2 <- df_nec$Voltage
plot(x = x2, y = y2, xlab= "Date/Time", ylab= "Voltage", type = "l")

#lower left screen
screen(3)
x_time <- df_nec$Time
y1_1 <- df_nec$Sub_metering_1
plot(x = x_time, y = y1_1,  ylim = c(0,40), ann = F, type = "l", col = "red")

par(new = T)
y2_1 <- df_nec$Sub_metering_2
plot(x = x_time, y = y2_1, ylim = c(0,40), ann = F, type = "l", col = "blue" )

par(new = T)
y3_1 <- df_nec$Sub_metering_3
plot(x = x_time, y= y3_1, xlab = "", ylab= "Energy sub metering", type = "l", col = "green",  ylim = c(0,40))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.5, bty = "n", col = c("red", "blue", "green"), lty = 1)

#lower right screen
screen(4)
x4 <- df_nec$Time
y4 <- df_nec$Global_reactive_power
plot(x = x4, y = y4, xlab= "Date/Time", ylab= "Global reactive power", type = "l")

dev.off()
