\name{big.algebra.install.help}
\alias{big.algebra.install.help}
\title{Attempt to install the bigalgebra package}
\usage{
  big.algebra.install.help(verbose = FALSE)
}
\arguments{
  \item{verbose}{whether to report on installation
  progress/steps}
}
\value{
  If bigalgebra is already installed, or can be installed
  from RForge or SVN, this should load or install the
  bigalgebra package, else will return instructions on what
  to do next to fix the issue
}
\description{
  Will attempt to see whether bigalgebra is installed, then
  check CRAN in case it has been updated, then check
  RForge. Failing that, it will attempt to install using
  svn.bigalgebra.install(). Returns TRUE if already
  installed. The bigalgebra package for efficient algebraic
  operations on big.matrix objects is not currently on
  CRAN, and fails a check on dependencies. Changing the
  description file to add the dependency, and linking 'BH'
  allows the package to work. This function attempts to
  check-out the latest version of bigalgebra from SVN
  version management system and corrects the description
  file then installs. Note you must also have 'BLAS'
  installed on your system to utilise this package
  effectively. PCA functions in the present package are
  better with bigalgebra installed, but will still run
  without it. For more information on installation
  alternatives, type big.algebra.install.help().
}
\examples{
# not run # big.algebra.install.help(TRUE)
}
\seealso{
  svn.bigalgebra.install
}

