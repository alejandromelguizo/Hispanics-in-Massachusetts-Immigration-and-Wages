#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ALEJANDRO MELGUIZO
# DATE: 8/18/2026
# TOPIC: beginning Gaston project
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("C:/Users/A.Melguizo001/Downloads/Immig, Wages, Latinos")
df <- read.csv('cps_00003.csv')

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library(gdata)
library(dplyr)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#creating the list of vars we want to keep
vars <- c('YEAR', 'AGE', 'SEX', 'RACE', 'BPL', 'YRIMMIG', 'NATIVITY', 'HISPAN', 
          'EDUC', 'REGION', 'STATEFIP', 'CITIZEN', 'INCTOT', 
          'EMPSTAT', 'UHRSWORKT', 'INCWAGE')

#filtering the data by those selected vars
df1 <- df[, names(df) %in% vars]

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#CLEANING VARS - 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#further filtering age to be between 25 and 65 years old
df1 <- df1 %>% filter(AGE >= 25 & AGE <=65)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#filtering out INCTOT <= 0
df1 <- df1 %>% filter(INCTOT > 0)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#create a variable for the year of birth to later calculate age at immigration
df1$YEAROFBIRTH <- df1$YEAR - df1$AGE

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#creating a var with the actual years of immig
df1 <- df1 %>%
  mutate(yrimmig_clean = case_when(
    YRIMMIG == 0000 ~ NA_real_,        # NIU
    YRIMMIG == 0001 ~ 1949,            # 1949 or earlier
    YRIMMIG == 0002 ~ 1954,            # 1950-1959
    YRIMMIG == 0003 ~ 1962,            # 1960-1964
    YRIMMIG == 0004 ~ 1967,            # 1965-1969
    YRIMMIG == 0005 ~ 1972,            # 1970-1974
    YRIMMIG == 0006 ~ 1977,            # 1975-1979
    YRIMMIG == 0007 ~ 1980,            # 1980-1981
    YRIMMIG == 0008 ~ 1982,            # 1982-1983
    YRIMMIG == 0009 ~ 1984,            # 1984-1985
    YRIMMIG == 0010 ~ 1986,            # 1986-1987
    YRIMMIG == 0011 ~ 1988,            # 1988-1989
    YRIMMIG == 0012 ~ 1990,            # 1990-1991
    YRIMMIG == 0013 ~ 1992,            # 1992-1993
    YRIMMIG == 0014 ~ 1993,            # 1992-1994
    YRIMMIG == 0015 ~ 1993,            # 1992-1995
    YRIMMIG == 0016 ~ 1994,            # 1994-1995
    YRIMMIG == 0017 ~ 1995,            # 1994-1996
    YRIMMIG == 0018 ~ 1995,            # 1994-1997
    YRIMMIG == 0019 ~ 1996,            # 1996-1997
    YRIMMIG == 0020 ~ 1997,            # 1996-1998
    YRIMMIG == 0021 ~ 1997,            # 1996-1999
    YRIMMIG == 0022 ~ 1998,            # 1998
    YRIMMIG == 0023 ~ 1998,            # 1998-1999
    YRIMMIG == 0024 ~ 1999,            # 1998-2000
    YRIMMIG == 0025 ~ 1999,            # 1998-2001
    YRIMMIG == 0026 ~ 2000,            # 2000-2001
    YRIMMIG == 0027 ~ 2001,            # 2000-2002
    YRIMMIG == 0028 ~ 2001,            # 2000-2003
    YRIMMIG == 0029 ~ 2002,            # 2002-2003
    YRIMMIG == 0030 ~ 2003,            # 2002-2004
    YRIMMIG == 0031 ~ 2003,            # 2002-2005
    YRIMMIG == 0032 ~ 2004,            # 2004-2005
    YRIMMIG == 0033 ~ 2005,            # 2004-2006
    YRIMMIG == 0034 ~ 2005,            # 2004-2007
    YRIMMIG == 0035 ~ 2006,            # 2006-2007
    YRIMMIG == 0036 ~ 2007,            # 2006-2008
    YRIMMIG == 0037 ~ 2007,            # 2006-2009
    YRIMMIG == 0038 ~ 2008,            # 2008-2009
    YRIMMIG == 0039 ~ 2009,            # 2008-2010
    YRIMMIG == 0040 ~ 2009,            # 2008-2011
    YRIMMIG == 0041 ~ 2010,            # 2010-2011
    YRIMMIG == 0042 ~ 2011,            # 2010-2012
    YRIMMIG == 0043 ~ 2011,            # 2010-2013
    YRIMMIG == 0044 ~ 2012,            # 2012-2013
    YRIMMIG == 0045 ~ 2013,            # 2012-2014
    YRIMMIG == 0046 ~ 2013,            # 2012-2015
    YRIMMIG == 0047 ~ 2014,            # 2014-2015
    YRIMMIG == 0048 ~ 2015,            # 2014-2016
    YRIMMIG == 0049 ~ 2015,            # 2014-2017
    YRIMMIG == 0050 ~ 2016,            # 2016-2017
    YRIMMIG == 0051 ~ 2017,            # 2016-2018
    YRIMMIG == 0052 ~ 2017,            # 2016-2019
    YRIMMIG == 0053 ~ 2018,            # 2018-2019
    YRIMMIG == 0054 ~ 2019,            # 2018-2020
    YRIMMIG == 0055 ~ 2019,            # 2018-2021
    YRIMMIG == 0056 ~ 2020,            # 2020-2021
    YRIMMIG == 0057 ~ 2021,            # 2020-2022
    YRIMMIG == 0058 ~ 2022,            # 2020-2023
    YRIMMIG == 0059 ~ 2023,            # 2022-2023
    YRIMMIG == 0060 ~ 2024,            # 2022-2024
    YRIMMIG == 0061 ~ 2025,            # 2022-2025
    YRIMMIG == 0062 ~ 2026,            # 2024-2026
    TRUE ~ NA_real_
  ))

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#create an age at immigration var
df1$AGEATIMMIG <- df1$yrimmig_clean - df1$YEAROFBIRTH

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#create a years since immigration var
df1$years_since_immig <- df1$AGE - df1$AGEATIMMIG

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# RACE
df1 <- df1 %>% 
  mutate(race_clean = case_when(
  RACE == 100  ~ 1, #white
  RACE == 200  ~ 2, #black
  RACE == 300 ~ 3, #native american
  RACE %in% 650:652 ~ 4, #Asian
  TRUE        ~ 5  # Default "else" case
))

