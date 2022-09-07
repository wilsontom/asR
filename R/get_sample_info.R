#' Get Sample Info
#'
#' Extract a minimal amount of sample information
#'
#' @param file a valid filepath for a `.ASR` file
#' @return a `data.frame` of sample information
#' @export

get_sample_info <- function(file)
{
  file_open <- readLines(file)

  Sample <- file_open[stringr::str_detect(file_open, 'Sample')][1]
  Well <- file_open[stringr::str_detect(file_open, 'Well')]
  FileName <- file_open[stringr::str_detect(file_open, 'FileName')]
  SampleType <-
    file_open[stringr::str_detect(file_open, 'SampleType')]
  SampleID	<- file_open[stringr::str_detect(file_open, 'SampleID')]
  Date <- file_open[stringr::str_detect(file_open, 'Date')]
  Time <- file_open[stringr::str_detect(file_open, 'Time')][1]
  UserName <- file_open[stringr::str_detect(file_open, 'UserName')]
  Instrument <-
    file_open[stringr::str_detect(file_open, 'Instrument')]
  Submitter <-
    file_open[stringr::str_detect(file_open, 'Submitter')]
  AnalysisTime <-
    file_open[stringr::str_detect(file_open, 'AnalysisTime')]
  Method <- file_open[stringr::str_detect(file_open, 'Method')][1]
  DAMethod <- file_open[stringr::str_detect(file_open, 'DAMethod')]



  sample_info  <- data.frame(
    Sample = Sample,
    Well = Well,
    FileName = FileName,
    SampleType = SampleType,
    SampleID = SampleID ,
    Date = Date,
    Time = Time,
    UserName = UserName,
    Instrument = Instrument,
    Submitter = Submitter ,
    AnalysisTime = AnalysisTime,
    Method = Method,
    DAMethod = DAMethod
  )

  info_value <-
    purrr::map_chr(stringr::str_split(sample_info, '\\t'), ~ {
      .[[2]]
    })


  sample_info[1,] <- info_value


  return(sample_info)


}
