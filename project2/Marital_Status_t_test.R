library(readxl)
library(car)     
library(ggplot2)
library(dplyr)

data <- read_excel("Data.xlsx")
data$Total_Spent <- data$MntWines + data$MntFruits + data$MntMeatProducts +
  data$MntFishProducts + data$MntSweetProducts + data$MntGoldProds

unique(data$Marital_Status)


filtered_data <- data %>% filter(Marital_Status %in% c("Single", "Married"))
test1 <- shapiro.test(filtered_data$Total_Spent[filtered_data$Marital_Status == "Single"])
test2 <- shapiro.test(filtered_data$Total_Spent[filtered_data$Marital_Status == "Married"])
test3 <- leveneTest(Total_Spent ~ Marital_Status, data = filtered_data)
t_test <- t.test(Total_Spent ~ Marital_Status, data = filtered_data, var.equal = TRUE)


