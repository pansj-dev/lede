#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

OTHER_MENU:=Other modules

WATCHDOG_DIR:=watchdog


define KernelPackage/6lowpan
  SUBMENU:=$(OTHER_MENU)
  TITLE:=6LoWPAN shared code
  KCONFIG:= \
	CONFIG_6LOWPAN \
	CONFIG_6LOWPAN_NHC=n
  FILES:=$(LINUX_DIR)/net/6lowpan/6lowpan.ko
  AUTOLOAD:=$(call AutoProbe,6lowpan)
endef

define KernelPackage/6lowpan/description
  Shared 6lowpan code for IEEE 802.15.4 and Bluetooth.
endef

$(eval $(call KernelPackage,6lowpan))


define KernelPackage/bluetooth
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Bluetooth support
  DEPENDS:=@USB_SUPPORT +kmod-crypto-cmac +kmod-crypto-ecb \
	+kmod-crypto-ecdh +kmod-crypto-hash +kmod-hid +kmod-lib-crc16 \
	+kmod-regmap-core +kmod-serdev +kmod-usb-core
  KCONFIG:= \
	CONFIG_BT \
	CONFIG_BT_BREDR=y \
	CONFIG_BT_DEBUGFS=n \
	CONFIG_BT_LE=y \
	CONFIG_BT_RFCOMM \
	CONFIG_BT_BNEP \
	CONFIG_BT_HCIBTUSB \
	CONFIG_BT_HCIBTUSB_BCM=y \
	CONFIG_BT_HCIBTUSB_MTK=y \
	CONFIG_BT_HCIBTUSB_RTL=y \
	CONFIG_BT_HCIUART \
	CONFIG_BT_HCIUART_BCM=y \
	CONFIG_BT_HCIUART_INTEL=n \
	CONFIG_BT_HCIUART_H4 \
	CONFIG_BT_HCIUART_NOKIA=n \
	CONFIG_BT_HCIUART_QCA=y \
	CONFIG_BT_HCIUART_SERDEV=y \
	CONFIG_BT_HIDP
  $(call AddDepends/rfkill)
  FILES:= \
	$(LINUX_DIR)/net/bluetooth/bluetooth.ko \
	$(LINUX_DIR)/net/bluetooth/rfcomm/rfcomm.ko \
	$(LINUX_DIR)/net/bluetooth/bnep/bnep.ko \
	$(LINUX_DIR)/net/bluetooth/hidp/hidp.ko \
	$(LINUX_DIR)/drivers/bluetooth/hci_uart.ko \
	$(LINUX_DIR)/drivers/bluetooth/btusb.ko \
	$(LINUX_DIR)/drivers/bluetooth/btbcm.ko \
	$(LINUX_DIR)/drivers/bluetooth/btqca.ko \
	$(LINUX_DIR)/drivers/bluetooth/btrtl.ko \
	$(LINUX_DIR)/drivers/bluetooth/btintel.ko \
	$(LINUX_DIR)/drivers/bluetooth/btmtk.ko@ge5.17
  AUTOLOAD:=$(call AutoProbe,bluetooth rfcomm bnep hidp hci_uart btusb)
endef

define KernelPackage/bluetooth/description
 Kernel support for Bluetooth devices
endef

$(eval $(call KernelPackage,bluetooth))

define KernelPackage/ath3k
  SUBMENU:=$(OTHER_MENU)
  TITLE:=ATH3K Kernel Module support
  DEPENDS:=+kmod-bluetooth +ar3k-firmware
  KCONFIG:= \
	CONFIG_BT_ATH3K \
	CONFIG_BT_HCIUART_ATH3K=y
  FILES:= \
	$(LINUX_DIR)/drivers/bluetooth/ath3k.ko
  AUTOLOAD:=$(call AutoProbe,ath3k)
endef

define KernelPackage/ath3k/description
 Kernel support for ATH3K Module
endef

$(eval $(call KernelPackage,ath3k))


define KernelPackage/bluetooth-6lowpan
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Bluetooth 6LoWPAN support
  DEPENDS:=+kmod-6lowpan +kmod-bluetooth
  KCONFIG:=CONFIG_BT_6LOWPAN
  FILES:=$(LINUX_DIR)/net/bluetooth/bluetooth_6lowpan.ko
  AUTOLOAD:=$(call AutoProbe,bluetooth_6lowpan)
endef

define KernelPackage/bluetooth-6lowpan/description
 Kernel support for 6LoWPAN over Bluetooth Low Energy devices
endef

$(eval $(call KernelPackage,bluetooth-6lowpan))


define KernelPackage/btmrvl
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Marvell Bluetooth Kernel Module support
  DEPENDS:=+kmod-mmc +kmod-bluetooth +mwifiex-sdio-firmware
  KCONFIG:= \
	CONFIG_BT_MRVL \
	CONFIG_BT_MRVL_SDIO
  FILES:= \
	$(LINUX_DIR)/drivers/bluetooth/btmrvl.ko \
	$(LINUX_DIR)/drivers/bluetooth/btmrvl_sdio.ko
  AUTOLOAD:=$(call AutoProbe,btmrvl btmrvl_sdio)
endef

define KernelPackage/btmrvl/description
 Kernel support for Marvell SDIO Bluetooth Module
endef

$(eval $(call KernelPackage,btmrvl))


define KernelPackage/btsdio
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Bluetooth HCI SDIO driver
  DEPENDS:=+kmod-bluetooth +kmod-mmc
  KCONFIG:= \
	CONFIG_BT_HCIBTSDIO
  FILES:= \
	$(LINUX_DIR)/drivers/bluetooth/btsdio.ko
  AUTOLOAD:=$(call AutoProbe,btsdio)
endef

define KernelPackage/btsdio/description
 Kernel support for Bluetooth device with SDIO interface
endef

$(eval $(call KernelPackage,btsdio))


define KernelPackage/dma-buf
  SUBMENU:=$(OTHER_MENU)
  TITLE:=DMA shared buffer support
  HIDDEN:=1
  KCONFIG:=CONFIG_DMA_SHARED_BUFFER
  ifeq ($(strip $(CONFIG_EXTERNAL_KERNEL_TREE)),"")
    ifeq ($(strip $(CONFIG_KERNEL_GIT_CLONE_URI)),"")
      FILES:=$(LINUX_DIR)/drivers/dma-buf/dma-shared-buffer.ko
    endif
  endif
  AUTOLOAD:=$(call AutoLoad,20,dma-shared-buffer)
endef
$(eval $(call KernelPackage,dma-buf))


