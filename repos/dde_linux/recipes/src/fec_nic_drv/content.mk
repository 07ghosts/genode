LIB_MK := lib/mk/fec_nic_include.mk \
          lib/mk/spec/arm/lx_kit_setjmp.mk

PORT_DIR := $(call port_dir,$(REP_DIR)/ports/dde_linux)

MIRROR_FROM_REP_DIR := $(LIB_MK) \
                       lib/import/import-fec_nic_include.mk \
                       src/include src/lx_kit \
                       src/drivers/usb/include/spec/arm/platform_device/platform_device.h \
                       $(shell cd $(REP_DIR); find src/drivers/nic/fec -type f)

MIRROR_FROM_PORT_DIR := $(shell cd $(PORT_DIR); find src/drivers/nic/fec -type f | grep -v ".git")
MIRROR_FROM_PORT_DIR := $(filter-out $(MIRROR_FROM_REP_DIR),$(MIRROR_FROM_PORT_DIR))

content: $(MIRROR_FROM_REP_DIR) $(MIRROR_FROM_PORT_DIR)

$(MIRROR_FROM_REP_DIR):
	$(mirror_from_rep_dir)

$(MIRROR_FROM_PORT_DIR):
	mkdir -p $(dir $@)
	cp $(PORT_DIR)/$@ $@

content: LICENSE
LICENSE:
	( echo "GNU General Public License version 2, see:"; \
	  echo "https://www.kernel.org/pub/linux/kernel/COPYING" ) > $@
