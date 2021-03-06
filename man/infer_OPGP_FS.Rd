\name{infer_OPGP_FS}
\alias{infer_OPGP_FS}
\title{Inference of the OPGPs (or parental phase) for a single full-sub families.}
\description{
Infers the OPGPs for all loci of a single full-sib family.
}
\usage{
infer_OPGP_FS <- function(genon, depth, config, \ldots)
}
\arguments{
  \item{depth_Ref}{Numeric matrix of allele counts for the reference allele.}
  \item{depth_Alt}{Numeric matrix of allele counts for the alternate allele.}
  \item{config}{Numeric vector of the segregation types for all the loci.}
  \item{epsilon}{Numeric value of the starting value for the sequencing error parameter. Default is NULL which means that the sequencing parameter is fixed at zero.}
  \item{\ldots}{Additional arguments passed to optim.}
}
\details{
The \code{depth_Ref} and \code{depth_Alt} matrices must have the rows representing the individuals and columns representing the SNPs. The entries of these two matrices must be a finite non-negative integer number. The value for the \code{config} vector are 1=both-informative (ABxAB), 2=paternal-informative A (ABxAA), 3=paternal-informative B (ABxBB), 4=maternal-informative (AAxAB), 5=maternal-informative (BBxAB), 6 = uninformative (AAxAA), 7 = uninformative (AAxBB), 8 = uninformative (BBxAA) and 9 = uninformative (BBxBB).

The methodology used to infer the OPGP is found in the section "Inferring OPGPs" of the manuscript by Bilton et al. (2017). Note that inference is made on a single full-sib family at a time.

Note: There can be issues at times in finding the maximum likelihood estimate (MLE) of the likelihood. Changing the \code{ndeps} argument that is passed to optim sometimes helps.
}
\value{Function returns a vector of the inferred OPGP values}
\author{Timothy P. Bilton}
\references{
Bilton, T.P., Schofield, M.R., Black, M.A., Chagne D., Wilcox P., Dodds K.G. (2017). Accounting for errors in low coverage sequencing data when constructing genetic maps using biparental outcrossed populations. Unpublished Manuscript.
}
\examples{
## simulate full-sib family
config <- c(2,1,1,4,2,4,1,1,4,1,2,1)
F1data <- simFS(0.01, config=config, nInd=50, meanDepth=5)

## Determine the parental phase
OPGP <- infer_OPGP_FS(F1data$depth_Ref, F1data$depth_Alt, config)
# Same and the true OPGP value 
F1data$OPGP

## if there are issues with solving the likelihood (see comment in details)
OPGP <- infer_OPGP_FS(F1data$depth_Ref, F1data$depth_Alt, config,
                      ndeps=rep(1e-1,sum(config==1)*2+sum(config!=1)-1))
}
  
  