#Omitted cat: all other race combinations
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# HISPAN
df1 <- df1 %>% 
  mutate(hisp_clean = case_when(
  HISPAN == 000 ~ 0, #non-hispan
  HISPAN == 100 ~ 1, #Mexican
  HISPAN == 200 ~ 2, #Puerto Rican
  HISPAN == 300 ~ 3, #Cuban
  HISPAN == 400 ~ 4, #Dominican
  HISPAN == 500 ~ 5, #salvi
  HISPAN == 611 ~ 6, #central american excluding salvi
  HISPAN == 612 ~ 7, #south american
  HISPAN > 900 ~ NA_real_, # not available no response
  TRUE          ~ 8  #other Hispanic
))

#Omitted cat: all other Hispanic categories

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# BPL

#binary inside and outside US
df1 <- df1 %>% 
  mutate(bpl_binary = case_when(
  BPL < 13000 ~ 0, #born in US 
  BPL > 13000 & BPL < 99999 ~ 1, #born outside US
  TRUE          ~ NA_real_ #NUI
))

#categorical 
df1 <- df1 %>% 
  mutate(bpl_detail = case_when(
    BPL < 20000 ~ 0, # north america
    BPL >= 20000 & BPL <= 21090 ~ 1, # central america
    BPL >= 25000 & BPL <= 26091 ~ 2, # Caribbean
    BPL >= 30005 & BPL <= 30070 ~ 3, # south america
    BPL >= 40000 & BPL <= 49900 ~ 4, # europe all regions
    BPL >= 50000 & BPL <= 59900 ~ 5, # asia, eurasia, middle east, etc...
    BPL >= 60010 & BPL <= 60099 ~ 6, # africa
    BPL >= 70010 & BPL <= 72000 ~ 7, # oceania
    TRUE ~ NA_real_ #NUI
  ))

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# NATIVITY
df1 <- df1 %>% 
  mutate(nativity_clean = case_when(
  NATIVITY == 1 ~ 1, #both parents native born
  NATIVITY == 2 ~ 2, #father foreign born
  NATIVITY == 3 ~ 3, #mother foreign born
  NATIVITY == 4 ~ 4, #both foreign born
  NATIVITY == 5 ~ 5,  #foreign born
  TRUE          ~ NA_real_ #Unknown
))

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# EDUC
df1 <- df1 %>% 
  mutate(educ_clean = case_when(
  EDUC < 073 ~ 0, # less than high school
  EDUC == 073 ~ 1, # high school 
  EDUC >= 080 & EDUC <= 100 ~ 2, # some college
  EDUC == 111 ~ 3, # bachelors
  EDUC >= 123 & EDUC <= 125 ~ 4,  # grad degree
  TRUE           ~ NA_real_ #NUI
))

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# REGION
df1 <- df1 %>% 
  mutate(region_clean = case_when(
  REGION < 20 ~ 1, #northeast
  REGION > 20 & REGION < 30 ~ 2, #midwest
  REGION > 30 & REGION < 40 ~ 3, #south
  REGION > 40 & REGION < 50 ~ 4, #west
  TRUE ~ NA_real_
))

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# SEX
df1 <- df1 %>% 
  mutate(sex_clean = case_when(
  SEX == 1 ~ 0, #male
  SEX == 2 ~ 1, #female
  SEX == 9 ~ NA_real_ #NIU
))

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CITIZEN
df1 <- df1 %>% 
  mutate(citizen_clean = case_when(
  CITIZEN < 4 ~ 1, #born citizen
  CITIZEN == 4 ~ 2, #naturalized citizen
  CITIZEN == 5 ~ 0, #non-citizen
  CITIZEN == 9 ~ NA_real_ #NIU
))

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# EMPSTAT
df1 <- df1 %>% 
  mutate(empstat_clean = case_when(
    EMPSTAT >= 20 & EMPSTAT <= 22 ~ 0, #unemployed
    EMPSTAT == 10 | EMPSTAT == 12 ~ 1, #employed
    EMPSTAT == 01 ~ 2, #Armed Forces
    EMPSTAT >= 30 ~ 3, #NILF
    TRUE ~ NA_real_ #NUI
  ))

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#GETTING RID OF CERTAIN VALUES - 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Keep rows where INCOME TOTAL is not NA
df1 <- df1 %>% filter(!is.na(INCTOT))
df1 <- df1 %>% filter(!is.na(INCWAGE))

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#COMPUTING INCOMES INFLATION ADJUSTED TO 2000 CPI (1999 dollars)- 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#CPI values from https://cps.ipums.org/cps/cpi99.shtml 

