megatools - command line client application for Mega
====================================================

Megatools is a collection of programs for accessing Mega service from a command
line of your desktop or server.

Megatools allow you to copy individual files as well as entire directory trees
to and from the cloud. You can also perform streaming downloads for example to
preview videos and audio files, without needing to download the entire file.

Megatools are robust and optimized for fast operation - as fast as Mega servers
allow. Memory requirements and CPU utilization are kept at minimum. Megatools
can upload 70MiB/s and download 80 MiB/s on a cheap single core Intel based VPS.

You can register mega account using the 'megatools reg' tool, with the benefit
of having true control of your encryption keys, compared to using mega.nz web
client. Anything done in the web browser uses a code you don't have control over
(unless it's your own website), and thus can't be fully trusted with your
password.

Mega website can be found at https://mega.nz.

Megatools official website is at https://megatools.megous.com


Tools
=====

  reg      Register and verify a new mega account
  df       Show your cloud storage space usage/quota
  ls       List all remote files
  test     Test for existence of remote files or folders
  export   Create public links for remote files
  mkdir    Create remote directory
  rm       Remove remote file or directory
  put      Upload individual files
  get      Download individual files
  dl       Download file from a "public" Mega link
           (doesn't require login)
  copy     Upload or download a directory tree


All of these tools do:

- Local caching of remote session/filesystem information
  for faster execution. Cache is encrypted with your password key.
- Support loading login credentials from a configuration file.


Usage
=====

See the man pages for how to use individual tools:

  man megatools

Man pages are also available online at:

  https://megatools.megous.com/man/megatools.html


Installation on Windows
=======================

Official builds for 32bit and 64bit Windows are avaialbe at:

  https://megatools.megous.com
  https://megatools.megous.com/builds/experimental/

Megatools is also available on Windows via Chocolatey thanks to ERap320.
See:

  https://chocolatey.org/packages/megatools/

You can contact the chockolatey package maintainer here:

  https://github.com/megous/megatools/issues/347


Installation on macOS
=====================

Thanks to Carl Moden, megatools is available in Homebrew (http://brew.sh/).

You can therefore install megatools with:

  brew install megatools


Installation on your favorite GNU/Linux distribution
====================================================

Megatools may already be pre-packaged in the package repository
of your distribution. It is already available at least in:

- Arch Linux (AUR) - https://aur.archlinux.org/packages/megatools/
- Debian - https://packages.debian.org/sid/megatools
- Fedora - https://admin.fedoraproject.org/pkgdb/package/rpms/megatools/
- Gentoo - https://packages.gentoo.org/packages/net-misc/megatools
- openSUSE - https://software.opensuse.org/package/megatools
- Ubuntu - https://packages.ubuntu.com/cosmic/megatools

Be sure to check your distribution's package repository first.


Installation on FreeBSD
=======================

Megatools is available in ports thanks to Maxim V. Kostikov:

  https://www.freshports.org/net/megatools/


Using a static build for Linux
==============================

Experimental static build is available since version 1.11.0. This build provides
a single megatools binary that can be copied to any GNU/Linux distribution and
run from there. It is reported that you can even copy an ARM build to your
Android smartphone and run it from your phone.

This build is useful if you want to avoid the hassle of bulding megatools on old
distributions like older versions of CentOS or RedHat.

Static builds are available here:

  https://megatools.megous.com/builds/experimental/


Building megatools from source code
===================================

The official source code tarball is available at:

   http://megatools.megous.com/builds/

You should check that the code was released by me by verifying PGP signatures
provided alongside the code.

You will need to install a few dependnencies before you can build megatools from
source code. Package names of these dependencies differ depending on your
GNU/Linux distribution.

Runtime dependencies are: glib2, libcurl and openssl

Build time dependencies are: gcc, make, pkg-config (pkgconf)


On Debian, Ubuntu:

  apt-get -y install build-essential libglib2.0-dev libssl-dev \
    libcurl4-openssl-dev

  If you want to build man pages, too, you need to:

    apt install asciidoc docbook2x --no-install-recommends

  or disable the build of man pages via meson -Dman=false option.

On Fedora and CentOS:

  yum -y install gcc make glib2-devel libcurl-devel openssl-devel

On OpenSUSE:

  zypper -n install gcc make glib2-devel libcurl-devel openssl-devel

On Arch Linux:

  pacman -Sy --noconfirm --needed pkgconf gcc make glib2 curl

On Alpine Linux:

  apk add --update build-base libcurl curl-dev asciidoc openssl-dev glib-dev \
    glib libtool automake autoconf

WARNING: Newer versions of megatools use meson build system. Build steps
are different for meson.

You can build megatools into your HOME directory, so that they'll not pollute
your /usr or /usr/local by using --prefix $HOME/.local option to meson.

Example build steps:

  wget https://megatools.megous.com/builds/megatools-1.11.0.tar.gz{,.asc}
  gpg --verify megatools-1.11.0.tar.gz.asc
  tar xf megatools-1.11.0.tar.gz
  cd megatools-1.11.0
  meson setup --prefix $HOME/.local .build
  ninja -C .build
  ninja -C .build install

If you encounter issues, read the error messages carefully. They may contain
hints on how you can solve the issue yourself (missing dependencies, missing
C compiler build flags, etc.).

Now you can run megatools from ~/.local/bin.

  export PATH="$HOME/.local/bin:$PATH"
  megatools ls


Building megatools from git repository and contributing code
============================================================

Megatools use meson build system. See https://mesonbuild.com/

Build steps for meson are:

  git clone https://megous.com/git/megatools
  cd megatools
  meson setup .build
  ninja -C .build
  sudo ninja -C .build install

You may need to install dependencies listed above in the previous section.


Third party tools/scripts
=========================

Megatools are meant as a low-level tools that can be used as a base to create
more complicated tools for working with mega.nz. Other people have created
a third party scripts on top of megatools. If you're one of them and want to
have your project listed here, let me know.

Some third party tools can be found at:

  https://amourspirit.github.io/mega_scripts/


Author
======

Megatools were written by Ondřej Jirman <megatools@megous.com>, 2013-2022

My PGP key can be found at: https://megous.com/key.txt
  (Fingerprint is: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED)

Official website is: https://megatools.megous.com


Contributors
============

- Alberto Garcia <berto@igalia.com>
- aurelien <aurelien.antunes@gmail.com>
- bAndie91 <bandie9100@gmail.com>
- Chris Tarazi <tarazichris@gmail.com>
- cyrozap <cyrozap@gmail.com>
- Dal1a <waveh@trimsj.com>
- David Guillen Fandos <david@davidgf.net>
- Erik Nordstrøm <erik@nordstroem.no>
- ivesen <ivesen@ivesen.moe>
- Johnathan Jenkins <john@nixheads.co.uk>
- Kagami Hiiragi <kagami@genshiken.org>
- Matthew Schultz <mattsch@gmail.com>
- Mert Dirik <mertdirik@gmail.com>
- Michael Ledin <mledin89@gmail.com>
- Michael Ripley <zkxs00@gmail.com>
- nyuszika7h <nyuszika7h@gmail.com>
- Palmer Dabbelt <palmer@dabbelt.com>
- protomouse <root@protomou.se>
- RealDolos <dolos@cock.li>
- strupo <sheeit@users.noreply.github.com>
- taiyu <taiyu.len@gmail.com>
- Tom Maneiro <tomman@tsdx.net.ve>
- Viktor (Icon) VAD <vad.viktor@gmail.com>
- wdlkmpx <wdlkmpx@gmail.com>


Support and bug reports
=======================

If you think you've found bug in megatools, send a report including enough
information for recreating the issue to: megatools@megous.com Your message
will end up in a public archive, so be careful what you say, or infomration
you send.

I respond to most e-mails, so if you are not getting a response within a few
days, check your spam folder.


License
=======

Megatools are licensed under GPLv2 with OpenSSL exemption, see LICENSE
file for details.

This product includes software developed by the OpenSSL Project for use
in the OpenSSL Toolkit. (http://www.openssl.org/)
