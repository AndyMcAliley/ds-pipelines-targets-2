source("1_fetch/src/get_nwis_data.R")

nwis_Cd <- "00010"
start_date <- "2014-05-01"
end_date <- "2015-05-01"

p1_targets_list <- list(
  tar_target(
    p1_site_data_01427207,
    download_nwis_site_data("01427207", 
                            parameterCd = nwis_Cd,
                            startDate = start_date,
                            endDate = end_date)
  ),
  tar_target(
    p1_site_data_01432160,
    download_nwis_site_data("01432160", 
                            parameterCd = nwis_Cd,
                            startDate = start_date,
                            endDate = end_date)
  ),
  tar_target(
    p1_site_data_01435000,
    download_nwis_site_data("01435000", 
                            parameterCd = nwis_Cd,
                            startDate = start_date,
                            endDate = end_date)
  ),
  tar_target(
    p1_site_data_01436690,
    download_nwis_site_data("01436690", 
                            parameterCd = nwis_Cd,
                            startDate = start_date,
                            endDate = end_date)
  ),
  tar_target(
    p1_site_data_01466500,
    download_nwis_site_data("01466500", 
                            parameterCd = nwis_Cd,
                            startDate = start_date,
                            endDate = end_date)
  ),
  tar_target(
    p1_site_data_csv,
    nwis_df(file.path("1_fetch", "out", "site_data.csv"),
            list(p1_site_data_01427207,
                 p1_site_data_01432160,
                 p1_site_data_01435000,
                 p1_site_data_01436690,
                 p1_site_data_01466500)),
    format = "file"
  ),
  tar_target(
    p1_site_info_csv,
    nwis_site_info(fileout = "1_fetch/out/site_info.csv", p1_site_data_csv),
    format = "file"
  )
)
