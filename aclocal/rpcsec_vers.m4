dnl Checks librpcsec version
AC_DEFUN([AC_RPCSEC_VERSION], [

  PKG_CHECK_MODULES([GSSGLUE], [libgssglue >= 0.3])

  save_LIBS=$LIBS
  LIBS="$LIBS $GSSGLUE_LIBS"
  AC_LINK_IFELSE([AC_LANG_CALL([], [gss_set_allowable_enctypes])],
		 AC_DEFINE(HAVE_SET_ALLOWABLE_ENCTYPES, 1, [Define this if the GSS library supports gss_set_allowable_enctypes]))
  LIBS=$save_LIBS

  dnl TI-RPC replaces librpcsecgss
  if test "$enable_tirpc" = no; then
    PKG_CHECK_MODULES([RPCSECGSS], [librpcsecgss >= 0.16])
  fi

])dnl