define KernelPackage/eeprom-93cx6
  SUBMENU:=$(OTHER_MENU)
  TITLE:=EEPROM 93CX6 support
  KCONFIG:=CONFIG_EEPROM_93CX6
  FILES:=$(LINUX_DIR)/drivers/misc/eeprom/eeprom_93cx6.ko
  AUTOLOAD:=$(call AutoLoad,20,eeprom_93cx6)
endef

define KernelPackage/eeprom-93cx6/description
 Kernel module for EEPROM 93CX6 support
endef

$(eval $(call KernelPackage,eeprom-93cx6))


define KernelPackage/eeprom-at24
  SUBMENU:=$(OTHER_MENU)
  TITLE:=EEPROM AT24 support
  KCONFIG:=CONFIG_EEPROM_AT24
  DEPENDS:=+kmod-i2c-core +kmod-regmap-i2c
  FILES:=$(LINUX_DIR)/drivers/misc/eeprom/at24.ko
  AUTOLOAD:=$(call AutoProbe,at24)
endef

define KernelPackage/eeprom-at24/description
 Kernel module for most I2C EEPROMs
endef

$(eval $(call KernelPackage,eeprom-at24))


define KernelPackage/eeprom-at25
  SUBMENU:=$(OTHER_MENU)
  TITLE:=EEPROM AT25 support
  KCONFIG:=CONFIG_EEPROM_AT25
  FILES:=$(LINUX_DIR)/drivers/misc/eeprom/at25.ko
  AUTOLOAD:=$(call AutoProbe,at25)
endef

define KernelPackage/eeprom-at25/description
 Kernel module for most SPI EEPROMs
endef

$(eval $(call KernelPackage,eeprom-at25))


define KernelPackage/google-firmware
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Google firmware drivers (Coreboot, VPD, Memconsole)
  KCONFIG:= \
	CONFIG_GOOGLE_FIRMWARE=y \
	CONFIG_GOOGLE_COREBOOT_TABLE \
	CONFIG_GOOGLE_MEMCONSOLE \
	CONFIG_GOOGLE_MEMCONSOLE_COREBOOT \
	CONFIG_GOOGLE_VPD
  FILES:= \
	  $(LINUX_DIR)/drivers/firmware/google/coreboot_table.ko \
	  $(LINUX_DIR)/drivers/firmware/google/memconsole.ko \
	  $(LINUX_DIR)/drivers/firmware/google/memconsole-coreboot.ko \
	  $(LINUX_DIR)/drivers/firmware/google/vpd-sysfs.ko
  AUTOLOAD:=$(call AutoProbe,coreboot_table memconsole-coreboot vpd-sysfs)
endef

define KernelPackage/google-firmware/description
  Kernel modules for Google firmware drivers. Useful for examining firmware and
  boot details on devices using a Google bootloader based on Coreboot. Provides
  files like /sys/firmware/log and /sys/firmware/vpd.
endef

$(eval $(call KernelPackage,google-firmware))


define KernelPackage/lkdtm
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Linux Kernel Dump Test Tool Module
  KCONFIG:=CONFIG_LKDTM
  FILES:=$(LINUX_DIR)/drivers/misc/lkdtm/lkdtm.ko
  AUTOLOAD:=$(call AutoProbe,lkdtm)
endef

define KernelPackage/lkdtm/description
 This module enables testing of the different dumping mechanisms by inducing
 system failures at predefined crash points.
endef

$(eval $(call KernelPackage,lkdtm))


define KernelPackage/pinctrl-mcp23s08
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Microchip MCP23xxx I/O expander
  HIDDEN:=1
  DEPENDS:=@GPIO_SUPPORT +kmod-regmap-core
  KCONFIG:=CONFIG_PINCTRL_MCP23S08
  FILES:=$(LINUX_DIR)/drivers/pinctrl/pinctrl-mcp23s08.ko
  AUTOLOAD:=$(call AutoLoad,40,pinctrl-mcp23s08)
endef

define KernelPackage/pinctrl-mcp23s08/description
  Kernel module for Microchip MCP23xxx I/O expander
endef

$(eval $(call KernelPackage,pinctrl-mcp23s08))


define KernelPackage/pinctrl-mcp23s08-i2c
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Microchip MCP23xxx I/O expander (I2C)
  DEPENDS:=@GPIO_SUPPORT \
	+kmod-pinctrl-mcp23s08 \
	+kmod-i2c-core \
	+kmod-regmap-i2c
  KCONFIG:=CONFIG_PINCTRL_MCP23S08_I2C
  FILES:=$(LINUX_DIR)/drivers/pinctrl/pinctrl-mcp23s08_i2c.ko
  AUTOLOAD:=$(call AutoLoad,40,pinctrl-mcp23s08-i2c)
endef

define KernelPackage/pinctrl-mcp23s08-i2c/description
  Kernel module for Microchip MCP23xxx I/O expander via I2C
endef

$(eval $(call KernelPackage,pinctrl-mcp23s08-i2c))


define KernelPackage/pinctrl-mcp23s08-spi
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Microchip MCP23xxx I/O expander (SPI)
  DEPENDS:=@GPIO_SUPPORT +kmod-pinctrl-mcp23s08
  KCONFIG:=CONFIG_PINCTRL_MCP23S08_SPI
  FILES:=$(LINUX_DIR)/drivers/pinctrl/pinctrl-mcp23s08_spi.ko
  AUTOLOAD:=$(call AutoLoad,40,pinctrl-mcp23s08-spi)
endef

define KernelPackage/pinctrl-mcp23s08-spi/description
  Kernel module for Microchip MCP23xxx I/O expander via SPI
endef

$(eval $(call KernelPackage,pinctrl-mcp23s08-spi))


define KernelPackage/ppdev
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Parallel port support
  KCONFIG:= \
	CONFIG_PARPORT \
	CONFIG_PPDEV
  FILES:= \
	$(LINUX_DIR)/drivers/parport/parport.ko \
	$(LINUX_DIR)/drivers/char/ppdev.ko
  AUTOLOAD:=$(call AutoLoad,50,parport ppdev)
endef

$(eval $(call KernelPackage,ppdev))


define KernelPackage/parport-pc
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Parallel port interface (PC-style) support
  DEPENDS:=+kmod-ppdev
  KCONFIG:= \
	CONFIG_KS0108=n \
	CONFIG_PARPORT_PC \
	CONFIG_PARPORT_1284=y \
	CONFIG_PARPORT_PC_FIFO=y \
	CONFIG_PARPORT_PC_PCMCIA=n \
	CONFIG_PARPORT_PC_SUPERIO=y \
	CONFIG_PARPORT_SERIAL=n \
	CONFIG_PARIDE=n \
	CONFIG_SCSI_IMM=n \
	CONFIG_SCSI_PPA=n
  FILES:= \
	$(LINUX_DIR)/drivers/parport/parport_pc.ko
  AUTOLOAD:=$(call AutoLoad,51,parport_pc)
