################################################################################
#
# qrtr
#
################################################################################

QRTR_VERSION = cd6bedd5d00f211e6c1e3803ff2f9f53c246435e
QRTR_SITE = $(call github,andersson,qrtr,$(QRTR_VERSION))
QRTR_LICENSE = PROPRIETARY
QRTR_LICENSE_FILES = LICENSE

define QRTR_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)"
endef

define QRTR_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) prefix=$(STAGING_DIR) -C $(@D) install
endef

define QRTR_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) prefix=$(TARGET_DIR) -C $(@D) install
endef

define QRTR_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(@D)/$(QRTR_SUBDIR)/qrtr-ns.service \
		$(TARGET_DIR)/usr/lib/systemd/system/qrtr-ns.service
	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
	ln -sf ../../../../usr/lib/systemd/system/qrtr-ns.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/qrtr-ns.service
endef

$(eval $(generic-package))
