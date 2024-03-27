Sales <- read.csv(file=file.choose(), header=TRUE, sep=",")

colnames(Sales) <- c("Rentals", "Money")

SalesModel <- lm(Money ~ Rentals, data=Sales)

SalesModel

summary(SalesModel)