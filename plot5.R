## Emissions from Coal Combustion for the US
## you have to install data.table package: install.packages("data.table") 
## 5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

library(plyr)
library(ggplot2)
library(data.table)

## This first line will likely take a few seconds. Be patient!

NEI <- readRDS("./exploratory Data Analysis/summarySCC_PM25.rds")
SCC <- readRDS("./exploratory Data Analysis/Source_Classification_Code.rds")

## Convert into data.table
NEI.DT = data.table(NEI)
SCC.DT = data.table(SCC)

motor.vehicle.scc = SCC.DT[grep("[Mm]obile|[Vv]ehicles", EI.Sector), SCC]

## Aggregate Emissions for the above SCC by year and county and filter Baltimore City

motor.vehicle.emissions.baltimore = NEI.DT[SCC %in% motor.vehicle.scc, sum(Emissions), by = c("year", "fips")][fips == "24510"]
colnames(motor.vehicle.emissions.baltimore) <- c("year", "fips", "Emissions")

png(filename = "./exploratory Data Analysis/plot5.png", width = 480, height = 480, units = "px")

##Plot emissions per year using ggplot2 plotting system Emissions from motor vehicle sources decreased from 1999-2008 in Baltimore City, even though there was a blip in the year 2008.

g = ggplot(motor.vehicle.emissions.baltimore, aes(year, Emissions))
g + geom_point(color = "red") + geom_line(color = "green") + labs(x = "Year") + 
    labs(y = expression("Total Emissions, PM"[2.5])) + labs(title = "Total Emissions from Motor Vehicle Sources in Baltimore City")


# Close the PNG device
dev.off()
