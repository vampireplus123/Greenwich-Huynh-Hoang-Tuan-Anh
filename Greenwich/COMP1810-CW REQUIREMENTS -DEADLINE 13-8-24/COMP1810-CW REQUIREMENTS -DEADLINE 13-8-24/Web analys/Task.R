library(readxl)
library(dplyr)
library(ggplot2)


# Load the data
eshop <- read_excel('e-shop clothing 2008.xlsx')
file_input <- read_excel('input.xlsx')

#Make Sure Data Is Loaded
head(eshop,4)
tail(file_input,5)

#task B:
  # Calculate total sales per month
  # Making the  Chart

# total sales of year and month
monthly_sales <- eshop %>%
  group_by(year, month) %>%
  summarise(total_sales = sum(`order(sells)`))

# Print the result
print(monthly_sales)

#The Sale Chart in Line Chart
ggplot(monthly_sales, aes(x = month, y = total_sales)) + geom_line()
       + labs(title = "Monthly Sales", x = "Month", y ="Sale")
       +theme(axis.text.x =  element_text(angle = 90, hjust = 1))

#Task C:
  #Revenue per month
  #Showing the chart

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

#Task D:
  #Using input.xlsx with the salary column
  #The mean, 
  #Median 
  #mode, 
  #Standard Deviation 
  #Variance of the salary column.

#Getting the salary column
salary <- file_input$salary
print(salary)

#Mean Of salary
print(mean(salary,na.rm = TRUE))

#Median of salary
print(median(salary,na.rm = TRUE))

#Mode of Salary
Mode_function <- function(value){
  ux <- unique(value)
  ux[which.max(tabulate(match(value,ux)))]
}

print(Mode_function(salary))

#Variance of Salary
print(var(salary,na.rm = TRUE))

#Standard Deviation of salary
print(sd(salary,na.rm = TRUE))


# Task E:
#Extract Actors Whose Eye Color Is Not Black and Height Is Over 150m
#Add a Column for Body Mass Index (BMI) and Plot

data("starwars")

# Extract actors whose eye color is not black and height is over 150 meters
filtered_data <- starwars %>%
  filter(eye_color != "black", height > 150)

# Display the result
print(filtered_data)

# Add BMI column to the dataset
starwars_with_bmi <- starwars %>%
  mutate(BMI = mass / ((height / 100) ^ 2))

# Display the updated dataset with BMI
print(starwars_with_bmi)

# Plot height against BMI
ggplot(starwars_with_bmi, aes(x = height, y = BMI)) +
  geom_point() +
  labs(title = "Height vs. BMI in Star Wars Characters",
       x = "Height (cm)",
       y = "BMI") +
  theme_minimal()




