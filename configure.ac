#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([Plethora], [0.0.1], [amagura28@gmail.com],, [https://github.com/amagura/plethora/issues])
#AC_CONFIG_SRCDIR([test.c])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_AUX_DIR([build-aux])

# Check for system extensions
AC_USE_SYSTEM_EXTENSIONS

# Check for targets
AC_CANONICAL_BUILD
AC_CANONICAL_HOST
AC_CANONICAL_TARGET

# M4 Code
m4_define([pl_natsolaris], [AS_CASE([$pl_build_type], [native::x*solaris*], [$1], [])])
m4_define([pl_natbsd], [AS_CASE([$pl_build_type], [native::x*bsd*], [$1], [])])

m4_define([pl_natsolaris_blk], [if echo "x$pl_build_type" | $ac_cv_path_GREP -q -- 'xnative::x.*solaris.*'; then])
m4_define([pl_natsolaris_klb], [fi])

m4_define([pl_natbsd_blk], [if echo "x$pl_build_type" | $ac_cv_path_GREP -q -- 'xnative::x.*bsd.*'; then])
m4_define([pl_natbsd_klb], [fi])

m4_define([pl_natnix_blk], [if echo "x$pl_build_type" | $ac_cv_path_EGREP -q -- 'xnative::x.*(bsd|linux|solaris).*'; then])
m4_define([pl_natnix_klb], [fi])

m4_define([pl_natunix_blk], [if echo "x$pl_build_type" | $ac_cv_path_EGREP -q -- 'xnative::x.*(bsd|solaris).*'; then])
m4_define([pl_natunix_klb], [fi])

m4_define([pl_natlinux_blk], [if echo "x$pl_build_type" | $ac_cv_path_GREP -q -- 'xnative::x.*linux.*'; then])
m4_define([pl_natlinux_klb], [fi])

m4_define([pl_natmswin_blk], [if echo "x$pl_build_type" | $ac_cv_path_EGREP -q -- 'xnative::x.*(cygwin|mingw32).*'; then])
m4_define([pl_natmswin_klb], [fi])

m4_define([pl_crnat_mswin_blk], [if echo "x$pl_build_type" | $ac_cv_path_EGREP -q -- 'xcross-native::x.*(cygwin|mingw32).*'; then])
m4_define([pl_crnat_mswin_klb], [fi])

#m4_define([pl_ncc_nix_blk], [m4_define([__argc__], [$#])
  #m4_if([__argc__], [0], [if echo "x$pl_build_type" | $ac_cv_path_EGREP


m4_define([pl_grep], [echo "$1" | $ac_cv_path_EGREP -q -- m4_shift($@)])

# Check if we are cross compiling
#AS_IF([test "x$build" = "x$host" = "x$target"],
      #[pl_build_type="native::x$host"],
      #AS_IF([test "x$build" = "x$host"],
            #[test "x$host" != "x$target"]
if test "x$build" = "x$host" \
  && test "x$host" = "x$target"; then
  pl_build_type="native::x$host"
elif test "x$build" = "x$host" \
  && test "x$host" != "x$target"; then
  pl_build_type="cross::x$target"
elif test "x$build" != "x$host" \
  && test "x$build" != "x$target" \
  && test "x$host" != "x$target"; then
  pl_build_type="canadian::x$build::x$host::x$target"
elif test "x$build" != "$host" \
  && test "x$host" = "x$target" \
  && test "x$build" != "$target"; then
  pl_build_type="cross-native::x$build::x$host::x$target"
fi

AS_CASE([$pl_build_type],
          [native::*linux*|native::*bsd*|native::*solaris*],[
           AC_PROG_CC
           AC_PROG_CC_STDC
           PKG_PROG_PKG_CONFIG()
           [break]
          ],
          [native::*cygwin*|native::*mingw*],[
           AC_PROG_CXX
           [break]
          ],)

dnl I only really need to support cross-building for windows

# Checks for programs.
AC_PROG_INSTALL
AC_PATH_PROGS_FEATURE_CHECK([GREP], [grep ggrep], [[echo 'a' | ac_cv_path_GREP -q -- 'a']])
AC_PATH_PROGS_FEATURE_CHECK([EGREP], [egrep gegrep], [[echo 'a' | ac_cv_path_EGREP -q -- 'a']])

# Checks for libraries.
dnl FIXME passing --with-x to configure.ac actually disables X Server support
AC_ARG_WITH([x],
            AS_HELP_STRING([--without-x],
                           [disable x server support (default: enabled)])
            AS_HELP_STRING([],
                           [supported options:
                                                gtk3], [15], [30]),
            [with_x=no],
            [with_x=gtk3])

