# UbiCast GStreamer repo

This repo is used to build a custom static (dependency less) GStreamer build
(see https://dabrain34.github.io/2021/10/04/shrinking_gstreamer.html) that
fulfills UbiCast needs.

It targets Debian distributions, and is compatible with the debian version indicated
per branch. (i.e.: for `X.Y+ubicast+bookworm` is Gstreamer X for debian bookworm, where
`X.Y` could be `1.22` for example)

The CI of this repo builds the `gstreamer-full1.0` Debian package is created with the
following version format (see `man deb-version`):

        [upstream-version]-[debian-revision]

For example:

        1.22.0-deb12-ubicast1

With `1.22.0` corresponding to the upstream version, and `deb12-ubicast1` to the
debian version.

## What this repository contains

This repository mirrors each GStreamer branch and applies custom modification on them,
which may consist of:

* UbiCast patches/features that cannot be upstreamed (too specific, hence rejected by upstream)
* GStreamer backported fixes or features that are needed

It also includes the custom `.gitlab-ubicast.yml` file which runs the build in the Gitlab CI.

> **Note:** The gitlab configuration file for this project shall be set to
> `.gitlab-ubicast.yml` in the Gitlab project configuration UI

## Git workflow

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

### Updating to the latest GStreamer bug fix release

The corresponding branch is rebased against the bug fix tag `X.Y.Z` (e.g. `1.22.3`).

It generally consists in:

* switching to our latest branch: ``git switch X.Y+ubicast+bookworm`` (e.g. ``git switch 1.22-ubicast+bookworm``)

* fetching the upstream: ``git fetch upstream``

* rebasing against the new bug fix tag: ``git rebase X.Y.Z`` (e.g. ``git rebase 1.22.3``)

* resolve any merge conflicts :-)

* update the debian/changelog (add new paragraph, and reset the version)

  You may use `debchange` to that, it will automatically update the
  `debian-revision` and set the correct date:

  ```
  DEBEMAIL=dev@ubicast.eu DEBFULLNAME="UbiCast team" dch -v 1.22.X-deb12+ubicast1
  # add your changelog then to finalize,
  DEBEMAIL=dev@ubicast.eu DEBFULLNAME="UbiCast team" dch -r
  ```

* commit the new `debian/changelog`

* push the updated branch: ``git push --force-with-lease``

This way we keep a clean history which show our modification on top.

The `debian-version` will be increased and the `debian-revision` reset to 1

As this operation will rewrite history you may add a tag `ubicast-X.Y.Z` before
the rebase, so that we can still restore the old version. (do not forget to push
it to the server).

For instance before updating from 1.22.1 -> 1.22.2 a tag `ubicast-1.22.1` can be
set.

#### Upgrading to a new GStreamer stable branch

A new branch shall be created from the new stable tag UbiCast modification shall
be applied on it.

It generally consists in:

* fetching the upstream: ``git fetch --all upstream``

* create  a new stable branch from the new upstream branch: ``git switch --no-track -c X.Y+ubicast+bookworm upstream/X.Y``, e.g. ``git switch --no-track -c 1.22+ubicast+bookworm upstream/1.22``

* rebase the needed commit onto this branch: ``git rebase -i --onto X.Y+ubicast+bookworm X.(Y-1).Z X.(Y-1)+ubicast+bookworm``

  With:
  `X.(Y-1).Z`: the "last" bugfix tag from the previous branch, for instance when
  updating to 1.24: is will be 1.22.6 (if 1.22.6 is the latest tag)

  During this step some backport commits shall disappear

* update the debian/changelog, change the version

  You may use `debchange` to that, it will automatically set the correct date,
  but you have to set the new version, ex:

  ```
  DEBEMAIL=dev@ubicast.eu DEBFULLNAME="UbiCast team" dch -r -v 1.22.6-deb12-ubuntu1
  ```

  > **Note:** The convention is to reset `debian-revion` number to 1 on upstream
  > change (so we reset to `deb12-ubuntu1`)

* commit the new `debian/changelog`

* push the updated branch: ``git push origin``