endef

$(eval $(call KernelPackage,parport-pc))


define KernelPackage/lp
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Parallel port line printer device support
  DEPENDS:=+kmod-ppdev
  KCONFIG:= \
	CONFIG_PRINTER
  FILES:= \
	$(LINUX_DIR)/drivers/char/lp.ko
  AUTOLOAD:=$(call AutoLoad,52,lp)
endef

$(eval $(call KernelPackage,lp))


define KernelPackage/mmc
  SUBMENU:=$(OTHER_MENU)
  TITLE:=MMC/SD Card Support
  DEPENDS:=@!TARGET_uml
  KCONFIG:= \
	CONFIG_MMC \
	CONFIG_MMC_BLOCK \
	CONFIG_MMC_DEBUG=n \
	CONFIG_MMC_UNSAFE_RESUME=n \
	CONFIG_MMC_TIFM_SD=n \
	CONFIG_MMC_WBSD=n \
	CONFIG_SDIO_UART=n
  FILES:= \
	$(LINUX_DIR)/drivers/mmc/core/mmc_core.ko \
	$(LINUX_DIR)/drivers/mmc/core/mmc_block.ko
  AUTOLOAD:=$(call AutoProbe,mmc_core mmc_block,1)
endef

define KernelPackage/mmc/description
 Kernel support for MMC/SD cards
endef

$(eval $(call KernelPackage,mmc))


define KernelPackage/sdhci
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Secure Digital Host Controller Interface support
  DEPENDS:=+kmod-mmc
  KCONFIG:= \
	CONFIG_MMC_SDHCI \
	CONFIG_MMC_SDHCI_PLTFM \
	CONFIG_MMC_SDHCI_PCI=n
  FILES:= \
	$(LINUX_DIR)/drivers/mmc/host/sdhci.ko \
	$(LINUX_DIR)/drivers/mmc/host/sdhci-pltfm.ko

  AUTOLOAD:=$(call AutoProbe,sdhci-pltfm,1)
endef

define KernelPackage/sdhci/description
 Kernel support for SDHCI Hosts
endef

$(eval $(call KernelPackage,sdhci))


define KernelPackage/serdev
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Serial device bus support
  KCONFIG:=CONFIG_SERIAL_DEV_BUS
  FILES:= \
	$(LINUX_DIR)/drivers/tty/serdev/serdev.ko
  AUTOLOAD:=$(call AutoProbe,serdev)
endef

define KernelPackage/serdev/description
 Kernel support for devices connected via a serial port
endef

$(eval $(call KernelPackage,serdev))


define KernelPackage/rfkill
  SUBMENU:=$(OTHER_MENU)
  TITLE:=RF switch subsystem support
  DEPENDS:=@USE_RFKILL +kmod-input-core
  KCONFIG:= \
    CONFIG_RFKILL_FULL \
    CONFIG_RFKILL_GPIO=y \
    CONFIG_RFKILL_INPUT=y \
    CONFIG_RFKILL_LEDS=y
  FILES:= \
    $(LINUX_DIR)/net/rfkill/rfkill.ko \
    $(LINUX_DIR)/net/rfkill/rfkill-gpio.ko
  AUTOLOAD:=$(call AutoLoad,20,rfkill-gpio)
endef

define KernelPackage/rfkill/description
 Say Y here if you want to have control over RF switches
 found on many WiFi and Bluetooth cards
endef

$(eval $(call KernelPackage,rfkill))


define KernelPackage/softdog
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Software watchdog driver
  KCONFIG:=CONFIG_SOFT_WATCHDOG \
  	CONFIG_SOFT_WATCHDOG_PRETIMEOUT=n
  FILES:=$(LINUX_DIR)/drivers/$(WATCHDOG_DIR)/softdog.ko
  AUTOLOAD:=$(call AutoLoad,50,softdog,1)
endef

define KernelPackage/softdog/description
 Software watchdog driver
endef

$(eval $(call KernelPackage,softdog))


define KernelPackage/ssb
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Silicon Sonics Backplane glue code
  DEPENDS:=@PCI_SUPPORT @!TARGET_bcm47xx @!TARGET_bcm63xx
  KCONFIG:=\
	CONFIG_SSB \
	CONFIG_SSB_B43_PCI_BRIDGE=y \
	CONFIG_SSB_DRIVER_MIPS=n \
	CONFIG_SSB_DRIVER_PCICORE=y \
	CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y \
	CONFIG_SSB_FALLBACK_SPROM=y \
	CONFIG_SSB_PCIHOST=y \
	CONFIG_SSB_PCIHOST_POSSIBLE=y \
	CONFIG_SSB_POSSIBLE=y \
	CONFIG_SSB_SPROM=y \
	CONFIG_SSB_SILENT=y
  FILES:=$(LINUX_DIR)/drivers/ssb/ssb.ko
  AUTOLOAD:=$(call AutoLoad,18,ssb,1)
endef

define KernelPackage/ssb/description
 Silicon Sonics Backplane glue code.
endef

$(eval $(call KernelPackage,ssb))


define KernelPackage/bcma
  SUBMENU:=$(OTHER_MENU)
  TITLE:=BCMA support
  DEPENDS:=@PCI_SUPPORT @!TARGET_bcm47xx @!TARGET_bcm53xx
  KCONFIG:=\
	CONFIG_BCMA \
	CONFIG_BCMA_POSSIBLE=y \
	CONFIG_BCMA_BLOCKIO=y \
	CONFIG_BCMA_FALLBACK_SPROM=y \
	CONFIG_BCMA_HOST_PCI_POSSIBLE=y \
	CONFIG_BCMA_HOST_PCI=y \
	CONFIG_BCMA_HOST_SOC=n \
	CONFIG_BCMA_DRIVER_MIPS=n \
	CONFIG_BCMA_DRIVER_PCI_HOSTMODE=n \
	CONFIG_BCMA_DRIVER_GMAC_CMN=n \
	CONFIG_BCMA_DEBUG=n
  FILES:=$(LINUX_DIR)/drivers/bcma/bcma.ko
  AUTOLOAD:=$(call AutoLoad,29,bcma)
endef

define KernelPackage/bcma/description
 Bus driver for Broadcom specific Advanced Microcontroller Bus Architecture
endef

$(eval $(call KernelPackage,bcma))


define KernelPackage/rtc-ds1307
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Dallas/Maxim DS1307 (and compatible) RTC support
  DEFAULT:=m if ALL_KMODS && RTC_SUPPORT
  DEPENDS:=+kmod-i2c-core +kmod-regmap-i2c +kmod-hwmon-core
  KCONFIG:=CONFIG_RTC_DRV_DS1307 \
	CONFIG_RTC_CLASS=y
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-ds1307.ko
  AUTOLOAD:=$(call AutoProbe,rtc-ds1307)
