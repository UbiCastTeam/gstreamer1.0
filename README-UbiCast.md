# UbiCast GStreamer repo

This repo is used to build a custom static (with minimal dependencies) GStreamer
full build  that fulfills UbiCast needs.

It targets Debian distributions, and is compatible with the debian version indicated
per branch. (i.e.: for `debianX`)

The CI of this repo builds the `gstreamer-full1.0` Debian package is created with the
following version format (see `man deb-version`):

        [upstream-version]-[debian-revision]

For example:

        1.28.1-ubicast-deb13+20260320

With `1.28.1` corresponding to the upstream version, and
`ubicast-deb13+20260320` to the custom UbiCast debian revision.

## What this repository contains

This repository contains debianized version of GStreamer for each of UbiCast
supported debian version.

Basically each branch will contains:

* GStreamer upstream code

UbiCast modifications (commit log with prefix `ubicast:`):

* Ubicast debianization modification (in ./debian folder)
* UbiCast patches/features that cannot be upstreamed (too specific, hence rejected by upstream)
* GStreamer backported fixes or features that are needed

It also includes the custom `.gitlab-ubicast.yml` file which runs the build in the Gitlab CI.

> **Note:** The gitlab configuration file for this project shall be set to
> `.gitlab-ubicast.yml` in the Gitlab project configuration UI

## Git workflow

Disclamer: this workflow it not optimal as it rewrite history, check for
`git-debrebase` for a better option and update this doc if it improve the
situation.

The workflow is different depending on the target GStreamer version upgrade (bugfix or upgrade).

For any big change a new release (.deb) is generated and its version shall be
increased accordingly.

The idea behind this workflow is to keep the GStreamer commits (from upstream) under
UbiCast modifications so that these are clearly visible on top of GStreamer ones.

The drawback is that we modify the history, at the price of a cleaner history.

The next sections describe how to handle different use cases, but prio to
that you will need to add an `upstream` git remote repository that point to the
official GStreamer repository

        git remote add upstream https://gitlab.freedesktop.org/gstreamer/gstreamer.git

### Updating to the latest GStreamer bug fix (patch version) release

This is the case when a new bug fix release is released like 1.28.1 -> 1.28.2

It generally consists in:

* switching to the wished debian branch: ``git switch debianX`` (e.g. ``git switch debian13``)

* fetching the upstream: ``git fetch upstream``

* Add a tag in case of fallback, as this operation will rewrite history you may
  add a tag corresponding to the version `ubicast-X.Y.Z` before the rebase, so that we can still restore the
  old version. (do not forget to push it to the server).

  For instance before updating from 1.22.1 -> 1.22.2 a tag
  `1.22.1+ubicast+bookworm` can be set.

  ```
  git tag X.Y.Z+ubicast+bookworm
  ```

* rebasing against the new bug fix tag: ``git rebase X.Y.Z`` (e.g. ``git rebase 1.22.3``)

* resolve any merge conflicts :-)

* update the debian/changelog (add new paragraph, and reset the version)

  You may use `debchange` to that, it will automatically update the
  `debian-revision` and set the correct date:

  ```
  DEBEMAIL=dev@ubicast.eu DEBFULLNAME="UbiCast team" dch -v 1.28.X-ubicast-deb13+$(date +%Y%m%d)
  # add your changelog then to finalize,
  DEBEMAIL=dev@ubicast.eu DEBFULLNAME="UbiCast team" dch -r
  ```
* commit the new `debian/changelog`

* push the updated branch: ``git push --force-with-lease``

This way we keep a clean history which show our modification on top.

### Upgrading to a new GStreamer stable branch

A new branch shall be created from the new stable tag UbiCast modification shall
be applied on it.

It is the same procedure as for bug fix release but you have to change the MINOR
version.

Don't forget to set tags to be able to rebuild specific release
