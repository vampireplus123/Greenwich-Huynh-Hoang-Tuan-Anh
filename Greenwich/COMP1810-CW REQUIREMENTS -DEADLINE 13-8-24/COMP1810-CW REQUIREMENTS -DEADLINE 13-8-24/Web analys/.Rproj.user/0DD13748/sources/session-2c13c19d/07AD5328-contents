library(readxl)

# Load the data
eshop <- read_excel('e-shop clothing 2008.xlsx')

library(dplyr)

# Calculate total sales per year and month
monthly_sales <- eshop %>%
  group_by(year, month) %>%
  summarise(total_sales = sum(`order(sells)`))

# Print the result
print(monthly_sales)

library(ggplot2)
ggplot(monthly_sales, aes(x = month, y = total_sales, fill = factor(year))) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Tổng doanh thu theo tháng", x = "Tháng", y = "Doanh thu") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


