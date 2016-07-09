## PM2.5 emission in Baltimore City
## 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question.

library(plyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!

NEI <- readRDS("./exploratory Data Analysis/summarySCC_PM25.rds")
SCC <- readRDS("./exploratory Data Analysis/Source_Classification_Code.rds")

NEI.24510 <- NEI[which(NEI$fips == "24510"), ]
total.emissions.baltimore <- with(NEI.24510, aggregate(Emissions, by = list(year), sum))
colnames(total.emissions.baltimore) <- c("year", "Emissions")

png(filename = "./exploratory Data Analysis/plot2.png", width = 480, height = 480, units = "px")

plot(total.emissions.baltimore$year, total.emissions.baltimore$Emissions, type = "b", 
     pch = 18, col = "green", ylab = "Emissions", xlab = "Year", main = "Baltimore Emissions")

# Close the PNG device
dev.off()