pl_natnix_blk
if test "x$with_x" != "xno"; then
  AC_ARG_VAR([CYTHON], [Cython to C compiler (only used when '--with-x' is present)])
  AC_CHECK_PROGS([CYTHON], [cython cython3 cython38 cython-3.8 cython37 cython-3.7 cython36 cython-3.6 cython35 cython-3.5], [no])
  if test "x$CYTHON" = "xno"; then
    AC_MSG_ERROR([Cython is a make dependency for X server support.])
  fi
  if pl_grep([$ac_cv_prog_CYTHON], ['.*cython.*$']); then
    [python_found=yes]
    PKG_CHECK_MODULES([PYTHON], [python-3.8],,[python_found=no])
    if test "x$python_found" = "xno"; then
      PKG_CHECK_MODULES([PYTHON], [python-3.7],[python_found=yes],)
    fi
    if test "x$python_found" = "xno"; then
      PKG_CHECK_MODULES([PYTHON], [python-3.6],[python_found=yes],)
    fi
    if test "x$python_found" = "xno"; then
      PKG_CHECK_MODULES([PYTHON], [python >= 3.5],,AC_MSG_ERROR([Python is a make dependency for X server support.]))
    fi
  fi

  if test "x$with_x" = "xgtk3"; then
    PKG_CHECK_MODULES([GTK3], [gtk+-3.0 >= 3.0], AC_DEFINE([WITH_GTK3], [1], [Defined when gtk3 is present.]))
  # elif test "x$with_x" = "xgtk2"; then
  #     PKG_CHECK_MODULES([GTK2], [gtk+-2.0 >= 2.0], AC_DEFINE([WITH_GTK2], [1], [Defined when gtk2 is present.]))
  fi
fi
pl_natnix_klb
#AS_IF([test "x$with_X" != "xno" && test "x$with_X" = "xgtk3"],
      #[PKG_CHECK_MODULES([gtk3], [gtk+-3.0 >= 3.0], AC_DEFINE([HAVE_GTK3], [1], [Define if gtk3 is present.]))])
#AS_IF([test "x$with_X" != "xno" && test "x$with_X" = "xgtk2"],
      #[PKG_CHECK_MODULES([gtk2], [gtk+-2.0 >= 2.0], AC_DEFINE([HAVE_GTK2], [1], [Define if gtk2 is present.]))])


# Check for needed items.
#AS_CASE([$pl_build_type],
        #[native::x*solaris*],[AC_CHECK_HEADERS(

# Checks for header files.
AC_CHECK_HEADERS([limits.h stdlib.h string.h])
pl_natsolaris([AC_CHECK_HEADERS([sys/pm.h])])

pl_natunix_blk
  # FIXME, only solaris and openbsd actually need ioctl
  AC_CHECK_HEADERS([sys/ioctl.h])
pl_natunix_klb

pl_crnat_mswin_blk
[mswin=false]
  AC_CHECK_HEADERS([{W,w}indows.h {W,w}inapifamily.h \
                    _mingw_unicode.h specstrings.h \
                    {s,S}hellapi.h],
                      [mswin=true],
                      ,
                      [[#ifdef HAVE_WINDOWS_H
                        # include <Windows.h>
                        # include <windows.h>
                        #endif
                        #ifdef HAVE_WINAPIFAMILY_H
                        # include <winapifamily.h>
                        #endif
                        #ifdef HAVE__MINGW_UNICODE_H
                        # include <_mingw_unicode.h>
                        #endif
                        #ifdef HAVE_SPECSTRINGS_H
                        # include <specstrings.h>
                        #endif
                        #ifdef HAVE_SHELLAPI_H
                        # include <shellapi.h>
                        #endif
                      ]])
pl_crnat_mswin_klb

# Checks for typedefs, structures, and compiler characteristics.
AC_CHECK_HEADER_STDBOOL
AC_TYPE_SIZE_T

# Checks for library functions.
AC_FUNC_MALLOC
AC_CHECK_FUNCS([bzero memmove mempcpy memset strchr strerror strtol])

