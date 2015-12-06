require(data.table)
require(parallel)

# TODO - dl tycho data as part of script

meas <- fread("input/tycho_measles_cities_27Apr2011.txt")

meas_case <- meas[,cases,
  keyby=list(locstate, year, week)
][
  !is.na(locstate) & !is.na(cases) & !is.na(year)
][,
  quarter := ceiling(week / 13)
]

datain <- function(fname) { 
  dis <- sub(".+/","",strsplit(fname,"_")[[1]][1])
  what <- ifelse(grepl("Cases", fname),"cases", "deaths")
  melt(
    fread(fname,skip = 2),
    id.vars=c("YEAR","WEEK"), variable.name = "locstate"
  )[
    value != "-"
  ][,
    list(count=value, outcome=factor(what), disease=factor(dis)), by=list(YEAR, WEEK, locstate)
  ]
}

deaths <- rbindlist(mclapply(dir("input", pattern="*Deaths*", full.names = T), datain))[,
  locstate := factor(sub(", ","-",locstate,fixed=T))
]

cases <- rbindlist(mclapply(dir("input", pattern="*Cases*", full.names = T), datain))[,
  locstate := factor(sub(", ","-",locstate,fixed=T))
]

combo <- rbindlist(list(deaths, cases))
combo[, quarter := ceiling(WEEK / 13) ]

setcolorder(setnames(meas_case[, outcome := factor("cases")][, disease := factor("MEASLES") ],
         old=c('year','week', 'cases'),
         new=c("YEAR","WEEK","count")), names(combo))

alldis <- rbindlist(list(meas_case, combo))

saveRDS(alldis, "all-diseases.rds")
