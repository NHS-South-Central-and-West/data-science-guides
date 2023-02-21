# script to read and format raw data for deprivation models

# Setup ----

# install.packages("remotes")
# remotes::install_github("rOpenSci/fingertipsR")

# Raw Data ----

## PHE Fingertips ----

# pull wider determinants raw data from fingertips
wider_determinants_raw <-
  fingertipsR::fingertips_data(
    ProfileID = 130,
    # using pre 4/19 upper tier local authorities to match health index
    AreaTypeID = 102
  ) |>
  janitor::clean_names()

# pull imd scores and deciles from fingertips
imd_raw <-
  fingertipsR::deprivation_decile(
    AreaTypeID = 102
  ) |>
  janitor::clean_names(abbreviations = c("IMD"))

# filter for the indicators of interest and wrangle data into tidy structure
health_inequalities_df <-
  wider_determinants_raw |>
  dplyr::filter(indicator_id %in% c(92488, 90366, 93553)) |>
  dplyr::filter(area_code != "E92000001") |>
  dplyr::group_by(indicator_name, area_code, timeperiod_sortable) |>
  dplyr::summarise(value = mean(value)) |>
  dplyr::mutate(year = stringr::str_remove_all(timeperiod_sortable, "0000")) |>
  dplyr::select(indicator_name, area_code, year, value) |>
  tidyr::pivot_wider(
    names_from = indicator_name,
    values_from = value
  ) |>
  dplyr::full_join(imd_raw) |>
  dplyr::rename(
    life_expectancy = `Life expectancy at birth`,
    mortality = `Mortality rate from causes considered preventable (2016 definition)`,
    imd_decile = decile
  ) |>
  tidyr::drop_na()

## ONS Health Index ----

# import health index data
health_index_df <-
  openxlsx::read.xlsx(
    "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/healthandsocialcare/healthandwellbeing/datasets/healthindexengland/2015to2018/hibetadatatablesv2.xlsx",
    sheet = 8,
    rows = c(8:50252),
    colNames = TRUE
  ) |>
  janitor::clean_names()

# Merge & Wrangle Deprivation Dataset ----

# filter for relevant risk factors and pivot
risk_factors <-
  health_index_df |>
  dplyr::filter(
    geography_type == "Upper Tier Local Authority" &
      indicator_grouping_name %in% c(
        "Physiological risk factors",
        "Behavioural risk factors"
      )
  ) |>
  dplyr::select(area_code, year, indicator_grouping_name, index_value) |>
  tidyr::pivot_wider(
    names_from = indicator_grouping_name,
    values_from = index_value
  ) |>
  janitor::clean_names()

# join risk factors to fingertips data for relevant date range
deprivation_df <- health_inequalities_df |>
  dplyr::filter(year %in% (2015:2018)) |>
  dplyr::mutate(year = as.double(year)) |>
  dplyr::inner_join(risk_factors)

# save deprivation data
readr::write_csv(
  deprivation_df,
  here::here(
    "data", "deprivation.csv"
  )
)
