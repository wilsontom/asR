#' Get Peak Tables
#'
#' Extract peaks tables from processed chromatograms for individual channels
#'
#' @param file a valid filepath for a `.ASR` file
#' @return a list of peak tables
#' @export

get_peak_table <- function(file)
{
  chrom_list <- chrom_opener(file)

  peaktables <- purrr::map(chrom_list, extract_peak_table)

  return(peaktables)

}
