# libguidesAPI

R package with convenience functions for getting data from the LibGuides Endpoints v1.1 API.

## Installing and configuring R

1. Download R from [cran.r-project.org](https://cran.r-project.org/) and run it. You can use the default install options while using the install wizard.
2. (Optional) Download RStudio from [rstudio.com](https://www.rstudio.com/products/rstudio/download/).

After you have installed R, first time R users will need to install the following packages:
```{r}
install.packages(c("devtools", "jsonlite"))
```

You will then need to install this package from github:
```{r}
library(devtools)
devtools::install_github("kyeager4/libguidesAPI")
```

Once the packages are installed, you do not have to re-install them the next time you launch R.

If there are changes to the code in this package, you can rerun `install_github("kyeager4/ksulibSearch")` to update to the most recent version.

## Using this package

The LibGuides v1.1 API requires a LibGuides CMS subscription, so if your institution does not have a CMS subscription, you will not be able to use this package.

Your site ID and API key can be found in your LibGuides system under Tools > API. Go to the Endpoints V1.1 tab, then click the GET Guides link.

To use this package:
```{r}
## Load this package (only needs to be done once, at the start of your R session.)
library(libguidesAPI)

## In the below function, replace your_siteid and your_key with your institution's site ID and key (found in your libguides system).

## Obtain data for all guides in your system.
myguides <- get_guides_data(siteID=your_siteid, 
                            key=your_key,
                            expand_pages=FALSE)
```