pl_natnix_blk
  AC_ARG_WITH([commoner],
              AS_HELP_STRING([--without-commoner],
                             [disable support for libcommoner (default: enabled)]),
              [with_commoner=no],
              [with_commoner=check])

  AC_SEARCH_LIBS([nearbyint], [m],
                 ,
                 [AC_MSG_ERROR([nearbyint is not defined by libm: use a C99 compliant compiler])])

  # add support for libcommoner
  LIBCOMMONER=
  AS_IF([test "x$with_commoner" != xno],
        [AC_SEARCH_LIBS([concatm],
                        [commoner],
                        AC_DEFINE([HAVE_LIBCOMMONER], [1], [Defined when libcommoner is present]),
                        [if test "x$with_commoner" != xcheck; then
                           AC_MSG_FAILURE([--with-commoner was given, but test for commoner failed])
                         fi
                        ])])
        #[AC_CHECK_LIB([commoner], [concatm],
                      #[AC_SUBST([LIBCOMMONER], ["-lcommoner"])
                       #AC_DEFINE([HAVE_LIBCOMMONER], [1])
                      #],
                      #[if test "x$with_commoner" != xcheck; then
                        #AC_MSG_FAILURE([--with-commoner was given, but test for commoner failed])
                        #fi
                      #], -commoner)])

  #if test "x$with_commoner" == "xyes"; then
    #AC_SEARCH_LIBS([concatm],
                   #[commoner],
                   #AC_DEFINE([HAVE_CONCATM], [1]),)
  #fi
pl_natnix_klb

pl_natbsd_blk
  AC_CHECK_FUNCS([sysctlbyname],
                ,
                AC_SEARCH_LIBS([sysctlbyname],
                               [c],
                               [AC_DEFINE([HAVE_SYSCTLBYNAME], [1])],
                               [AC_MSG_WARN([*BSD systems without 'sysctlbyname' are not supported.])]))
pl_natbsd_klb

# Check for files.
pl_natlinux_blk
  AC_CHECK_FILES([/sys/class/power_supply],
                 ,
                 AC_CHECK_FILES([/proc/acpi/ac_adapter],
                                [AC_MSG_WARN([Support for kernels older than 2.6.24 is experimental])],
                                [AC_MSG_ERROR([Linux kernels without '/proc/acpi' or '/sys/class/power_supply' are not supported.])]))
  ## Check for Linux specific headers
  AC_CHECK_HEADERS([glob.h])

  ## Check for Linux specific functions
  AC_CHECK_FUNCS([globfree],
                  ,
                  [AC_SEARCH_LIBS([globfree],
                                [c android-glob],
                                [AC_DEFINE([HAVE_GLOBFREE], [1])],
                                [AC_MSG_ERROR([Linux systems without 'globfree' are not supported.])])])
pl_natlinux_klb

AC_CONFIG_FILES([Makefile
                 src/Makefile
                 ])
#########
# Options
#########
AC_ARG_ENABLE([debug],
              [  --enable-debug		turn on debugging (default: disabled)],
              [case "${enableval}" in
               yes) debug=true ;;
               no) debug=false ;;
               *) AC_MSG_WARN([bad value '${enableval}' for --enable-debug]) ;;
             esac],[debug=no])

test "x$debug" = "xno" && no_debug=false
test "x$debug" = "xfalse" && no_debug=true

#AC_CONFIG_SUBDIRS([old
                   #src/test])
# Automake directives
dnl `foreign' prevents autotools from installing a copy of the GPL
dnl `-Wall' gets rid of unnecessary warnings
AM_INIT_AUTOMAKE([foreign -Wall])

AM_CONDITIONAL([X], [test "x$with_x" != "xno"])
AM_CONDITIONAL([NATIVE], [test "x$native" = "xtrue"])
AM_CONDITIONAL([GENERIC], [test "x$generic" = "xtrue"])
AM_CONDITIONAL([STATIC], [test "x$static" = "xtrue"])
AM_CONDITIONAL([DEBUG], [test "x$debug" = "xtrue"])
AM_CONDITIONAL([NO_DEBUG], [test "x$debug" != "xtrue"])
AM_CONDITIONAL([MSWIN], [test "x$mswin" = "xtrue"])
AM_CONDITIONAL([TEST], [test "x$testdir" = "xtrue"])
m4_define([CLANG], [test "x`echo __clang__ | $CC -E -w -P -nostdinc -`" = "x"])
# XXX I'm guessing that tinyc doesn't expand __TINYC__ to a predictable value
# so instead of checking for a value, we're checking to see if the compiler doesn't expand
# __TINYC__ to anything; if it doesn't, then we know we're not using TINYC, so if it does, we know
# that we're using TINYC
m4_define([TINYC], [test ! "x`echo __TINYC__ | $CC -E -w -P -nostdinc -`" = "x__TINYC__"])
AM_CONDITIONAL([CPU_KNOWN], [test ! "x$CPUARCH" = "x" && test ! "x$CPUARCH" = "xunknown" && (]CLANG[ || ]TINYC[)])

AC_OUTPUT