endef

define KernelPackage/rtc-ds1307/description
 Kernel module for Dallas/Maxim DS1307/DS1337/DS1338/DS1340/DS1388/DS3231,
 Epson RX-8025 and various other compatible RTC chips connected via I2C.
endef

$(eval $(call KernelPackage,rtc-ds1307))


define KernelPackage/rtc-ds1374
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Dallas/Maxim DS1374 RTC support
  DEFAULT:=m if ALL_KMODS && RTC_SUPPORT
  DEPENDS:=+kmod-i2c-core
  KCONFIG:=CONFIG_RTC_DRV_DS1374 \
	CONFIG_RTC_DRV_DS1374_WDT=n \
	CONFIG_RTC_CLASS=y
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-ds1374.ko
  AUTOLOAD:=$(call AutoProbe,rtc-ds1374)
endef

define KernelPackage/rtc-ds1374/description
 Kernel module for Dallas/Maxim DS1374.
endef

$(eval $(call KernelPackage,rtc-ds1374))


define KernelPackage/rtc-ds1672
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Dallas/Maxim DS1672 RTC support
  DEFAULT:=m if ALL_KMODS && RTC_SUPPORT
  DEPENDS:=+kmod-i2c-core
  KCONFIG:=CONFIG_RTC_DRV_DS1672 \
	CONFIG_RTC_CLASS=y
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-ds1672.ko
  AUTOLOAD:=$(call AutoProbe,rtc-ds1672)
endef

define KernelPackage/rtc-ds1672/description
 Kernel module for Dallas/Maxim DS1672 RTC.
endef

$(eval $(call KernelPackage,rtc-ds1672))


define KernelPackage/rtc-em3027
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Microelectronic EM3027 RTC support
  DEFAULT:=m if ALL_KMODS && RTC_SUPPORT
  DEPENDS:=+kmod-i2c-core
  KCONFIG:=CONFIG_RTC_DRV_EM3027 \
	CONFIG_RTC_CLASS=y
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-em3027.ko
  AUTOLOAD:=$(call AutoProbe,rtc-em3027)
endef

define KernelPackage/rtc-em3027/description
 Kernel module for Microelectronic EM3027 RTC.
endef

$(eval $(call KernelPackage,rtc-em3027))


define KernelPackage/rtc-isl1208
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Intersil ISL1208 RTC support
  DEFAULT:=m if ALL_KMODS && RTC_SUPPORT
  DEPENDS:=+kmod-i2c-core
  KCONFIG:=CONFIG_RTC_DRV_ISL1208 \
	CONFIG_RTC_CLASS=y
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-isl1208.ko
  AUTOLOAD:=$(call AutoProbe,rtc-isl1208)
endef

define KernelPackage/rtc-isl1208/description
 Kernel module for Intersil ISL1208 RTC.
endef

$(eval $(call KernelPackage,rtc-isl1208))


define KernelPackage/rtc-mv
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Marvell SoC RTC support
  DEFAULT:=m if ALL_KMODS && RTC_SUPPORT
  KCONFIG:=CONFIG_RTC_DRV_MV \
	CONFIG_RTC_CLASS=y
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-mv.ko
  AUTOLOAD:=$(call AutoProbe,rtc-mv)
endef

define KernelPackage/rtc-mv/description
 Kernel module for Marvell SoC RTC.
endef

$(eval $(call KernelPackage,rtc-mv))


define KernelPackage/rtc-pcf8563
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Philips PCF8563/Epson RTC8564 RTC support
  DEFAULT:=m if ALL_KMODS && RTC_SUPPORT
  DEPENDS:=+kmod-i2c-core
  KCONFIG:=CONFIG_RTC_DRV_PCF8563 \
	CONFIG_RTC_CLASS=y
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-pcf8563.ko
  AUTOLOAD:=$(call AutoProbe,rtc-pcf8563)
endef

define KernelPackage/rtc-pcf8563/description
 Kernel module for Philips PCF8563 RTC chip.
 The Epson RTC8564 should work as well.
endef

$(eval $(call KernelPackage,rtc-pcf8563))


define KernelPackage/rtc-pcf2123
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Philips PCF2123 RTC support
  DEFAULT:=m if ALL_KMODS && RTC_SUPPORT
  DEPENDS:=+kmod-regmap-spi
  KCONFIG:=CONFIG_RTC_DRV_PCF2123 \
	CONFIG_RTC_CLASS=y
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-pcf2123.ko
  AUTOLOAD:=$(call AutoProbe,rtc-pcf2123)
endef

define KernelPackage/rtc-pcf2123/description
 Kernel module for Philips PCF2123 RTC chip
endef

$(eval $(call KernelPackage,rtc-pcf2123))

define KernelPackage/rtc-pcf2127
  SUBMENU:=$(OTHER_MENU)
  TITLE:=NXP PCF2127 and PCF2129 RTC support
  DEFAULT:=m if ALL_KMODS && RTC_SUPPORT
  DEPENDS:=+kmod-i2c-core +kmod-regmap-spi
  KCONFIG:=CONFIG_RTC_DRV_PCF2127 \
	CONFIG_RTC_CLASS=y
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-pcf2127.ko
  AUTOLOAD:=$(call AutoProbe,rtc-pcf2127)
endef

define KernelPackage/rtc-pcf2127/description
 Kernel module for NXP PCF2127 and PCF2129 RTC chip
endef

$(eval $(call KernelPackage,rtc-pcf2127))

define KernelPackage/rtc-r7301
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Epson RTC7301 support
  DEFAULT:=m if ALL_KMODS && RTC_SUPPORT
  DEPENDS:=+kmod-regmap-mmio
  KCONFIG:=CONFIG_RTC_DRV_R7301 \
	CONFIG_RTC_CLASS=y
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-r7301.ko
  AUTOLOAD:=$(call AutoProbe,rtc-r7301)
endef

define KernelPackage/rtc-r7301/description
 Kernel module for Epson RTC7301 RTC chip
endef

$(eval $(call KernelPackage,rtc-r7301))

define KernelPackage/rtc-rs5c372a
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Ricoh R2025S/D, RS5C372A/B, RV5C386, RV5C387A
  DEFAULT:=m if ALL_KMODS && RTC_SUPPORT
  DEPENDS:=+kmod-i2c-core
  KCONFIG:=CONFIG_RTC_DRV_RS5C372 \
	CONFIG_RTC_CLASS=y
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-rs5c372.ko
  AUTOLOAD:=$(call AutoLoad,50,rtc-rs5c372,1)
endef

