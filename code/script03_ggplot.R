library(tidyverse)


# point figure ------------------------------------------------------------


iris %>% 
  ggplot(
    aes(x = Sepal.Length,
        y= Sepal.Width)
  ) +
  geom_point()



iris %>% 
  ggplot(
    aes(x = Sepal.Length,
        y= Sepal.Width,
        color = Species)
  ) +
  geom_point

# exercise ----------------------------------------------------------------





R



iris %>% 
  ggplot(
    aes(x = Sepal.Length,
        y = Sepal.Width)
  ) +
  geom_point(color= "darkgreen")



# line figure -------------------------------------------------------------

df_x <- tibble(x= 1:50,
       y = 2 * x)



# histogram ---------------------------------------------------------------

iris %>% 
  ggplot(
    aes(x = Sepal.Length)
  ) +
  geom_histogram()


# boxplot -----------------------------------------------------------------

iris %>% 
  ggplot(
    aes(x = Species,
        y= Sepal.Length)
  ) +
  geom_boxplot()

## change color
iris %>% 
ggplot(
  aes(x = Species,
      y= Sepal.Length,
      color= Species)
 )+
  geom_boxplot()


iris %>% 
  ggplot(
    aes(x = Species,
        y = Sepal.Length,
        fill = Species)
  ) +
  geom_boxplot()
  


# Q1 using "iris" data, identify the longest Sepal. Length using arrange function

iris %>% 
  arrange(desc(Sepal.Length))

# Q2 using "iris" data, filter individuals with Sepal. Width greater than 3.0
iris %>% 
filter(Sepal.Width > 3.0)

# Q3 using "iris" data, select the column "petal .Length" and "petal. width",
# and then arrange the order of rows by "petal. Length
# assign the result to object " df_petal"

df_petal <- iris %>%
  select(Petal.Length, Petal.Width) %>% 
  arrange(desc(Petal.Length))

# Q4 calculate mean sepal. Width by species; assign the result to "df_mean"


iris %>% 
  group_by(Species) %>% 
  summarize(mean = mean(Sepal.Width))


# Q5 create a point figure with pedal.Width ( y- axis) and sepal width ( x axis)
# with colors

iris %>% 
  ggplot(aes(x = Sepal.Width,
             y = Sepal.Length,
             color = Species)) +
  geom_point()
    
  
