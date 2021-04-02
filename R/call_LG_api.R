#' Call the LibGuides GET guides API (v1.1).
#'
#' @description
#' This function calls the LibGuides GET guides API, and returns a character
#' string containing the JSON. This can then be written to a text file, or
#' passed to other methods.
#' @param siteID numeric or character string containing your institution's site ID
#' @param key character string containing your institution's API key
#' @param content character string: one of "guides", "assets", "accounts", or "subjects"
#' @param options character string containing additional API options (must start with &)
#' @details
#' The LibGuides API requires a LibGuides CMS subscription, so if your
#' institution does not have a CMS subscription, this function will not work.
#' Your site ID and API key can be found under Tools > API; click the GET Guides link.
#'
#' ## Guides
#' Requests for guides will automatically include guide pages and guide owners.
#'
#' @return
#' Character string containing the JSON response from the LibGuides API.
#' @export
#' @examples
#' output <- call_LG_api(siteID="YOUR_SITE_ID", key="YOUR_API_KEY", content="guides")
call_LG_api <- function(siteID, key, content, options=""){

  content <- trimws(tolower(content), "both")
  if(!content %in% c("guides", "assets", "accounts", "subjects")){
    stop("invalid content type")
  }

  api_url <- paste0("http://lgapi.libapps.com/1.1/",
                content,
                "?site_id=",
                siteID,
                "&key=",
                key)

  if(content=="guides"){
    api_url <- paste0(api_url, "&expand[]=pages&expand[]=owner")
  }
  if(content=="accounts"){
    api_url <- paste0(api_url, "&expand[]=profile&expand[]=subjects")
  }
  if(content=="subjects"){
    api_url <- paste0(api_url, "&guide_published=1")
  }
  if(options!=""){
    api_url <- paste0(api_url, options)
  }

  api_connect <- url(api_url)
  json_text <- readLines(api_connect, warn=FALSE)
  close(api_connect)
  return(json_text)
}
