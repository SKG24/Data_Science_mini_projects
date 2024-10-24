getwd()
setwd("/Users/sanatkumargupta/Desktop/data_science_mini_projects/Covid_19_analysis")
# getwd() is used to get working directory
# setwd() is uesd to change the working directory
library(Hmisc)
#Hmisc is useful in health, survey data, and exploratory analysis, where you often deal with missing data, need flexible descriptive statistics, or work with various data formats

data <- read.csv("/Users/sanatkumargupta/Desktop/data_science_mini_projects/Covid_19_analysis/COVID19_line_list_data.csv")
# to read data

describe(data) #hmisc command

# data is inconsistent under death column so we will clean it
data$death_dummy <- as.integer(data$death != 0) # making it binary 0, 1 for not dead or dead

#death rate
sum(data$death_dummy) / nrow(data)

#age 
#claim: people who die are older
dead = subset(data, death_dummy == 1)
alive = subset(data, death_dummy == 0)
mean(dead$age, na.rm = TRUE) # to ignore na values
mean(alive$age, na.rm = TRUE)

# is this statistically significant?
t.test(alive$age, dead$age, alternative = "two.sided", conf.level = 0.95)
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#A t-test is a statistical test used to compare the means of two groups. In this case, the goal is to determine if the average age of people who died (dead group) is significantly different from the average age of people who are alive (alive group).

#How to interpret the T-test results:
#P-value:
  
#The t-test will output a p-value, which helps you determine whether the difference in means is statistically significant.
#If the p-value is less than 0.05 (the typical significance level), it means the difference between the two means is statistically significant. This suggests that people who died are likely to be older than people who are alive.
#If the p-value is greater than 0.05, the difference in means is not statistically significant, meaning there is no strong evidence that the ages are different between those who died and those who are alive.

#Confidence Interval (CI):
  
#The confidence interval tells you the range in which the true difference between the two means lies, with 95% confidence.
#If the CI does not include zero, it further supports that the difference is significant.
#If the CI includes zero, it indicates that the difference might not be meaningful.
#Interpretation for your claim:

#The claim is: people who die are older.

#If the t-test returns a small p-value (< 0.05), it supports the claim that the difference in age between those who died and those who are alive is statistically significant, and older people tend to die more.
#If the p-value is large (>= 0.05), it suggests that there is no significant difference in the age between people who died and those who are alive, thus not supporting the claim.
#This statistical test helps confirm whether the observed pattern of older people dying is actually meaningful or could have occurred by random chance.
#concluded: this is statistically significant
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#claim: gender has no effect
men = subset(data, gender == "male")
women = subset(data, gender == "female")
mean(men$death_dummy, na.rm = TRUE) # to ignore na values
mean(women$death_dummy, na.rm = TRUE)

# is this statistically significant?
t.test(men$death_dummy, women$death_dummy, alternative = "two.sided", conf.level = 0.99)
# 99% confidenc: men have from 0.8% to 8.8% higher chance of dying
# p <0.05
# statistically significant: i.e, men have higher dying rate