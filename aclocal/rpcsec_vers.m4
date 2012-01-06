dnl Checks librpcsec version
AC_DEFUN([AC_RPCSEC_VERSION], [

  PKG_CHECK_MODULES([GSSGLUE], [libgssglue >= 0.3])

  save_LIBS=$LIBS
  LIBS="$LIBS $GSSGLUE_LIBS"
  AC_LINK_IFELSE([AC_LANG_CALL([], [gss_set_allowable_enctypes])],
		 AC_DEFINE(HAVE_SET_ALLOWABLE_ENCTYPES, 1, [Define this if the GSS library supports gss_set_allowable_enctypes]))

  AC_LINK_IFELSE([AC_LANG_CALL([], [gss_export_lucid_sec_context])],
		 AC_DEFINE(HAVE_LUCID_CONTEXT_SUPPORT, 1, [Define this if the GSS library supports gss_export_lucid_sec_context]))

  AC_LINK_IFELSE([AC_LANG_CALL([], [gss_inquire_sec_context_by_oid])],
		 AC_DEFINE(HAVE_INQUIRE_SEC_CONTEXT_BY_OID, 1, [Define this if the GSS library supports gss_inquire_sec_context_by_oid]))
  LIBS=$save_LIBS

  dnl TI-RPC replaces librpcsecgss
  if test "$enable_tirpc" = no; then
    PKG_CHECK_MODULES([RPCSECGSS], [librpcsecgss >= 0.16])
  fi

])dnl
