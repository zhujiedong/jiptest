# f value that time specific related calculation ---------------------------------------

# us related cal
time_us <- function(x, t){
  fluor_t <- abs(x* (1e+6) - t)
  near_t <- which(fluor_t == min(fluor_t))[1]
    return(near_t)
  }



# ms related cal
time_ms <- function(x, t){
  fluor_t <- abs(x* (1e+3) - t)
  near_t <- which(fluor_t == min(fluor_t))[1]
  return(near_t)
}

# extract needed data for a splited jip test results
extract_ojip <- function(jip_list){
  jip_list <- as.data.frame(jip_list)
  df <- data.frame(v1 = jip_list[[3]],
                   v2 = jip_list[[2]])
  names(df) <- c('SOURCE', jip_list[[1]][1])
  df
}

# return the jip test data for pca test

