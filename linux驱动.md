# 设备树文件 dtsi

例子：
```
/* Copyright (c) 2015 - 2016, The Linux Foundation. All rights reserved.
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 */

#include "qcom-ipq4019.dtsi"
#include "qcom-ipq4019-mhi.dtsi"
#include <dt-bindings/input/input.h>
#include <dt-bindings/gpio/gpio.h>

/ {
	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK04.1";
	compatible = "qcom,ipq4019";

	memory {
		device_type = "memory";
		reg = <0x80000000 0x10000000>; /* 256MB */
	};

	chosen {
		bootargs-append = " clk_ignore_unused";
	};

	aliases {
		sdhc1 = &sdhc_1;
	};

	soc {
		pinctrl@0x01000000 {
			serial_0_pins: serial0_pinmux {
				mux {
					pins = "gpio16", "gpio17";
					function = "blsp_uart0";
					bias-disable;
				};
			};

			serial_1_pins: serial1_pinmux {
				mux {
					pins = "gpio8", "gpio9";
					function = "blsp_uart1";
					bias-disable;
				};
			};

			spi_0_pins: spi_0_pinmux {
				pinmux {
					function = "blsp_spi0";
					pins = "gpio13", "gpio14", "gpio15";
					bias-disable;
				};
				pinmux_cs1 {
					function = "gpio";
					pins = "gpio12";
					bias-disable;
					output-high;
				};
				pinmux_cs2 {
					function = "gpio";
					pins = "gpio45";
					bias-disable;
					output-high;
				};
			};

			i2c_0_pins: i2c_0_pinmux {
				mux {
					pins = "gpio10", "gpio11";
					function = "blsp_i2c0";
					bias-disable;
				};
			};

			sd_0_pins: sd_0_pinmux {
				sd0 {
					pins = "gpio23";
					function = "sdio0";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_C>;
					vm-enable;
				};
				sd1 {
					pins = "gpio24";
					function = "sdio1";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_C>;
					vm-enable;
				};
				sd2 {
					pins = "gpio25";
					function = "sdio2";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_C>;
					vm-enable;
				};
				sd3 {
					pins = "gpio26";
					function = "sdio3";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_C>;
					vm-enable;
				};
				sdclk {
					pins = "gpio27";
					function = "sdio_clk";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_A>;
					vm-enable;
				};
				sdcmd {
					pins = "gpio28";
					function = "sdio_cmd";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_C>;
					vm-enable;
				};
				sd4 {
					pins = "gpio29";
					function = "sdio4";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_C>;
					vm-enable;
				};
				sd5 {
					pins = "gpio30";
					function = "sdio5";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_C>;
					vm-enable;
				};
				sd6 {
					pins = "gpio31";
					function = "sdio6";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_C>;
					vm-enable;
				};
				sd7 {
					pins = "gpio32";
					function = "sdio7";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_C>;
					vm-enable;
				};
			};

			sd_1_pins: sd_1_pinmux {
				sd0 {
					pins = "gpio23";
					function = "sdio0";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_D>;
					vm-enable;
				};
				sd1 {
					pins = "gpio24";
					function = "sdio1";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_D>;
					vm-enable;
				};
				sd2 {
					pins = "gpio25";
					function = "sdio2";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_D>;
					vm-enable;
				};
				sd3 {
					pins = "gpio26";
					function = "sdio3";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_D>;
					vm-enable;
				};
				sdclk {
					pins = "gpio27";
					function = "sdio_clk";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_D>;
					vm-enable;
				};
				sdcmd {
					pins = "gpio28";
					function = "sdio_cmd";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_D>;
					vm-enable;
				};
				sd4 {
					pins = "gpio29";
					function = "sdio4";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_D>;
					vm-enable;
				};
				sd5 {
					pins = "gpio30";
					function = "sdio5";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_D>;
					vm-enable;
				};
				sd6 {
					pins = "gpio31";
					function = "sdio6";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_D>;
					vm-enable;
				};
				sd7 {
					pins = "gpio32";
					function = "sdio7";
					pull-res = <RES_35_KOHM>;
					drive-type = <DRV_TYPE_D>;
					vm-enable;
				};
			};
			ts_0_pins: ts_0_pinmux {
				mux_1 {
					pins = "gpio34";
					output-high;
				};
				mux_2 {
					pins= "gpio35";
					input-enable;
					bias-pull-up;
				};
			};

			mdio_pins: mdio_pinmux {
				mux_1 {
					pins = "gpio6";
					function = "mdio0";
					bias-pull-up;
				};
				mux_2 {
					pins = "gpio7";
					function = "mdc";
					bias-pull-up;
				};
			};

			nand_pins: nand_pins {

				mux_1 {
					pins = "gpio55", "gpio56", "gpio61",
						"gpio62", "gpio63", "gpio69";
					function = "qpic_pad";
					bias-disable;
				};

				mux_2 {
					pins = "gpio67";
					function = "qpic_pad0";
					bias-disable;
				};

				mux_3 {
					pins = "gpio64";
					function = "qpic_pad1";
					bias-disable;
				};

				mux_4 {
					pins = "gpio65";
					function = "qpic_pad2";
					bias-disable;
				};

				mux_5 {
					pins = "gpio66";
					function = "qpic_pad3";
					bias-disable;
				};

				mux_6 {
					pins = "gpio57";
					function = "qpic_pad4";
					bias-disable;
				};

				mux_7 {
					pins = "gpio58";
					function = "qpic_pad5";
					bias-disable;
				};

				mux_8 {
					pins = "gpio59";
					function = "qpic_pad6";
					bias-disable;
				};

				mux_9 {
					pins = "gpio60";
					function = "qpic_pad7";
					bias-disable;
				};

				mux_10 {
					pins = "gpio68";
					function = "qpic_pad8";
					bias-disable;
				};

				pullups {
					pins = "gpio58", "gpio59";
					bias-pull-up;
				};

				pulldowns {
					pins = "gpio55", "gpio56",
						"gpio57", "gpio60", "gpio61",
						"gpio62", "gpio63", "gpio64",
						"gpio65", "gpio66", "gpio67",
						"gpio68", "gpio69";
					bias-pull-down;
				};
			};
		};

		mdio@90000 {
			status = "ok";
			pinctrl-0 = <&mdio_pins>;
			pinctrl-names = "default";
			#phy-reset-gpio = <&tlmm 47 0>;
			bias-disable;
		};

		serial@78af000 {
			pinctrl-0 = <&serial_0_pins>;
			pinctrl-names = "default";
			status = "ok";
		};

		serial@78b0000 {
			pinctrl-0 = <&serial_1_pins>;
			pinctrl-names = "default";
			status = "ok";
		};

		spi_0: spi@78b5000 { /* BLSP1 QUP1 */
			pinctrl-0 = <&spi_0_pins>;
			pinctrl-names = "default";
			status = "ok";
			cs-gpios = <&tlmm 12 0>, <&tlmm 45 0>;
			num-cs = <2>;

			m25p80@0 {
				#address-cells = <1>;
				#size-cells = <1>;
				reg = <0>;
				compatible = "n25q128a11";
				linux,modalias = "m25p80", "n25q128a11";
				spi-max-frequency = <24000000>;
				use-default-sizes;
			};

			rtc-m41t93@1 {
				reg = <1>;
				compatible = "rtc-m41t93";
				spi-max-frequency = <24000000>;
			};
		};

		i2c_0: i2c@78b7000 { /* BLSP1 QUP2 */
			pinctrl-0 = <&i2c_0_pins>;
			pinctrl-names = "default";
			status = "ok";

			lcd_ts: lcd_ts@40 {
				compatible = "qca,gsl1680_ts";
				reg = <0x40>;
				status = "disabled";
			};

			adt75: adt75@48 {
				compatible = "adt75";
				reg = <0x48>;
			};

		};

		/*
		pcie0: pci@40000000 {
			status = "ok";
			perst-gpio = <&tlmm 38 0x1>;
		};
		*/

		ess-switch@c000000 {
			switch_mac_mode = <0x0>; /* mac mode for RGMII RMII */
			switch_initvlas = <
				0x0007c 0x54 /* PORT0_STATUS */
			>;
			led_source@0 {
				led = <0x3>;     /*led number */
				source = <0x1>;  /*source id 1 */
				mode = "normal"; /*on,off,blink,normal */
				speed = "all";   /*10M,100M,1000M,all */
				freq = "auto";   /*2Hz,4Hz,8Hz,auto*/
			};
			led_source@1 {
				led = <0x4>;     /*led number */
				source = <0x4>;  /*source id 4 */
				mode = "normal"; /*on,off,blink,normal */
				speed = "all";   /*10M,100M,1000M,all */
				freq = "auto";   /*2Hz,4Hz,8Hz,auto*/
			};
			led_source@2 {
				led = <0x5>;     /*led number */
				source = <0x7>;  /*source id 7 */
				mode = "normal"; /*on,off,blink,normal */
				speed = "all";   /*10M,100M,1000M,all */
				freq = "auto";   /*2Hz,4Hz,8Hz,auto*/
			};
			led_source@3 {
				led = <0x6>;     /*led number */
				source = <0xa>;  /*source id 10 */
				mode = "normal"; /*on,off,blink,normal */
				speed = "all";   /*10M,100M,1000M,all */
				freq = "auto";   /*2Hz,4Hz,8Hz,auto*/
			};
			led_source@4 {
				led = <0x7>;     /*led number */
				source = <0xd>;  /*source id 13 */
				mode = "normal"; /*on,off,blink,normal */
				speed = "all";   /*10M,100M,1000M,all */
				freq = "auto";   /*2Hz,4Hz,8Hz,auto*/
			};
		};

		vccq_sd0: regulator@0 {
			compatible = "qcom,regulator-ipq40xx";
			regulator-name = "SD0 VccQ";
			regulator-min-microvolt = <1800000>;
			regulator-max-microvolt = <3000000>;
			states = <3000000 0x3
				1800000 0x1>;
			reg = <0x01948000 0x4>;
			mask = <0x3>;
		};

		sdhc_1: sdhci@7824000{
			status = "ok";
			qcom,bus-speed-mode = "HS200_1p8v", "DDR_1p8v";
			qcom,clk-rates = <400000 25000000 50000000 100000000 \
					 192000000>;
			pinctrl-0 = <&sd_0_pins>;
			pinctrl-1 = <&sd_1_pins>;
			pinctrl-names = "active", "sleep";
			vqmmc-supply = <&vccq_sd0>;
			cd-gpios = <&tlmm 22 0x1>;
			sd-ldo-gpios = <&tlmm 33 0x1>;
		};

		tcsr: tcsr@194b000 {
			status = "ok";
		};

		usb3_ss_phy: ssphy@0 {
			status = "ok";
		};

		usb3_hs_phy: hsphy@a6000 {
			status = "ok";
		};

		usb2_hs_phy: hsphy@a8000 {
			status = "ok";
		};

		usb3: usb3@8a00000 {
			status = "ok";
		};

		usb2: usb2@6000000 {
			status = "ok";
		};

		qpic_bam: dma@7984000{
			status = "ok";
		};

		nand: qpic-nand@79b0000 {
			pinctrl-0 = <&nand_pins>;
			pinctrl-names = "default";
			status = "disabled";
		};

		gpio_keys {
			compatible = "gpio-keys";

			button@1 {
				label = "wps";
				linux,code = <KEY_WPS_BUTTON>;
				gpios = <&tlmm 18 GPIO_ACTIVE_LOW>;
				linux,input-type = <1>;
			};
		};

		wifi0: wifi@a000000 {
			wifi_led_num = <2>;         /* Wifi 2G */
			wifi_led_source = <0>;      /* source id 0 */
		};

		wifi1: wifi@a800000 {
			wifi_led_num = <1>;         /* Wifi 5G */
			wifi_led_source = <2>;      /* source id 2 */
		};

		qcom_mdss_qpic@7980000 {
			status = "ok";
		};

		qcom_mdss_qpic_panel {
			status = "ok";
		};
	};
};

```
上述是我实际工程中使用的一个设备树文件，其中我需要将 gpio8 gpio9 外接一个串口设备,如下所示：
```

serial_1_pins: serial1_pinmux {
				mux {
					pins = "gpio8", "gpio9";
					function = "blsp_uart1";
					bias-disable;
				};
			};

serial@78b0000 {
			pinctrl-0 = <&serial_1_pins>;
			pinctrl-names = "default";
			status = "ok";
		};

```

