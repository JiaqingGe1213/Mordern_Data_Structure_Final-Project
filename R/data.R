#' Daily Official Price index and online price index in US from 2008.07-2015.08
#'
#' A dataset containing the Official price index leased by Bureau of labor statistics
#' along with the price index built in the paper ‘THE BILLION PRICES PROJECT: USING
#' ONLINE PRICES FOR MEASUREMENT AND RESEARCH’
#' @format A data frame with 2588 rows and 10 variables:
#' \describe{
#'   \item{year}{year of the observation, integer}
#'   \item{month}{month of the observation, abbreviated month}
#'   \item{date}{date of the observation, dd-mmm-yy}
#'   \item{indexPS}{the price index in the paper, base day = 2008.07.01}
#'   \item{monthlyPS}{the percentage change of price index through the month}
#'   \item{annualPS}{the percentage change of price index through the years}
#'   \item{day}{day of the observation, integer}
#'   \item{CPI}{the official price index leased by Bureau of labor statistics, base month = 2008.07}
#'   \item{inflation_CPI}{the inflation rate calculated by CPI, percentage}
#' }
#' @source \url{https://dataverse.harvard.edu/file.xhtml?persistentId=doi:10.7910/DVN/6RQCRS/KGU8B0&version=2.0}
#'         \url{https://www.bls.gov/developers/api_signature_v2.htm}
"US_price_indexes"

#' Monthly Official Price index and online price index in US from 2008.07-2015.08
#'
#' A dataset containing monthly the Official price index leased by Bureau of labor statistics
#' along with the price index built in the paper ‘THE BILLION PRICES PROJECT: USING
#' ONLINE PRICES FOR MEASUREMENT AND RESEARCH’
#' @format A data frame with 86 rows and 8 variables:
#' \describe{
#'   \item{year}{year of the observation, integer}
#'   \item{period}{month of the observation in index, M01-M12}
#'   \item{PS_month}{the price index in the paper, base month = 2008.07}
#'   \item{CPI}{the official price index leased by Bureau of labor statistics, base month = 2008.07}
#'   \item{inflation_CPI}{the inflation rate calculated by CPI, percentage}
#'   \item{inflation_PS}{the inflation rate calculated by PS_month, percentage}
#'   \item{month}{month of the observation, abbreviated month}
#'   \item{mdate}{month of the observation in date form, year + abbreviated month + 01}
#' @source \url{https://dataverse.harvard.edu/file.xhtml?persistentId=doi:10.7910/DVN/6RQCRS/KGU8B0&version=2.0}
#'         \url{https://www.bls.gov/developers/api_signature_v2.htm}
"US_price_month"
