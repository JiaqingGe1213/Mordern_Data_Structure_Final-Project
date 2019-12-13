## code to prepare `USpriceindexes` dataset goes here
library(readr)
library(tidyverse)
library(httr)
library(jsonlite)

#### 1. import data of American price index from csv file
ps_data <- read_csv('data-raw/pricestats_bpp_arg_usa.csv',col_names = T)
# convert date to day,month,year
us_ps_data <- ps_data %>%
  filter(country == 'USA') %>%
  mutate(day = substr(date, start = 1, stop = 2)) %>%
  mutate(month = substr(date, start = 4, stop = 6)) %>%
  mutate(year = substr(date, start = 8, stop = 9))
us_ps_data$year = paste('20',us_ps_data$year,sep = '')# change the year into '20XX' form

#### 2. get the US official CPI data from Bureau of labor statistics
USCPI_query <- list('startyear'= '2008', 'endyear'='2015', "registrationkey" = Sys.getenv("BLS_TOKEN"))
USCPI_json <- GET('https://api.bls.gov/publicAPI/v2/timeseries/data/CUUR0000SA0', query = USCPI_query)
USCPI_txt <- content(USCPI_json, as = 'text')
USCPI <- fromJSON(USCPI_txt, simplifyDataFrame = TRUE)
CPI_official <- USCPI$Results$ series$ data[[1]]
CPI_official$month <- substr(CPI_official$periodName, start = 1, stop = 3) # change the month form to the ones from us_ps_dat
CPI_base <- CPI_official %>%
  filter(year == '2008', period == 'M07') %>%
  select(value)
CPI_official$CPI = as.numeric(CPI_official$value)/as.numeric(CPI_base$value[1])*100 # change the base month of the CPI to 2008.07
CPI_official <- CPI_official %>%
  mutate(inflation_CPI = (CPI/lead(CPI) - 1) * 100)

#### 3. left outer join the price index of 'billion price project' with official CPI data.
US_price_indexes <- merge(x = us_ps_data, y = CPI_official, by = c('year','month'), all.x = TRUE)
US_price_indexes <- subset(US_price_indexes, select = -c(cid,periodName,footnotes,value)) # drop the duplicate columns
US_price_indexes <- US_price_indexes[order(as.Date(US_price_indexes$date, format="%d-%b-%y")),] # sort the data by date
US_price_month <- US_price_indexes %>%
  select(month,year,CPI, inflation_CPI,indexPS,period) %>%
  group_by(year,period, month) %>%
  summarise(PS_month = mean(indexPS),CPI = mean(CPI),inflation_CPI = mean(inflation_CPI))
US_price_month <- US_price_month %>%
  ungroup(year) %>%
  mutate(inflation_PS = (PS_month/lag(PS_month) - 1) * 100) %>%
  mutate(mdate = as.Date(paste(year,month,'01',sep= '-'),format="%Y-%b-%d"))
US_price_month <- as.data.frame(US_price_month)
write_csv(US_price_month, "data-raw/US_price_month.csv")
usethis::use_data(US_price_month, overwrite = T)