define KernelPackage/rtc-rs5c372a/description
 Kernel module for Ricoh R2025S/D, RS5C372A/B, RV5C386, RV5C387A RTC on chip module
endef

$(eval $(call KernelPackage,rtc-rs5c372a))

define KernelPackage/rtc-rx8025
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Epson RX-8025 / RX-8035
  DEFAULT:=m if ALL_KMODS && RTC_SUPPORT
  DEPENDS:=+kmod-i2c-core
  KCONFIG:=CONFIG_RTC_DRV_RX8025 \
	CONFIG_RTC_CLASS=y
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-rx8025.ko
  AUTOLOAD:=$(call AutoLoad,50,rtc-rx8025,1)
endef

define KernelPackage/rtc-rx8025/description
 Kernel module for Epson RX-8025 and RX-8035 I2C RTC chip
endef

$(eval $(call KernelPackage,rtc-rx8025))

define KernelPackage/rtc-s35390a
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Seico S-35390A
  DEFAULT:=m if ALL_KMODS && RTC_SUPPORT
  DEPENDS:=+kmod-i2c-core
  KCONFIG:=CONFIG_RTC_DRV_S35390A \
	CONFIG_RTC_CLASS=y
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-s35390a.ko
  AUTOLOAD:=$(call AutoLoad,50,rtc-s35390a,1)
endef

define KernelPackage/rtc-s35390a/description
 Kernel module for Seiko Instruments S-35390A I2C RTC chip
endef

$(eval $(call KernelPackage,rtc-s35390a))

define KernelPackage/rtc-x1205
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Xicor Intersil X1205
  DEFAULT:=m if ALL_KMODS && RTC_SUPPORT
  DEPENDS:=+kmod-i2c-core
  KCONFIG:=CONFIG_RTC_DRV_X1205 \
	CONFIG_RTC_CLASS=y
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-x1205.ko
  AUTOLOAD:=$(call AutoProbe,rtc-x1205)
endef

define KernelPackage/rtc-x1205/description
 Kernel module for Xicor Intersil X1205 I2C RTC chip
endef

$(eval $(call KernelPackage,rtc-x1205))


define KernelPackage/mfd
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Multifunction device drivers
  HIDDEN:=1
  KCONFIG:=CONFIG_MFD_CORE
  FILES:=$(LINUX_DIR)/drivers/mfd/mfd-core.ko
  AUTOLOAD:=$(call AutoLoad,10,mfd-core)
endef

$(eval $(call KernelPackage,mfd))


define KernelPackage/mtdtests
  SUBMENU:=$(OTHER_MENU)
  TITLE:=MTD subsystem tests
  KCONFIG:=CONFIG_MTD_TESTS
  FILES:=\
	$(LINUX_DIR)/drivers/mtd/tests/mtd_nandbiterrs.ko \
	$(LINUX_DIR)/drivers/mtd/tests/mtd_nandecctest.ko \
	$(LINUX_DIR)/drivers/mtd/tests/mtd_oobtest.ko \
	$(LINUX_DIR)/drivers/mtd/tests/mtd_pagetest.ko \
	$(LINUX_DIR)/drivers/mtd/tests/mtd_readtest.ko \
	$(LINUX_DIR)/drivers/mtd/tests/mtd_speedtest.ko \
	$(LINUX_DIR)/drivers/mtd/tests/mtd_stresstest.ko \
	$(LINUX_DIR)/drivers/mtd/tests/mtd_subpagetest.ko \
	$(LINUX_DIR)/drivers/mtd/tests/mtd_test.ko \
	$(LINUX_DIR)/drivers/mtd/tests/mtd_torturetest.ko
endef

define KernelPackage/mtdtests/description
 Kernel modules for MTD subsystem/driver testing
endef

$(eval $(call KernelPackage,mtdtests))


define KernelPackage/mtdoops
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Log panic/oops to an MTD buffer
  KCONFIG:=CONFIG_MTD_OOPS
  FILES:=$(LINUX_DIR)/drivers/mtd/mtdoops.ko
endef

define KernelPackage/mtdoops/description
 Kernel modules for Log panic/oops to an MTD buffer
endef

$(eval $(call KernelPackage,mtdoops))


define KernelPackage/mtdram
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Test MTD driver using RAM
  KCONFIG:=CONFIG_MTD_MTDRAM \
    CONFIG_MTDRAM_TOTAL_SIZE=4096 \
    CONFIG_MTDRAM_ERASE_SIZE=128
  FILES:=$(LINUX_DIR)/drivers/mtd/devices/mtdram.ko
endef

define KernelPackage/mtdram/description
  Test MTD driver using RAM
endef

$(eval $(call KernelPackage,mtdram))


define KernelPackage/ramoops
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Ramoops (pstore-ram)
  DEFAULT:=m if ALL_KMODS
  KCONFIG:=CONFIG_PSTORE_RAM \
	CONFIG_PSTORE_CONSOLE=y
  DEPENDS:=+kmod-pstore +kmod-reed-solomon
  FILES:= $(LINUX_DIR)/fs/pstore/ramoops.ko
  AUTOLOAD:=$(call AutoLoad,30,ramoops,1)
endef

define KernelPackage/ramoops/description
 Kernel module for pstore-ram (ramoops) crash log storage
endef

$(eval $(call KernelPackage,ramoops))


define KernelPackage/reed-solomon
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Reed-Solomon error correction
  DEFAULT:=m if ALL_KMODS
  KCONFIG:=CONFIG_REED_SOLOMON \
	CONFIG_REED_SOLOMON_DEC8=y \
	CONFIG_REED_SOLOMON_ENC8=y
  FILES:= $(LINUX_DIR)/lib/reed_solomon/reed_solomon.ko
  AUTOLOAD:=$(call AutoLoad,30,reed_solomon,1)
endef

define KernelPackage/reed-solomon/description
 Kernel module for Reed-Solomon error correction
endef

$(eval $(call KernelPackage,reed-solomon))


define KernelPackage/serial-8250
  SUBMENU:=$(OTHER_MENU)
  TITLE:=8250 UARTs
  KCONFIG:= CONFIG_SERIAL_8250 \
	CONFIG_SERIAL_8250_PCI \
	CONFIG_SERIAL_8250_NR_UARTS=16 \
	CONFIG_SERIAL_8250_RUNTIME_UARTS=16 \
	CONFIG_SERIAL_8250_EXTENDED=y \
	CONFIG_SERIAL_8250_MANY_PORTS=y \
	CONFIG_SERIAL_8250_SHARE_IRQ=y \
	CONFIG_SERIAL_8250_DETECT_IRQ=n \
	CONFIG_SERIAL_8250_RSA=n
  FILES:= \
	$(LINUX_DIR)/drivers/tty/serial/8250/8250.ko \
	$(LINUX_DIR)/drivers/tty/serial/8250/8250_base.ko \
	$(if $(CONFIG_PCI),$(LINUX_DIR)/drivers/tty/serial/8250/8250_pci.ko) \
	$(if $(CONFIG_GPIOLIB),$(LINUX_DIR)/drivers/tty/serial/serial_mctrl_gpio.ko)
  AUTOLOAD:=$(call AutoProbe,8250 8250_base 8250_pci)
