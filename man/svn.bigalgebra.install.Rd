\name{svn.bigalgebra.install}
\alias{svn.bigalgebra.install}
\title{Attempt to install the bigalgebra package using SVN}
\usage{
  svn.bigalgebra.install(verbose = FALSE)
}
\arguments{
  \item{verbose}{whether to report on installation
  progress/steps}
}
\value{
  If SVN is installed on your system, along with BLAS, this
  function should install the bigalgebra package, else it
  will return instructions on what to do to fix the issue
}
\description{
  The bigalgebra package for efficient algebraic operations
  on big.matrix objects is not currently on CRAN, and fails
  a check on dependencies. Changing the description file to
  add the dependency, and linking 'BH' allows the package
  to work. This function automatically performs these
  corrections. First, it attempts to check-out the latest
  version of bigalgebra from SVN version management system
  and then corrects the description file, then tries to
  install the package. Note you must also have 'BLAS'
  installed on your system to utilise this package
  effectively. PCA functions in the present package are
  better with bigalgebra installed, but will still run
  without it. For more information on installation
  alternatives, type big.algebra.install.help(). Returns
  TRUE if bigalgebra is already installed.
}
\examples{
# not run # svn.bigalgebra.install(TRUE)
}
\seealso{
  big.algebra.install.help
}

