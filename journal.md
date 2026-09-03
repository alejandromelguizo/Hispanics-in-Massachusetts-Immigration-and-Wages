## 8/19
- added US_educ
    - if age at immig <= 17 & educ_level >= bachelors then US_educ = 1
    - basically checks if you got higher ed here in the US (which I assume would be a positive correlation with Wages as compared to omitted category)

- began basic regressions modeling
    - made one for MA hispanics, and one for all of US hispanics
    - decided on main variables to use
      - sex, educ, employment_status, usual hourse worked, <mark> years since immig, age at immig(?) </mark> , race, hispanic origin, citizenship status
          - these regressors are on log_wages
          - <mark>not sure if I should include both years since immig, and age at immig in the same regression, I am running into some multi-collinearity problems. </mark>

- considering adding interaction variables like (sex X educ), or (sex X hispanic origin)

### TO-DO (8/24/26)
- [x] continue refining regressions
- [x] re-code race, consider using non-linear regressors (age at immig squared, years since immig squared?)
- [x] code and include interaction variables

## 8/24
- finished recoding race variable
- began coding interaction variables
- cont. tmr

## 8/25
### TO-DO (8/25/26)
- [x] continue regressions
    - [x] include interaction variables, and new re-coded race var
    - [x] consider including non-linear regressors
- [x] email economics professor for feedback

- I am thinking that my variables of interest for this project are:
    - Hispanic origin, Age at Immig. or years since immig, and sex.
 
### Regression_v1_draft coefficient of interest interpretation so far: ((e^beta - 1)*100 used to calculate coefficient interpretations)
- <mark>**YSI**: A 1 year increase in years since immigration changes wages by 0.92%, significant at the 1% level. </mark>
- **Hispanic origin**:
   - Being Dominican (T4) is associated with a 5.16% decrease in wages as compared to Mexican omitted category.
    - Being South American (T7) is associated with a 4.79% increase in wages as compared to Mexican omitted category.
    - Being "Other Hispanic" (T8) is associated with a 10.68% increase in wages as compared to Mexican omitted category. 
        - (comparison group is Mexicans) (groups 4, 7 & 8 are significant at the 1% level) (holding all else constant!)
- **sex**: Being female is associated with a 39.74% decrease in wages as compared to male respondents, significant at the 1% level.
 
- updated regression by omitting NA/IDK respondents to Hispanic question.

### Questions:
- Is a 0.92% increase in wages per year since immigration economically significant or normal?
- 

### Began Multi-collinearity work
- used VIF method to find that AGE, YSI, CITIZEN, and EMPSTAT features have high VIF factor scores.
- used corr. index (**see corr_index.pdf**)
    - decided to remove UHRSWRKT bc of corr. with EMPSTAT
    - found corr. between educ and US_educ
    - 
### TO-DO (8/27/26)
- [x] Work further on how to resolve correlation issues
    - [x] US_educ & educ
    - [x] CITIZEN & YSI
    - [x] AGE & YSI
     
## 8/27/26
- since AGE and YSI are highly colinear; what happens if I remove AGE var?

- When I lowered the variables, the high conditional value fell. R_squared fell as well
- Going to slowly add other variables to see where the cut-off is

- I added folders to this GitHub for better organization

### TO-DO
- [ ] add variables one at a time to keep track of multi-collinearity
