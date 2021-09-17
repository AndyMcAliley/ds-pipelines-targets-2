library(targets)
source("1_fetch/src/get_nwis_data.R")
source("2_process/src/process_and_style.R")
source("3_visualize/src/plot_timeseries.R")

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse", "dataRetrieval")) # Loading tidyverse because we need dplyr, ggplot2, readr, stringr, and purrr

nwis_Cd <- '00010'
p_width <- 12
p_height <- 7
p_units <- "in"

p1_targets_list <- list(
  tar_target(
    site_data_01427207,
    download_nwis_site_data(file.path("1_fetch", "out", "nwis_01427207_data.csv"), parameterCd = nwis_Cd),
    format = "file"
  ),
  tar_target(
    site_data_01432160,
    download_nwis_site_data(file.path("1_fetch", "out", "nwis_01432160_data.csv"), parameterCd = nwis_Cd),
    format = "file"
  ),
  tar_target(
    site_data_01435000,
    download_nwis_site_data(file.path("1_fetch", "out", "nwis_01435000_data.csv"), parameterCd = nwis_Cd),
    format = "file"
  ),
  tar_target(
    site_data_01436690,
    download_nwis_site_data(file.path("1_fetch", "out", "nwis_01436690_data.csv"), parameterCd = nwis_Cd),
    format = "file"
  ),
  tar_target(
    site_data_01466500,
    download_nwis_site_data(file.path("1_fetch", "out", "nwis_01466500_data.csv"), parameterCd = nwis_Cd),
    format = "file"
  ),
  tar_target(
    site_data,
    nwis_df(c(site_data_01427207, site_data_01432160, site_data_01435000, site_data_01436690, site_data_01466500)),
  ),
  tar_target(
    site_info_csv,
    nwis_site_info(fileout = "1_fetch/out/site_info.csv", site_data),
    format = "file"
  )
)

p2_targets_list <- list(
  tar_target(
    site_data_clean, 
    clean_data(site_data, site_info_csv)
  )
)

p3_targets_list <- list(
  tar_target(
    figure_1_png,
    plot_nwis_timeseries(fileout = "3_visualize/out/figure_1.png", site_data_clean,
                         width = p_width, height = p_height, units = p_units),
    format = "file"
  )
)

# Return the complete list of targets
c(p1_targets_list, p2_targets_list, p3_targets_list)
