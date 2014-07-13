library(ggplot2)
#Read in data
NEI <- readRDS("exdata/data/summarySCC_PM25.rds")
SCC <- readRDS("exdata/data/Source_Classification_Code.rds")

NEIBaltimore <- NEI[NEI$fips =="24510", NEI$type="ON-ROAD", ]
aggregated <- aggregate(Emissions ~ year, data = NEIBaltimore, FUN = sum)

barplot(aggregated$Emissions, aggregated$year, names.arg=aggregated$year, legend.text="PM2.5 Emissions in Baltimore for motor vehicle sources")