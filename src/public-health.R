# script to read and format raw data for public health outcomes dataset

# Setup ----

# install.packages("remotes")
# remotes::install_github("rOpenSci/fingertipsR")

# Raw Data ----

## PHE Fingertips ----

# pull public health outcomes raw data from fingertips
public_health_outcomes_raw <-
  fingertipsR::fingertips_data(
    ProfileID = 19,
    AreaTypeID = 401
  ) |>
  janitor::clean_names()

# pull imd scores and deciles from fingertips
imd_raw <-
  fingertipsR::deprivation_decile(
    AreaTypeID = 401
  ) |>
  janitor::clean_names(abbreviations = c("IMD"))

# filter for the indicators of interest and wrangle data into tidy structure
public_health_df <-
  public_health_outcomes_raw |>
  dplyr::filter(indicator_id %in% c(90630, 93882, 90282, 90287, 93736, 93759, 93758, 20101, 90284, 21001, 93015, 41001)) |>
  tidyr::drop_na(value) |> 
  dplyr::group_by(indicator_name, area_name, area_code) |>
  dplyr::summarise(value = mean(value)) |> 
  dplyr::select(indicator_name, area_name, area_code, value) |> 
  tidyr::pivot_wider(
    names_from = indicator_name,
    values_from = value
  ) |> 
  dplyr::full_join(imd_raw) |>
  dplyr::rename(
    low_income_children = `1.01i - Children in low income families (all dependent children under 20)`,
    ltc_working = `B08a - The percentage of the population with a physical or mental long term health condition in employment (aged 16 to 64)`,
    ltc_employment_gap = `B08a - Gap in the employment rate between those with a physical or mental long term health condition (aged 16 to 64) and the overall employment rate`,
    sickness_absence = `B09b - Sickness absence:  the percentage of working days lost due to sickness absence`,
    # domestic_abuse_incidents = `B11 - Domestic abuse related incidents and crimes`,
    homelessness = `B15a - Homelessness: households owed a duty under the Homelessness Reduction Act`,
    # outdoor_space = `B16 - Utilisation of outdoor space for exercise/health reasons`,
    fuel_poverty = `B17 - Fuel poverty (low income, low energy efficiency methodology)`,
    loneliness = `B19 - Loneliness: Percentage of adults who feel lonely often or always or some of the time`,
    low_birth_weight = `C04 - Low birth weight of term babies`,
    child_injury_admissions = `C11a - Hospital admissions caused by unintentional and deliberate injuries in children (aged 0 to 14 years)`,
    self_harm_admissions = `C14b - Emergency Hospital Admissions for Intentional Self-Harm`,
    inactive_adults = `C17b - Percentage of physically inactive adults`,
    suicide_rate = `E10 - Suicide rate`,
    imd_decile = decile
  ) |> 
  tidyr::drop_na()

# save public health outcomes data
readr::write_csv(
  public_health_df,
  here::here(
    "data", "public_health.csv"
  )
)