endef

define KernelPackage/serial-8250/description
 Kernel module for 8250 UART based serial ports
endef

$(eval $(call KernelPackage,serial-8250))


define KernelPackage/serial-8250-exar
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Exar 8250 UARTs
  KCONFIG:= CONFIG_SERIAL_8250_EXAR
  FILES:=$(LINUX_DIR)/drivers/tty/serial/8250/8250_exar.ko
  AUTOLOAD:=$(call AutoProbe,8250 8250_base 8250_exar)
  DEPENDS:=@PCI_SUPPORT +kmod-serial-8250
endef

define KernelPackage/serial-8250-exar/description
 Kernel module for Exar serial ports
endef

$(eval $(call KernelPackage,serial-8250-exar))


define KernelPackage/regmap-core
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Generic register map support
  HIDDEN:=1
  KCONFIG:=CONFIG_REGMAP
ifneq ($(wildcard $(LINUX_DIR)/drivers/base/regmap/regmap-core.ko),)
  FILES:=$(LINUX_DIR)/drivers/base/regmap/regmap-core.ko
endif
endef

define KernelPackage/regmap-core/description
 Generic register map support
endef

$(eval $(call KernelPackage,regmap-core))


define KernelPackage/regmap-spi
  SUBMENU:=$(OTHER_MENU)
  TITLE:=SPI register map support
  DEPENDS:=+kmod-regmap-core
  HIDDEN:=1
  KCONFIG:=CONFIG_REGMAP_SPI \
	   CONFIG_SPI=y
  FILES:=$(LINUX_DIR)/drivers/base/regmap/regmap-spi.ko
endef

define KernelPackage/regmap-spi/description
 SPI register map support
endef

$(eval $(call KernelPackage,regmap-spi))


define KernelPackage/regmap-i2c
  SUBMENU:=$(OTHER_MENU)
  TITLE:=I2C register map support
  DEPENDS:=+kmod-regmap-core +kmod-i2c-core
  HIDDEN:=1
  KCONFIG:=CONFIG_REGMAP_I2C
  FILES:=$(LINUX_DIR)/drivers/base/regmap/regmap-i2c.ko
endef

define KernelPackage/regmap-i2c/description
 I2C register map support
endef

$(eval $(call KernelPackage,regmap-i2c))


define KernelPackage/regmap-mmio
  SUBMENU:=$(OTHER_MENU)
  TITLE:=MMIO register map support
  DEPENDS:=+kmod-regmap-core
  HIDDEN:=1
  KCONFIG:=CONFIG_REGMAP_MMIO
  FILES:=$(LINUX_DIR)/drivers/base/regmap/regmap-mmio.ko
endef

define KernelPackage/regmap-mmio/description
 MMIO register map support
endef

$(eval $(call KernelPackage,regmap-mmio))


define KernelPackage/ikconfig
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Kernel configuration via /proc/config.gz
  KCONFIG:=CONFIG_IKCONFIG \
	   CONFIG_IKCONFIG_PROC=y
  FILES:=$(LINUX_DIR)/kernel/configs.ko
  AUTOLOAD:=$(call AutoLoad,70,configs)
endef

define KernelPackage/ikconfig/description
 Kernel configuration via /proc/config.gz
endef

$(eval $(call KernelPackage,ikconfig))


define KernelPackage/zram
  SUBMENU:=$(OTHER_MENU)
  DEPENDS:= \
	+(KERNEL_ZRAM_BACKEND_LZO||KERNEL_ZRAM_DEF_COMP_LZORLE||KERNEL_ZRAM_DEF_COMP_LZO):kmod-lib-lzo \
	+(KERNEL_ZRAM_BACKEND_LZ4||KERNEL_ZRAM_DEF_COMP_LZ4):kmod-lib-lz4 \
	+(KERNEL_ZRAM_BACKEND_LZ4HC||KERNEL_ZRAM_DEF_COMP_LZ4HC):kmod-lib-lz4hc \
	+(KERNEL_ZRAM_BACKEND_ZSTD||KERNEL_ZRAM_DEF_COMP_ZSTD):kmod-lib-zstd
  TITLE:=ZRAM
  KCONFIG:= \
	CONFIG_ZSMALLOC \
	CONFIG_ZRAM \
	CONFIG_ZRAM_DEBUG=n \
	CONFIG_ZRAM_WRITEBACK=n \
	CONFIG_ZSMALLOC_STAT=n
  FILES:= \
	$(LINUX_DIR)/mm/zsmalloc.ko \
	$(LINUX_DIR)/drivers/block/zram/zram.ko
  AUTOLOAD:=$(call AutoLoad,20,zsmalloc zram)
endef

define KernelPackage/zram/description
 Compressed RAM block device support
endef

define KernelPackage/zram/config
  if PACKAGE_kmod-zram
    if LINUX_6_12
        config KERNEL_ZRAM_BACKEND_LZO
                bool "lzo and lzo-rle compression support"

        config KERNEL_ZRAM_BACKEND_LZ4
                bool "lz4 compression support"

        config KERNEL_ZRAM_BACKEND_LZ4HC
                bool "lz4hc compression support"

        config KERNEL_ZRAM_BACKEND_ZSTD
                bool "zstd compression support"

        config KERNEL_ZRAM_BACKEND_FORCE_LZO
                def_bool !KERNEL_ZRAM_BACKEND_LZ4 && \
                         !KERNEL_ZRAM_BACKEND_LZ4HC && \
                         !KERNEL_ZRAM_BACKEND_ZSTD
                select KERNEL_ZRAM_BACKEND_LZO

    endif
    choice
      prompt "ZRAM Default compressor"
      default KERNEL_ZRAM_DEF_COMP_LZORLE

    config KERNEL_ZRAM_DEF_COMP_LZORLE
            bool "lzo-rle"
            depends on KERNEL_ZRAM_BACKEND_LZO || !LINUX_6_12

    config KERNEL_ZRAM_DEF_COMP_LZO
            bool "lzo"
            depends on KERNEL_ZRAM_BACKEND_LZO || !LINUX_6_12

    config KERNEL_ZRAM_DEF_COMP_LZ4
            bool "lz4"
            depends on KERNEL_ZRAM_BACKEND_LZ4 || !LINUX_6_12

    config KERNEL_ZRAM_DEF_COMP_LZ4HC
            bool "lz4-hc"
            depends on KERNEL_ZRAM_BACKEND_LZ4HC || !LINUX_6_12

    config KERNEL_ZRAM_DEF_COMP_ZSTD
            bool "zstd"
            depends on KERNEL_ZRAM_BACKEND_ZSTD || !LINUX_6_12

    endchoice
  endif
