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
- [ ] continue refining regressions
- [x] re-code race, consider using non-linear regressors (age at immig squared, years since immig squared?)
- [x] code and include interaction variables

## 8/24
- finished recoding race variable
- began coding interaction variables
- cont. tmr


