my_correlate <- function(data, vector_name, placement) {
  # my_correlate filters data by accelerometer placement and vector and then
  # performs a correlation analysis of the selected variables.
  #
  # Args:
  #   data: A data frame.
  #   vector_name: A character string with the vector name. Either "resultant"
  #   or "vertical".
  #   placement: A character string with the name of the accelerometer
  #   placement (either "ankle", "low back" or "hip").
  #
  # Returns:
  #   A cor_df object.
  msg <- paste("Accelerometer placement:", placement, "-- Vector:", vector_name)
  corr <- data %>% 
    dplyr::filter(vector == vector_name & acc_placement == placement) %>% 
    dplyr::select(pGRF_N, pACC_g, body_mass, pLR_Ns, pATR_gs) %>% 
    corrr::correlate()
  return(list(msg, corr))
}