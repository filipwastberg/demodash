# Randomiserad undersökningsdata
dates <- as.Date(c("2017-01-01", "2017-02-01", "2017-03-01",
                   "2017-04-01", "2017-05-01", "2017-06-01",
                   "2017-07-01", "2017-08-01", "2017-09-01",
                   "2017-10-01", "2017-11-01", "2017-12-01"))


data <- data.frame(
  fortro = c(sample(c(1:5), 12000, replace = TRUE)),
  inst = c(sample(c(1:5), 12000, replace = TRUE)),
  kampanj = c(sample(c(1:5), 12000, replace = TRUE)),
  kon = c(sample(c(1:2), 12000, replace = TRUE)),
  alder = c(sample(c(18:89), 12000, replace = TRUE)),
  geografi = c(sample(c(1,2,3), 12000, replace = TRUE)),
  date = c(sample(dates, 12000, replace = TRUE))
)

# Bearbetning av rådata till summerad tidy data
library(dplyr)
library(tidyr)
fortro_tot <- data %>%
  group_by(date) %>%
  summarise(Samtliga = sum(fortro %in% c(4,5))/n())

fortro_kon <- data %>%
  group_by(date, kon) %>%
  summarise(fortro = sum(fortro %in% c(4,5))/n()) %>%
  spread(kon, fortro) %>%
  rename("Män" = `1`, "Kvinnor" = `2`) %>%
  as.data.frame()

fortro_geografi <- data %>%
  group_by(date, geografi) %>%
  summarise(fortro = sum(fortro %in% c(4,5))/n()) %>%
  spread(geografi, fortro) %>%
  rename("Storstad" = `1`, "Medelstor stad" = `2`,
         "Övriga landet" = `3`) %>%
  as.data.frame()

nedbrytningar <- full_join(fortro_kon, fortro_geografi)

fortro <- full_join(fortro_tot,
                    nedbrytningar,
                    by = c("date")) %>%
  gather(nedbrytning, fortro, -date)

rm(fortro_geografi, fortro_kon, 
   fortro_tot, nedbrytningar, dates)

## Hantering av data från meltwater
library(readr)
mltwater <- read_csv("resia_meltwater.csv") %>%
  gather(typ, Antal, -date)


