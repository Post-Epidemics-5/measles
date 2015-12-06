## check for all-diseases, if not, run data-agg

require(ggplot2)
require(data.table)

rm(list=ls())
src <- readRDS("all-diseases.rds")

# WANT: for each location, largest slice of years with largest slice of data
# largest means: incorporating most rows of long format

# ... TODO that

availability <- src[outcome =="cases", list(available_count = length(unique(disease))), keyby=list(locstate, YEAR)]

fillyears <- seq(min(availability$YEAR), max(availability$YEAR))
locs <- levels(availability$locstate)
fill <- data.table(expand.grid(locstate=locs, YEAR=fillyears), key=c("locstate","YEAR"))

pltsrc <- availability[fill]

## TODO find better way to show this problem?
partplot <- ggplot(pltsrc) + aes(x = YEAR, y=available_count, group=locstate) +
  geom_step(alpha=0.5) + theme_bw() + labs(x="year",y="# of available diseases")
ggsave("data_availability.png", plot=partplot)



saveRDS(,"partitioned_training.rds")