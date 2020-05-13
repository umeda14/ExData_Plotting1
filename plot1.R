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

# <plot1.R> : creat hisogram of Global Active Power
png("plot1.png", width = 480, height = 480)
plot1 <- df_nec$Global_active_power
hist(plot1, main = "Global Active Power", xlab= "Global Active Power (kilowatts)", col="blue")
dev.off()
