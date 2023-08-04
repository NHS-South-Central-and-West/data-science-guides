# script to read and format heart disease dataset

heart_disease <- 
  MLDataR::heartdisease |>
  janitor::clean_names()

readr::write_csv(heart_disease, here::here("data", "heart_disease.csv"))