clean_data <- function(nwis_data_csv, nwis_info_filename){
  nwis_data <- read_csv(nwis_data_csv, col_types='ccTdcc')
  site_info <- read_csv(nwis_info_filename, show_col_types = FALSE)
  nwis_data_clean <- rename(nwis_data, water_temperature = X_00010_00000) %>% 
    select(-agency_cd, -X_00010_00000_cd, -tz_cd)
  nwis_data_annotated <- left_join(nwis_data_clean, site_info, by = "site_no") %>% 
    select(station_name = station_nm, site_no, dateTime, water_temperature, latitude = dec_lat_va, longitude = dec_long_va)
  mutate(nwis_data_annotated, station_name = as.factor(station_name))
  
  return(nwis_data_annotated)
}

