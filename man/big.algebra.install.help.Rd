% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bigpca.R
\name{big.algebra.install.help}
\alias{big.algebra.install.help}
\title{Attempt to install the bigalgebra package}
\usage{
big.algebra.install.help(verbose = FALSE)
}
\arguments{
\item{verbose}{whether to report on installation progress/steps}
}
\value{
If bigalgebra is already installed, or can be installed from RForge or SVN,
 this should load or install the bigalgebra package,
 else will return instructions on what to do next to fix the issue
}
\description{
The bigalgebra package  has now been submitted to CRAN, so this function is now 
mostly redundant. It may still be useful for some, and it will still work,
as the first step to check CRAN, so at the risk of affecting existing code
I will leave the function here for now.
This function attempts to see whether bigalgebra is installed, then checks CRAN in case it 
has been updated, then check RForge. Failing that, it will attempt to install
using svn.bigalgebra.install(). Returns TRUE if already installed.
The bigalgebra package for efficient algebraic operations on big.matrix objects
was not currently on CRAN, and used to fail a check on dependencies. Changing the 
description file was needed to add the dependency, and linking 'BH' allow3e the package to work.
This function attempts to check-out the latest version of bigalgebra from SVN
version management system and corrects the description file then installs.
Note you must also have 'BLAS' installed on your system to utilise this package
effectively. PCA functions in the present package are better with bigalgebra installed,
but will still run without it. For more information on installation alternatives, 
type big.algebra.install.help().
}
\examples{
\donttest{ big.algebra.install.help(TRUE) }
}
\seealso{
\code{\link{svn.bigalgebra.install}}
}
