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
