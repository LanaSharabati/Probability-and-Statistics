#What is the probability of exactly 85 correct classifications?
n <- 1035
k <- 954
p <- 0.9217
prob <- dbinom(k, size = n, prob = p)
cat("P(X = 954) =", prob,"\n")

#What is the probability that at least 960 emails are correctly classified?
prob_at_least_960 <- 1 - pbinom(959, size = 1035, prob = 0.9217)
cat("P(X >= 960) =", prob_at_least_960)



