library(ggplot2)
library(fitdistrplus)

data <- read.csv("day.csv")
temp_clean <- data$temp
temp_clean <- temp_clean[temp_clean > 0 & temp_clean < 1]


fit <- fitdist(temp_clean, "beta", method = "mle")
alpha <- fit$estimate["shape1"]
beta <- fit$estimate["shape2"]

p <- ggplot(data.frame(temp_clean), aes(x = temp_clean)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "lightgray", color = "black") +
  stat_function(fun = dbeta, args = list(shape1 = alpha, shape2 = beta),
                color = "red", linewidth = 1.2) +
  labs(title = "Fitted Beta Distribution for Normalized Temperature",
       x = "Normalized Temperature", y = "Density") +
  theme_minimal()

print(p)