endef

$(eval $(call KernelPackage,zram))

define KernelPackage/pps
  SUBMENU:=$(OTHER_MENU)
  TITLE:=PPS support
  KCONFIG:=CONFIG_PPS
  FILES:=$(LINUX_DIR)/drivers/pps/pps_core.ko
  AUTOLOAD:=$(call AutoLoad,17,pps_core,1)
endef

define KernelPackage/pps/description
 PPS (Pulse Per Second) is a special pulse provided by some GPS
 antennae. Userland can use it to get a high-precision time
 reference.
endef

$(eval $(call KernelPackage,pps))


define KernelPackage/pps-gpio
  SUBMENU:=$(OTHER_MENU)
  TITLE:=PPS client using GPIO
  DEPENDS:=+kmod-pps
  KCONFIG:=CONFIG_PPS_CLIENT_GPIO
  FILES:=$(LINUX_DIR)/drivers/pps/clients/pps-gpio.ko
  AUTOLOAD:=$(call AutoLoad,18,pps-gpio,1)
endef

define KernelPackage/pps-gpio/description
 Support for a PPS source using GPIO. To be useful you must
 also register a platform device specifying the GPIO pin and
 other options, usually in your board setup.
endef

$(eval $(call KernelPackage,pps-gpio))


define KernelPackage/pps-ldisc
  SUBMENU:=$(OTHER_MENU)
  TITLE:=PPS line discipline
  DEPENDS:=+kmod-pps
  KCONFIG:=CONFIG_PPS_CLIENT_LDISC
  FILES:=$(LINUX_DIR)/drivers/pps/clients/pps-ldisc.ko
  AUTOLOAD:=$(call AutoLoad,18,pps-ldisc,1)
endef

define KernelPackage/pps-ldisc/description
 Support for a PPS source connected with the CD (Carrier
 Detect) pin of your serial port.
endef

$(eval $(call KernelPackage,pps-ldisc))


define KernelPackage/ptp
  SUBMENU:=$(OTHER_MENU)
  TITLE:=PTP clock support
  DEPENDS:=+kmod-pps
  KCONFIG:= \
	CONFIG_PTP_1588_CLOCK \
	CONFIG_NET_PTP_CLASSIFY=y
  FILES:=$(LINUX_DIR)/drivers/ptp/ptp.ko
  AUTOLOAD:=$(call AutoLoad,18,ptp,1)
endef

define KernelPackage/ptp/description
 The IEEE 1588 standard defines a method to precisely
 synchronize distributed clocks over Ethernet networks.
endef

$(eval $(call KernelPackage,ptp))


define KernelPackage/ptp-qoriq
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Freescale QorIQ PTP support
  DEPENDS:=@(TARGET_mpc85xx||TARGET_qoriq) +kmod-ptp
  KCONFIG:=CONFIG_PTP_1588_CLOCK_QORIQ
  FILES:=$(LINUX_DIR)/drivers/ptp/ptp-qoriq.ko
  AUTOLOAD:=$(call AutoProbe,ptp-qoriq)
endef


define KernelPackage/ptp-qoriq/description
 Kernel module for IEEE 1588 support for Freescale
 QorIQ Ethernet drivers
endef

$(eval $(call KernelPackage,ptp-qoriq))

define KernelPackage/random-core
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Hardware Random Number Generator Core support
  KCONFIG:=CONFIG_HW_RANDOM
  FILES:=$(LINUX_DIR)/drivers/char/hw_random/rng-core.ko
endef

define KernelPackage/random-core/description
 Kernel module for the HW random number generator core infrastructure
endef

$(eval $(call KernelPackage,random-core))


define KernelPackage/thermal
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Thermal driver
  DEPENDS:=+kmod-hwmon-core
  HIDDEN:=1
  KCONFIG:= \
	CONFIG_THERMAL=y \
	CONFIG_THERMAL_OF=y \
	CONFIG_CPU_THERMAL=y \
	CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y \
	CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=n \
	CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=n \
	CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0 \
	CONFIG_THERMAL_GOV_FAIR_SHARE=n \
	CONFIG_THERMAL_GOV_STEP_WISE=y \
	CONFIG_THERMAL_GOV_USER_SPACE=n \
	CONFIG_THERMAL_HWMON=y \
	CONFIG_THERMAL_EMULATION=n
endef

define KernelPackage/thermal/description
 Thermal driver offers a generic mechanism for thermal management.
 Usually it's made up of one or more thermal zone and cooling device.
endef

$(eval $(call KernelPackage,thermal))


define KernelPackage/echo
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Line Echo Canceller
  KCONFIG:=CONFIG_ECHO
  FILES:=$(LINUX_DIR)/drivers/misc/echo/echo.ko
  AUTOLOAD:=$(call AutoLoad,50,echo)
endef

define KernelPackage/echo/description
 This driver provides line echo cancelling support for mISDN and
 DAHDI drivers
endef

$(eval $(call KernelPackage,echo))


define KernelPackage/keys-encrypted
  SUBMENU:=$(OTHER_MENU)
  TITLE:=encrypted keys on kernel keyring
  DEPENDS:=@KERNEL_KEYS +kmod-crypto-cbc +kmod-crypto-hmac +kmod-crypto-rng \
           +kmod-crypto-sha256 +kmod-keys-trusted
  KCONFIG:=CONFIG_ENCRYPTED_KEYS
  FILES:=$(LINUX_DIR)/security/keys/encrypted-keys/encrypted-keys.ko
  AUTOLOAD:=$(call AutoLoad,01,encrypted-keys,1)
endef

define KernelPackage/keys-encrypted/description
	This module provides support for create/encrypting/decrypting keys
	in the kernel.  Encrypted keys are kernel generated random numbers,
	which are encrypted/decrypted with a 'master' symmetric key. The
	'master' key can be either a trusted-key or user-key type.
	Userspace only ever sees/stores encrypted blobs.
endef

$(eval $(call KernelPackage,keys-encrypted))


define KernelPackage/keys-trusted
  SUBMENU:=$(OTHER_MENU)
  TITLE:=TPM trusted keys on kernel keyring
  DEPENDS:=@KERNEL_KEYS +kmod-crypto-hash +kmod-crypto-hmac +kmod-crypto-sha1 +kmod-tpm
  KCONFIG:=CONFIG_TRUSTED_KEYS
  FILES:= \
	$(LINUX_DIR)/security/keys/trusted.ko@lt5.10 \
	$(LINUX_DIR)/security/keys/trusted-keys/trusted.ko@ge5.10
  AUTOLOAD:=$(call AutoLoad,01,trusted-keys,1)
