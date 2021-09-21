source("3_visualize/src/plot_timeseries.R")

p_width <- 12
p_height <- 7
p_units <- "in"

p3_targets_list <- list(
  tar_target(
    p3_figure_1_png,
    plot_nwis_timeseries(fileout = "3_visualize/out/figure_1.png", p2_site_data_clean,
                         width = p_width, height = p_height, units = p_units),
    format = "file"
  )
)