#INCWAGE INFLATION ADJUSTED
df1 <- df1 %>%
  mutate(incwage_clean = case_when(
    YEAR == 2001 ~ INCWAGE * 0.967,
    YEAR == 2002 ~ INCWAGE * 0.941,
    YEAR == 2003 ~ INCWAGE * 0.926,
    YEAR == 2004 ~ INCWAGE * 0.905,
    YEAR == 2005 ~ INCWAGE * 0.882,
    YEAR == 2006 ~ INCWAGE * 0.853,
    YEAR == 2007 ~ INCWAGE * 0.826,
    YEAR == 2008 ~ INCWAGE * 0.804,
    YEAR == 2009 ~ INCWAGE * 0.774,
    YEAR == 2010 ~ INCWAGE * 0.777,
    YEAR == 2011 ~ INCWAGE * 0.764,
    YEAR == 2012 ~ INCWAGE * 0.741,
    YEAR == 2013 ~ INCWAGE * 0.726,
    YEAR == 2014 ~ INCWAGE * 0.715,
    YEAR == 2015 ~ INCWAGE * 0.704,
    YEAR == 2016 ~ INCWAGE * 0.703,
    YEAR == 2017 ~ INCWAGE * 0.694,
    YEAR == 2018 ~ INCWAGE * 0.679,
    YEAR == 2019 ~ INCWAGE * 0.663,
    YEAR == 2020 ~ INCWAGE * 0.652,
    YEAR == 2021 ~ INCWAGE * 0.644,
    YEAR == 2022 ~ INCWAGE * 0.615,
    YEAR == 2023 ~ INCWAGE * 0.569,
    YEAR == 2024 ~ INCWAGE * 0.547,
    YEAR == 2025 ~ INCWAGE * 0.531,
    TRUE ~ INCWAGE
  ))

