#' Call the LibGuides GET assets API (v1.1) and simplify it.
#'
#' @description
#' This function calls the LibGuides GET assets API using a filter for book assets, and returns a dataframe of the matching assets.
#' @param siteID numeric or character string containing your institution's site ID
#' @param key character string containing your institution's API key
#' @param options character string - any other options to append to the API request (see the API documentation for all options for each GET routine.)
#' @details
#' The LibGuides API requires a LibGuides CMS subscription, so if your institution does not have a CMS subscription, this function will not work. Your site ID and API key can be found under Tools > API; click the GET Guides link.
#' @return
#' Data frame containing the book asset data. If desired, can be joined with the user account data on the variable \code{owner_id}.
#' @export
#' @examples
#' mydata <- get_book_assets(siteID="YOUR_SITEID_HERE", key="YOUR_KEY_HERE")
get_book_assets <- function(siteID=NULL, key=NULL, options=""){
  options <- paste0("&asset_types=5", options)
  data <- jsonlite::fromJSON(call_LG_api(siteID=siteID, key=key, content="assets", options=options))
  data2 <- jsonlite::flatten(data)
  return(data2)
}
