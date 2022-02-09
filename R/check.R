#' @importFrom rlang .data
incoming_stage <- function(stage_name = NULL){
  url <- paste0("https://cran.r-project.org/incoming/", stage_name)
  incoming <- rvest::read_html(url)
  result <- rvest::html_table(incoming)[[1]] |>
    dplyr::select(c(.data$Name, .data$`Last modified`, .data$Size)) |>
    dplyr::rename(modified = .data$`Last modified`) |>
    dplyr::rename_with(tolower) |>
    dplyr::filter(.data$modified != "") |>
    dplyr::mutate(queue = stage_name)
  if (nrow(result) == 0){
    NULL
  } else {
    result
  }
}

#' reports on the contents of CRANs incoming queues
#' @param stage_name The name of the queue to check
#' @export
incoming <- function(stage_name = NULL){
  if (is.null(stage_name)){
    inspect <- incoming_stage("inspect")
    newbies <- incoming_stage("newbies")
    pending <- incoming_stage("pending")
    pretest <- incoming_stage("pretest")
    publish <- incoming_stage("publish")
    recheck <- incoming_stage("recheck")
    waiting <- incoming_stage("waiting")
    dplyr::bind_rows(inspect, newbies, pending, pretest, publish, recheck, waiting)
  } else {
    incoming_stage(stage_name)
  }
}

#' @importFrom rlang .data
available_queues <- function(){
  incoming <- rvest::read_html("https://cran.r-project.org/incoming/")
  rvest::html_table(incoming)[[1]] |>
    dplyr::select(c(.data$Name)) |>
    dplyr::rename_with(tolower) |>
    dplyr::filter(.data$name != "", .data$name != "Parent Directory") |>
    dplyr::mutate(name = sub("/", "", .data$name)) |>
    dplyr::pull(.data$name)
}

#' checks where a package is within the incoming queues
#' @param package Package name to check for
#' @importFrom rlang .data
#' @export
check_package <- function(package){
  search_string <- paste0(package, "_")
  incoming() |>
    dplyr::filter(grepl(search_string, .data$name)) |>
    as.list()
}
