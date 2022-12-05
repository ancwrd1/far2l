################################################################################
#
# far2l
#
################################################################################

FAR2L_VERSION = master
FAR2L_SITE = $(call github,elfmz,far2l,$(FAR2L_VERSION))
FAR2L_LICENSE = GPL-2
FAR2L_LICENSE_FILES = LICENSE.txt
FAR2L_INSTALL_STAGING = YES

FAR2L_DEPENDENCIES =

ifeq ($(BR2_PACKAGE_FAR2L_COLORER),y)
FAR2L_DEPENDENCIES += spdlog xerces
endif

ifeq ($(BR2_PACKAGE_FAR2L_MULTIARC),y)
FAR2L_DEPENDENCIES += pcre2 libarchive
endif

ifeq ($(BR2_PACKAGE_FAR2L_NETROCKS),y)
FAR2L_DEPENDENCIES += libssh libnfs libopenssl
endif

ifeq ($(BR2_PACKAGE_FAR2L_INSIDE),y)
FAR2L_DEPENDENCIES += elfutils
endif

# 'neon' needed for NetRocks/WebDAV broken in buildroot (nov 2022)
# 'uchardet' absent in buildroot (nov 2022)

FAR2L_CONF_OPTS = \
	-DTTYX=$(if $(BR2_PACKAGE_FAR2L_TTYXI),ON,OFF) \
	-DTTYXi=$(if $(BR2_PACKAGE_FAR2L_TTYXI),ON,OFF) \
	-DALIGN=$(if $(BR2_PACKAGE_FAR2L_ALIGN),ON,OFF) \
	-DAUTOWRAP=$(if $(BR2_PACKAGE_FAR2L_AUTOWRAP),ON,OFF) \
	-DCALC=$(if $(BR2_PACKAGE_FAR2L_CALC),ON,OFF) \
	-DCOLORER=$(if $(BR2_PACKAGE_FAR2L_COLORER),ON,OFF) \
	-DCOMPARE=$(if $(BR2_PACKAGE_FAR2L_COMPARE),ON,OFF) \
	-DDRAWLINE=$(if $(BR2_PACKAGE_FAR2L_DRAWLINE),ON,OFF) \
	-DEDITCASE=$(if $(BR2_PACKAGE_FAR2L_EDITCASE),ON,OFF) \
	-DEDITORCOMP=$(if $(BR2_PACKAGE_FAR2L_EDITORCOMP),ON,OFF) \
	-DFILECASE=$(if $(BR2_PACKAGE_FAR2L_FILECASE),ON,OFF) \
	-DINCSRCH=$(if $(BR2_PACKAGE_FAR2L_INCSRCH),ON,OFF) \
	-DINSIDE=$(if $(BR2_PACKAGE_FAR2L_INSIDE),ON,OFF) \
	-DMULTIARC=$(if $(BR2_PACKAGE_FAR2L_MULTIARC),ON,OFF) \
	-DNETROCKS=$(if $(BR2_PACKAGE_FAR2L_NETROCKS),ON,OFF) \
	-DSIMPLEINDENT=$(if $(BR2_PACKAGE_FAR2L_SIMPLEINDENT),ON,OFF) \
	-DTMPPANEL=$(if $(BR2_PACKAGE_FAR2L_TMPPANEL),ON,OFF) \
	-DUSEUCD=OFF -DUSEWX=OFF -DNR_WEBDAV=OFF

ifeq ($(BR2_PACKAGE_MUSL),y)
FAR2L_CONF_OPTS += -DMUSL=ON
endif

ifeq ($(BR2_PACKAGE_BUSYBOX),y)
FAR2L_CONF_OPTS += -DTAR_LIMITED_ARGS=ON
endif

$(eval $(cmake-package))
