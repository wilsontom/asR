#' Get Chromatogram
#'
#' Extract individual chromatograms for individual channels
#'
#' @param file a valid filepath for a `.ASR` file
#' @return a list of chromatogram blocks
#' @export

get_chromatograms <- function(file)
{

  chrom_list <- chrom_opener(file)

  chroms <- purrr::map(chrom_list, extract_chrom_trace)

  return(chroms)

}
