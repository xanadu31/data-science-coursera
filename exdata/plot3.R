library(ggplot2)
#Read in data
NEI <- readRDS("exdata/data/summarySCC_PM25.rds")
SCC <- readRDS("exdata/data/Source_Classification_Code.rds")

NEIBaltimore <- NEI[NEI$fips =="24510", ]
aggregated <- aggregate(Emissions ~ year + type, data = NEIBaltimore, FUN = sum)

ggplot(data=aggregated, aes(x=year, y=Emissions)) + geom_bar(stat="identity", width=1) +  facet_wrap(~ type)