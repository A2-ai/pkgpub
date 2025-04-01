#' insert packages into a drat repo
#' @param pkgs list of packages to insert
#' @param repository repository folder to insert
#' @param archive whether to archive the packages after insertion to prevent duplicates
#' @param OSflavour optional OS flavour specification, defaults to NULL unless detected as aarch64
#' @param ... parameters passed to `drat::archivePackages`
#' @details
#' repository folder should most likely correspond to the name
#' of the repository set in the pkg metadata, however
#' realistically, the time that they need to match when
#' repos is set in a user session in the `getOption('repos')` field
#' @export
insert_packages <- function(pkgs, repository, archive = TRUE, OSflavour = NULL, ...) {

  # Get system information
  sys_info <- Sys.info()
  arch <- R.version$arch

  # Format OSflavour if not provided
  if (!is.null(OSflavour)) {
    # Use the provided OSflavour value
  } else if (arch == "aarch64") {
    OSflavour <- paste(arch, "apple", tolower(sys_info["sysname"]), 
                    substr(sys_info["release"], 1, 2), sep="-")
  } else {
    OSflavour <- NULL
  }

  if (!dir.exists(repository)) {
    stop("no directory exists at ", repository, call. = FALSE)
  }
  added_pkgs <- lapply(pkgs, function(.p) {
    if (!file.exists(.p)) {
      warning("no package exists at ", .p, call. = FALSE)
      return(FALSE)
    }
    drat::insertPackage(.p, repodir = repository, OSflavour = OSflavour)
    return(TRUE)
  })
  message(sprintf("successfully added packages:\n %s", paste0(basename(pkgs[unlist(added_pkgs)]), collapse = ",\n ")))
  if (archive) {
    drat::archivePackages(repopath = repository, ...)
  }
  return(unlist(added_pkgs))
}