# 查看dmesg打印过滤串口注册信息
在 `dmesg` 输出中，你可以搜索关键字来确认设备树的加载和串口相关的信息。你可以使用 `grep` 命令来过滤 `dmesg` 输出，以查找关键字。以下是一些可能有用的关键字：

- **Device Tree**：搜索以 "Device Tree" 或 "dtb" 开头的信息，这些信息会显示设备树的加载情况。
  
  ```bash
  dmesg | grep "Device Tree"
  ```

- **GPIO**：搜索与 GPIO 相关的信息，确保 GPIO 相关的驱动和引脚配置被正确加载。

  ```bash
  dmesg | grep "gpio"
  ```

- **Serial**：搜索与串口相关的信息，以确认串口驱动程序是否正确加载，并查看是否有关于 UART1 的信息。

  ```bash
  dmesg | grep "serial"
  ```

- **UART**：搜索与UART相关的信息，以确保UART设备已经被正确识别。

  ```bash
  dmesg | grep "uart"
  ```

- **特定设备节点**：如果你知道串口设备节点的名称，你也可以搜索这个名称。

  ```bash
  dmesg | grep "ttyS1"
  ```

确保 `dmesg` 输出中没有与设备树加载、GPIO配置和串口驱动相关的错误信息。  


# 在 usb-option 中没有添加对应设备的Vid 和 Pid导致usb设备不能被自动识别并注册节点 
 现象：查看usb设备`cat /sys/kernel/debug/usb/devices`能够看到该USB设备：
 ```
root@QA70-20:~# cat /sys/kernel/debug/usb/devices

T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=5000 MxCh= 0
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 3.00 Cls=09(hub  ) Sub=00 Prot=03 MxPS= 9 #Cfgs=  1
P:  Vendor=1d6b ProdID=0003 Rev= 4.04
S:  Manufacturer=Linux 4.4.60 xhci-hcd
S:  Product=xHCI Host Controller
S:  SerialNumber=xhci-hcd.1.auto
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

··· 省略

# 目标设备 Vid：1546 Pid:01a8
T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=02(comm.) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1546 ProdID=01a8 Rev= 3.01
S:  Manufacturer=u-blox AG - www.u-blox.com
S:  Product=u-blox GNSS receiver
C:* #Ifs= 2 Cfg#= 1 Atr=c0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=255ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=ff Driver=(none)
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
 ```

