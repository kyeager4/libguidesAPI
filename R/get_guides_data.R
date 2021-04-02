#' Call the LibGuides GET guides API (v1.1) and simplify it.
#'
#' @description
#' This function calls the LibGuides GET guides API, and returns a dataframe with your institution's guide data.
#' @param siteID numeric or character string containing your institution's site ID
#' @param key character string containing your institution's API key
#' @param expand_pages logical - if TRUE, output dataframe will have one row per page per guide; if FALSE, output dataframe will have one row per guide. Default is TRUE.
#' @details
#' The LibGuides API requires a LibGuides CMS subscription, so if your institution does not have a CMS subscription, this function will not work. Your site ID and API key can be found under Tools > API; click the GET Guides link.
#' @return
#' Data frame containing the guides data (at either the guide level or page level), with the "owner" and "group" columns expanded.
#' @export
#' @examples
#' mydata <- get_guides_data(siteID="YOUR_SITEID_HERE", key="YOUR_KEY_HERE")
get_guides_data <- function(siteID=NULL, key=NULL, expand_pages=TRUE){
  data <- jsonlite::fromJSON(call_LG_api(siteID=siteID, key=key, content="guides"))
  data2 <- data
  names(data2) <- paste0("guide_", names(data))
  data2 <- jsonlite::flatten(data2)

  if(expand_pages){
    data3 <- data2 %>%
      dplyr::select(guide_id, guide_pages) %>%
      jsonlite::flatten() %>%
      tidyr::unnest()

    names(data3)[2:ncol(data3)] <- paste0("page_", names(data3)[2:ncol(data3)])

    lgpages <- dplyr::left_join(data3, data2, by="guide_id") %>%
      dplyr::select(-guide_pages) %>%
      dplyr::select(starts_with("guide"), starts_with("page"), everything())
  }
  else{
    lgpages <- data2 %>% select(-guide_pages)
  }

  return(lgpages)
}
