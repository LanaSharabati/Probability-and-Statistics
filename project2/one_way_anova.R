
library(readxl)
library(dplyr)
library(car)         
library(ggplot2)

data <- read_excel("Data.xlsx")


data$Total_Spent <- data$MntWines + data$MntFruits + data$MntMeatProducts +
  data$MntFishProducts + data$MntSweetProducts + data$MntGoldProds


unique(data$Education)


data <- data %>% filter(!is.na(Education), !is.na(Total_Spent))


test1 <- by(data$Total_Spent, data$Education, shapiro.test)


test2 <-leveneTest(Total_Spent ~ Education, data = data)


test3 <-oneway.test(Total_Spent ~ Education, data = data, var.equal = FALSE)



test4 <- TukeyHSD(anova_model)




mean_data <- data %>%
  group_by(Education) %>%
  summarise(
    mean_spent = mean(Total_Spent, na.rm = TRUE),
    se = sd(Total_Spent, na.rm = TRUE) / sqrt(n())
  )

# Plot
ggplot(mean_data, aes(x = Education, y = mean_spent)) +
  geom_point(size = 3, color = "blue") +
  geom_line(group = 1, color = "blue") +
  geom_errorbar(aes(ymin = mean_spent - se, ymax = mean_spent + se), width = 0.2) +
  labs(title = "Mean Total Spending by Education Level with 95% CI",
       x = "Education Level",
       y = "Mean Total Spending") +
  theme_minimal()