#INCTOT INFLATION ADJUSTED
df1 <- df1 %>%
  mutate(inctot_clean = case_when(
    YEAR == 2001 ~ INCTOT * 0.967,
    YEAR == 2002 ~ INCTOT * 0.941,
    YEAR == 2003 ~ INCTOT * 0.926,
    YEAR == 2004 ~ INCTOT * 0.905,
    YEAR == 2005 ~ INCTOT * 0.882,
    YEAR == 2006 ~ INCTOT * 0.853,
    YEAR == 2007 ~ INCTOT * 0.826,
    YEAR == 2008 ~ INCTOT * 0.804,
    YEAR == 2009 ~ INCTOT * 0.774,
    YEAR == 2010 ~ INCTOT * 0.777,
    YEAR == 2011 ~ INCTOT * 0.764,
    YEAR == 2012 ~ INCTOT * 0.741,
    YEAR == 2013 ~ INCTOT * 0.726,
    YEAR == 2014 ~ INCTOT * 0.715,
    YEAR == 2015 ~ INCTOT * 0.704,
    YEAR == 2016 ~ INCTOT * 0.703,
    YEAR == 2017 ~ INCTOT * 0.694,
    YEAR == 2018 ~ INCTOT * 0.679,
    YEAR == 2019 ~ INCTOT * 0.663,
    YEAR == 2020 ~ INCTOT * 0.652,
    YEAR == 2021 ~ INCTOT * 0.644,
    YEAR == 2022 ~ INCTOT * 0.615,
    YEAR == 2023 ~ INCTOT * 0.569,
    YEAR == 2024 ~ INCTOT * 0.547,
    YEAR == 2025 ~ INCTOT * 0.531,
    TRUE ~ INCTOT
  ))

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#FILTERING FOR IMMIGRANTS, AND FOR ERROR AGES - 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#filter a data set that includes only people who have data on immigrating
#df1 <- df1 %>% filter(!is.na(AGEATIMMIG))
#REMOVED THIS TO DO IN THE NEXT PYTHON FILE (8/18/2026)

#filter immigrants who have negative AGEATIMMIG 
# (probable error in census or error in answering census)
df1 <- df1 %>% filter(AGEATIMMIG >= 0)

# only 2% of the 492245 observations where AGEATIMMIG != NA were negative ages. 

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#DOWNLOAD NEW CSV - 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
write.csv(df1, 'gaston_df_v2.csv', row.names = FALSE)

#v1: filtered to only include observations of Hispanics (excludes NA and non-Hispanics from final csv)
#v2 (8/18/26): removed Hispanic filters, those steps will be done in python code. 
    #Found that PRicans included in immigrant observations, which is an issue.