手动添加：`echo "1546 01a8" > /sys/bus/usb-serial/drivers/option1/new_id` 后在 /dev/目录下能够创建设备节点并正确输出GPS信息。　　　

根据上述信息判断，在设备上没有对应的驱动，且通用驱动option没有添加对应的节点(Vid 和 Pid)。  

修复方法：
在 [kernel]//drivers/usb/serial/option.c 中添加对应的Vid Pid即可，如下所示：
![4c54b2f239ddaca3cb97f222f273af2](https://github.com/grow-man/MyLearningRecorder/assets/52662997/ffd80f8f-8807-4e56-838d-60a77b514568)  

编译ko：在openwrt 中在外层选中表示将该模块编译成ko打包到版本中减少升级内核带来的问题：  
make menuconfig ->Kernel Modules -> USB Support 选中对应的KO模块 此处选中("*"(外层选中表示编译成KO打包到版本))kmod-usb-serial-option   


# Bypass 导致不能识别LTE模块  
![image](https://github.com/grow-man/MyLearningRecorder/assets/52662997/8be698fb-f4e7-4e2c-a39d-515c0fef1422)  

如上图所示，通过gpio控制EM360模块bypass,版本启动时将该模块设置为bypass模式导致该模块不可用(/sys/kernel/debug/usb/devices 没有该模块信息),后续修改为上电后设备unbypass修复   

# Linux系统中USB驱动的匹配与加载机制  
设备匹配驱动时，驱动会检查设备对应的Vid和Pid是自身支持的Vid和Pid，如果支持则加载设备自动加载：  
设备的连接和识别过程如下：

* 1.设备连接：当USB设备连接到Linux系统时，内核通过usbcore模块检测到新设备的插入。

* 2.设备描述符读取：内核读取设备的描述符信息，包括Vendor ID（Vid）和Product ID（Pid）。

* 3.匹配驱动：
 内核模块：Linux内核通过usb_device_id结构在已加载的内核模块中查找与设备Vid和Pid匹配的驱动程序。

一般在驱动程序中会维护支持设备列表，例如在`/drivers/usb/serial/option.c`中的`struct usb_device_id option_ids[]` :
```
static const struct usb_device_id option_ids[] = {
	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_COLT) },
	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_RICOLA) },
	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_RICOLA_LIGHT) },
	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_RICOLA_QUAD) },
	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_RICOLA_QUAD_LIGHT) },
	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_RICOLA_NDIS) },
····
}
```






 
