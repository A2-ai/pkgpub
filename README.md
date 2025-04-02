<!-- badges: start -->
[![R-CMD-check](https://github.com/A2-ai/pkgpub/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/A2-ai/pkgpub/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

# pkgpub

## `new_cranlike_repo`
This function will create the following cran-like repo directory structure used by source and linux types:
```
new_cranlike_repo(dir = "<path/to/directory>")

directory
    |- src
        |- contrib
```
Note: This does not create a mac.binary type structure, but `instert_packages` can detect if using a mac.binary, and format that folder structure. 

## `build_pkg`
This function will build a source tarball, as well as another `type` tarball based on the platform used.
```
build_pkg(repository = "<repo>", remove_remotes = TRUE, vignettes = FALSE)

package_version.tar.gz                           # type = source
package_version.tgz                              # type = mac.binary
package_version_R_x86_64-pc-linux-gnu.tar.gz.    # type = linux
```
Note: If the package has a `Remotes` field listing packages in the `DESCRIPTION` file, those packages may need to be installed into the R library to build the tarballs. 

## `insert_packages`
This function will insert the package tarball into the cran-like repo, overwriting the `PACKAGES` files, and archiving older package builds. It will detect the type of binary, as well as the OS flavor to create a mac.binary cran-like repo structure. 
```
insert_packages("<path/to/tarball>", "<path/to/cran-like/directory>", archive = TRUE)

directory
    |- src
        |- contrib
            |- Archive
                |- package
                    |- package_old-version.tar.gz
            |- package_new-version.tar.gz
            |- PACKAGES
            |- PACKAGES.gz
            |- PACKAGES.rds
    |- bin/macosx/big-sur-arm64/contrib
        |- R-VERSION
            |- Archive
                |- package
                    |- package_old-version.tgz
            |- package_new-version.tgz
            |- PACKAGES
            |- PACKAGES.gz
            |- PACKAGES.rds
```