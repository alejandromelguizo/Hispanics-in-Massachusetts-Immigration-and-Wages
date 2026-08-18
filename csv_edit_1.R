#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ALEJANDRO MELGUIZO
# DATE: 8/18/2026
# TOPIC: looking at editing csv to focus on Latinos, and people in Massachusetts
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("C:/Users/A.Melguizo001/Downloads/Immig, Wages, Latinos")
df <- read.csv('econometrics_v_10.csv')

install.packages("reticulate")
reticulate::py_install("pandas")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library(gdata)
library(dplyr)
library(ggplot2)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

df_hisp <- df

#filter to only Hispanics
df_hisp <- df_hisp %>% filter(!is.na(hisp_clean))
df_hisp <- df_hisp %>% filter(hisp_clean > 0)

#filter to just Massachusetts
df_MA <- df_hisp %>% filter(STATEFIP == 25)

df_MA_sum <- df_MA %>% group_by(hisp_clean) %>% summarise(count = n())

#visualization
ggplot(df_MA_sum, aes(x = hisp_clean, y = count)) + 
  geom_bar(stat = "identity")


