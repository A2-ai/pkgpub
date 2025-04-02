## pkgpub 0.4.0

* `os_flavor` added to insert_packages to allow for better macos binary insertion
* `create_tagged_repo` can now pass args to the underlying `build_pkg` function
* add ability to `remove_remotes` from Remote field from description files for cleaner insertion into package managers that contain full dependency sets
