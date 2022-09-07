#'
#'
#'
#'
#'


extract_chrom_trace <- function(x) {
  trace_block_start <-
    which(stringr::str_detect(x, '\\[TRACE]') == TRUE)

  trace_limits_start <- which(stringr::str_detect(x, '\\{') == TRUE)

  trace_limits_end <- which(stringr::str_detect(x, '\\}') == TRUE)


  trace_diff <- trace_limits_start - trace_block_start

  start_trace_ind <-
    trace_limits_start[trace_diff == min(trace_diff[trace_diff > 0])] + 1


  end_trace_ind <- trace_limits_end[which.min(trace_limits_end)] - 1


  trace_extract <- x[start_trace_ind:end_trace_ind]

  tab_split <- stringr::str_split(trace_extract, '\t')

  rt <- as.numeric(purrr::map_chr(tab_split, ~ {
    .[[1]]
  }))
  abs <- as.numeric(purrr::map_chr(tab_split, ~ {
    .[[2]]
  }))

  return(data.frame(rt = rt, abs = abs))
}


#'
#'
#'
#'
#'
#'
#'

extract_peak_table <- function(x) {
  peak_block_start <-
    which(stringr::str_detect(x, '\\[PEAK]') == TRUE)

  peakx <- x[min(peak_block_start):max(peak_block_start)]


  peak_limits_start <-
    which(stringr::str_detect(peakx, '\\{') == TRUE) + 1

  peak_limits_end <-
    which(stringr::str_detect(peakx, '\\}') == TRUE) - 1

  peak_list <- list()
  for (i in seq_along(peak_limits_start)) {
    peak_list[[i]] <- peakx[peak_limits_start[i]:peak_limits_end[i]]
  }


  peak_split <- purrr::map(peak_list, ~ {
    stringr::str_split(., '\t')
  })


  peak_table <- list()
  for (i in seq_along(peak_split)) {
    peak_table[[i]] <-
      purrr::map(peak_split[[i]], ~ {
        stringr::str_split(., '\\t')
      })
  }


  peak_tibble <- tibble::tibble(
    PeakID = NA,
    PeakRef = NA,
    Time = NA,
    MinTime = NA,
    MaxTime = NA,
    MinInt = NA,
    MaxInt = NA,
    Height = NA,
    AreaAbs = NA,
    AreaBP = NA,
    AreaTotal = NA,
    Width = NA
  )

  peak_tibble_fill <- data.frame(matrix(nrow = length(peak_table),
                                        ncol = ncol(peak_tibble)))

  names(peak_tibble_fill) <- names(peak_tibble)


  for (i in seq_along(peak_table)) {
    peak_tibble_fill$PeakID[i] <- peak_table[[i]][[1]][[2]]
    peak_tibble_fill$PeakRef[i] <- peak_table[[i]][[2]][[2]]
    peak_tibble_fill$Time[i] <- peak_table[[i]][[3]][[2]]
    peak_tibble_fill$MinTime[i] <- peak_table[[i]][[4]][[2]]
    peak_tibble_fill$MaxTime[i] <- peak_table[[i]][[4]][[3]]
    peak_tibble_fill$MinInt[i] <- peak_table[[i]][[5]][[2]]
    peak_tibble_fill$MaxInt[i] <- peak_table[[i]][[5]][[3]]
    peak_tibble_fill$Height[i] <- peak_table[[i]][[6]][[2]]
    peak_tibble_fill$AreaAbs[i] <- peak_table[[i]][[7]][[2]]
    peak_tibble_fill$AreaBP[i] <- peak_table[[i]][[8]][[2]]
    peak_tibble_fill$AreaTotal[i] <- peak_table[[i]][[9]][[2]]
    peak_tibble_fill$Width[i] <- peak_table[[i]][[10]][[2]]
  }

  return(peak_tibble_fill)
}


#'
#'
#'
#'
#'
#'
#'

chrom_opener <- function(file)
{
  file_open <- readLines(file)


  chromatogram_grep <-
    c(which(stringr::str_detect(file_open, '\\[CHROMATOGRAM]') == TRUE),
      length(file_open))


  chrom_seq_index <- list()

  for (i in seq_along(chromatogram_grep[1:length(chromatogram_grep) - 1])) {
    chrom_seq_index[[i]] <-
      seq(from = chromatogram_grep[i], chromatogram_grep[i + 1])
  }


  start <- chromatogram_grep
  end <- chromatogram_grep - 1

  n_range <- length(start) - 1

  for (i in seq_along(chrom_seq_index[1:n_range])) {
    chrom_seq_index[[i]] <- seq(from = start[i],
                                to = end[i + 1])
  }

  chrom_list <- list()
  for (i in seq_along(chrom_seq_index)) {
    chrom_list[[i]] <- file_open[chrom_seq_index[[i]]]
  }

  return(chrom_list)
}
