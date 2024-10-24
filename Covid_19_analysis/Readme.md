# COVID-19 Data Analysis

This project analyzes a COVID-19 dataset to uncover potential patterns in death rates based on factors like age and gender. Using statistical tests such as t-tests, the project aims to determine if there is a significant relationship between these factors and mortality during the pandemic.

## Project Overview

The goal of this project is to statistically test two primary claims:
1. **Age and death**: People who die due to COVID-19 tend to be older.
2. **Gender and death**: Gender has no effect on death rates.

### Dataset

The dataset used for this analysis contains the following relevant columns:
- `age`: The age of individuals in the dataset.
- `gender`: The gender of individuals (`male` or `female`).
- `death`: Binary data indicating whether an individual has died (1) or survived (0).

### Approach

1. **Data Cleaning**:
    - The `death` column was inconsistent, so it was converted to a binary format (`death_dummy`), where `0` means alive and `1` means dead:
    
    ```r
    data$death_dummy <- as.integer(data$death != 0)
    ```

2. **Death Rate Calculation**:
    - The overall death rate is calculated by dividing the total number of deaths by the total number of rows in the dataset:
    
    ```r
    death_rate <- sum(data$death_dummy) / nrow(data)
    ```

3. **Age Analysis**:
    - Subsets were created for people who died and those who survived, and their average ages were compared:
    
    ```r
    dead = subset(data, death_dummy == 1)
    alive = subset(data, death_dummy == 0)
    mean(dead$age, na.rm = TRUE)
    mean(alive$age, na.rm = TRUE)
    ```
    - A **t-test** was performed to determine if the age difference between those who died and those who survived is statistically significant:
    
    ```r
    t.test(alive$age, dead$age, alternative = "two.sided", conf.level = 0.95)
    ```

    - **Interpretation**:
        - If the **p-value** is less than 0.05, the difference in age is statistically significant, supporting the claim that older people are more likely to die from COVID-19.

4. **Gender Analysis**:
    - Subsets were created for men and women, and their average death rates were compared:
    
    ```r
    men = subset(data, gender == "male")
    women = subset(data, gender == "female")
    mean(men$death_dummy, na.rm = TRUE)
    mean(women$death_dummy, na.rm = TRUE)
    ```
    - A **t-test** was performed to determine if the difference in death rates between men and women is statistically significant:
    
    ```r
    t.test(men$death_dummy, women$death_dummy, alternative = "two.sided", conf.level = 0.99)
    ```

    - **Interpretation**:
        - If the **p-value** is less than 0.05, the difference in death rates between men and women is statistically significant, meaning gender has an effect on mortality, with men showing a higher death rate.

### Results

- **Age**: The t-test showed that older people have a significantly higher death rate.
- **Gender**: The t-test revealed that men have a significantly higher chance of dying from COVID-19 compared to women.

### Tools and Libraries Used

- **R**: The primary programming language for data analysis.
- **Hmisc**: A package used for data description and manipulation.
- **t.test()**: The function used to perform t-tests for statistical significance.

### How to Run the Project

1. Clone the repository:

    ```bash
    git clone https://github.com/yourusername/Covid_19_analysis.git
    ```

2. Install the required libraries in R:

    ```r
    install.packages("Hmisc")
    ```

3. Run the analysis script in R:

    ```r
    source("covid_analysis.R")
    ```

### Conclusion

This analysis supports the claim that older people and men are at higher risk of dying from COVID-19. The project uses t-tests to validate the statistical significance of these claims, providing a clear, data-driven understanding of mortality risk factors during the pandemic.
