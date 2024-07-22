library(readxl)
library(dplyr)
library(ggplot2)

# Load the data
eshop <- read_excel('e-shop clothing 2008.xlsx')
file_input <- read_excel('input.xlsx')

#task B:
  # Calculate total sales per year and month
  # Making the  Chart
# Calculate total sales per year and month
monthly_sales <- eshop %>%
  group_by(year, month) %>%
  summarise(total_sales = sum(`order(sells)`))

# Print the result
print(monthly_sales)

#Sale Chart
ggplot(monthly_sales, aes(x = month, y = total_sales)) + geom_line()
       + labs(title = "Doanh thu thang", x = "Thang", y ="Doanh Thu")
       +theme(axis.text.x =  element_text(angle = 90, hjust = 1))

#Calculate revenue per month

revenue <- eshop %>%
  group_by(year, month) %>%
  summarise(revenue_per_month = sum(price))

print(revenue)

#Revenue Chart
ggplot(revenue, aes(x = factor(month), y = revenue_per_month, fill = factor(year))) + 
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Revenue", x = "Month", y = "Revenue") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))



