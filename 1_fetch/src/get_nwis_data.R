
nwis_df <- function(filepath, site_dataframes){
  # Join data in site_dataframes in one data.frame
  # Write joined data out to a file
  # filepath is the csv file to write to
  # site_dataframes is a list of data.frames
  data_out <- bind_rows(site_dataframes)
  write_csv(data_out, file = filepath)
  return(filepath)
}


nwis_site_info <- function(fileout, site_data_csv){
  site_data <- read_csv(site_data_csv, col_types = 'ccTdcc')
  site_no <- unique(site_data$site_no)
  site_info <- dataRetrieval::readNWISsite(site_no)
  write_csv(site_info, fileout)
  return(fileout)
}


download_nwis_site_data <- function(site_num, parameterCd = '00010', startDate="2014-05-01", endDate="2015-05-01"){
  
  # readNWISdata is from the dataRetrieval package
  data_out <- readNWISdata(sites=site_num, service="iv", 
                           parameterCd = parameterCd, startDate = startDate, endDate = endDate)

  # -- simulating a failure-prone web-sevice here, do not edit --
  set.seed(Sys.time())
  if (sample(c(T,F,F,F), 1)){
    stop(site_num, ' has failed due to connection timeout. Try tar_make() again')
  }
  # -- end of do-not-edit block
  
  return(data_out)
}

