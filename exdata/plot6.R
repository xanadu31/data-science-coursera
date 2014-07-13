library(ggplot2)
#Read in data
NEI <- readRDS("exdata/data/summarySCC_PM25.rds")
SCC <- readRDS("exdata/data/Source_Classification_Code.rds")

NEIBaltimore <- NEI[(NEI$fips =="24510" | NEI$fips =="06037") & NEI$type =="ON-ROAD", ]
aggregated <- aggregate(Emissions ~ year + fips, data = NEIBaltimore, FUN = sum)
aggregated$fips <- ifelse(aggregated$fips == "24510", "Baltimeore","LA County")

ggplot(data=aggregated, aes(x=year, y=Emissions)) + geom_bar(stat="identity", width=1) +  facet_wrap(~ fips)