endef

define KernelPackage/keys-trusted/description
	This module provides support for creating, sealing, and unsealing
	keys in the kernel. Trusted keys are random number symmetric keys,
	generated and RSA-sealed by the TPM. The TPM only unseals the keys,
	if the boot PCRs and other criteria match.  Userspace will only ever
	see encrypted blobs.
endef

$(eval $(call KernelPackage,keys-trusted))


define KernelPackage/tpm
  SUBMENU:=$(OTHER_MENU)
  TITLE:=TPM Hardware Support
  DEPENDS:= +kmod-random-core +kmod-asn1-decoder \
	  +kmod-asn1-encoder +kmod-oid-registry \
	  +LINUX_6_12:kmod-crypto-ecdh \
	  +LINUX_6_12:kmod-crypto-kpp \
	  +LINUX_6_12:kmod-crypto-lib-aescfb
  KCONFIG:= CONFIG_TCG_TPM
  FILES:= $(LINUX_DIR)/drivers/char/tpm/tpm.ko
  AUTOLOAD:=$(call AutoLoad,10,tpm,1)
endef

define KernelPackage/tpm/description
	This enables TPM Hardware Support.
endef

$(eval $(call KernelPackage,tpm))

define KernelPackage/tpm-tis
  SUBMENU:=$(OTHER_MENU)
  TITLE:=TPM TIS 1.2 Interface / TPM 2.0 FIFO Interface
	DEPENDS:= @TARGET_x86 +kmod-tpm
  KCONFIG:= CONFIG_TCG_TIS
  FILES:= \
	$(LINUX_DIR)/drivers/char/tpm/tpm_tis.ko \
	$(LINUX_DIR)/drivers/char/tpm/tpm_tis_core.ko
  AUTOLOAD:=$(call AutoLoad,20,tpm_tis,1)
endef

define KernelPackage/tpm-tis/description
	If you have a TPM security chip that is compliant with the
	TCG TIS 1.2 TPM specification (TPM1.2) or the TCG PTP FIFO
	specification (TPM2.0) say Yes and it will be accessible from
	within Linux.
endef

$(eval $(call KernelPackage,tpm-tis))

define KernelPackage/tpm-i2c-atmel
  SUBMENU:=$(OTHER_MENU)
  TITLE:=TPM I2C Atmel Support
  DEPENDS:= +kmod-tpm +kmod-i2c-core
  KCONFIG:= CONFIG_TCG_TIS_I2C_ATMEL
  FILES:= $(LINUX_DIR)/drivers/char/tpm/tpm_i2c_atmel.ko
  AUTOLOAD:=$(call AutoLoad,40,tpm_i2c_atmel,1)
endef

define KernelPackage/tpm-i2c-atmel/description
	This enables the TPM Interface Specification 1.2 Interface (I2C - Atmel)
endef

$(eval $(call KernelPackage,tpm-i2c-atmel))

define KernelPackage/tpm-i2c-infineon
  SUBMENU:=$(OTHER_MENU)
  TITLE:= TPM I2C Infineon driver
  DEPENDS:= +kmod-tpm +kmod-i2c-core
  KCONFIG:= CONFIG_TCG_TIS_I2C_INFINEON
  FILES:= $(LINUX_DIR)/drivers/char/tpm/tpm_i2c_infineon.ko
  AUTOLOAD:= $(call AutoLoad,40,tpm_i2c_infineon,1)
endef

define KernelPackage/tpm-i2c-infineon/description
	This enables the TPM Interface Specification 1.2 Interface (I2C - Infineon)
endef

$(eval $(call KernelPackage,tpm-i2c-infineon))


define KernelPackage/i6300esb-wdt
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Intel 6300ESB Timer/Watchdog
  DEPENDS:=@PCI_SUPPORT @!SMALL_FLASH
  KCONFIG:=CONFIG_I6300ESB_WDT \
	   CONFIG_WATCHDOG_CORE=y
  FILES:=$(LINUX_DIR)/drivers/$(WATCHDOG_DIR)/i6300esb.ko
  AUTOLOAD:=$(call AutoLoad,50,i6300esb,1)
endef

define KernelPackage/i6300esb-wdt/description
  Kernel module for the watchdog timer built into the Intel
  6300ESB controller hub. Also used by QEMU/libvirt.
endef

$(eval $(call KernelPackage,i6300esb-wdt))


define KernelPackage/itco-wdt
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Intel iTCO Watchdog Timer
  KCONFIG:=CONFIG_ITCO_WDT \
	   CONFIG_ITCO_VENDOR_SUPPORT=y
  FILES:=$(LINUX_DIR)/drivers/$(WATCHDOG_DIR)/iTCO_wdt.ko \
	 $(LINUX_DIR)/drivers/$(WATCHDOG_DIR)/iTCO_vendor_support.ko
  AUTOLOAD:=$(call AutoLoad,50,iTCO_vendor_support iTCO_wdt,1)
endef

define KernelPackage/itco-wdt/description
  Kernel module for Intel iTCO Watchdog Timer
endef

$(eval $(call KernelPackage,itco-wdt))


define KernelPackage/mhi-bus
  SUBMENU:=$(OTHER_MENU)
  TITLE:=MHI bus
  DEPENDS:=@(LINUX_5_15||LINUX_6_1||LINUX_6_6||LINUX_6_12)
  KCONFIG:=CONFIG_MHI_BUS \
           CONFIG_MHI_BUS_DEBUG=y
  FILES:=$(LINUX_DIR)/drivers/bus/mhi/host/mhi.ko
  AUTOLOAD:=$(call AutoProbe,mhi)
endef

define KernelPackage/mhi-bus/description
  Kernel module for the Qualcomm MHI bus.
endef

$(eval $(call KernelPackage,mhi-bus))

define KernelPackage/mhi-pci-generic
  SUBMENU:=$(OTHER_MENU)
  TITLE:=MHI PCI controller driver
  DEPENDS:=@PCI_SUPPORT +kmod-mhi-bus
  KCONFIG:=CONFIG_MHI_BUS_PCI_GENERIC
  FILES:=$(LINUX_DIR)/drivers/bus/mhi/host/mhi_pci_generic.ko
  AUTOLOAD:=$(call AutoProbe,mhi_pci_generic)
endef

define KernelPackage/mhi-pci-generic/description
  Kernel module for the MHI PCI controller driver.
endef

$(eval $(call KernelPackage,mhi-pci-generic))
