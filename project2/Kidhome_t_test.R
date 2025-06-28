
filtered_kid <- data[data$Kidhome %in% c(0, 1), ]

test1 <- shapiro.test(filtered_kid$Total_Spent[filtered_kid$Kidhome == 0])
test2 <-shapiro.test(filtered_kid$Total_Spent[filtered_kid$Kidhome == 1])


test3 <-leveneTest(Total_Spent ~ as.factor(Kidhome), data = filtered_kid)


test4 <-t.test(Total_Spent ~ as.factor(Kidhome), data = filtered_kid, var.equal = FALSE)

