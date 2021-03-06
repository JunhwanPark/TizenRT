###########################################################################
#
# Copyright 2016 Samsung Electronics All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
# either express or implied. See the License for the specific
# language governing permissions and limitations under the License.
#
###########################################################################
############################################################################
# LibTargets.mk
#
#   Copyright (C) 2007-2012, 2014 Gregory Nutt. All rights reserved.
#   Author: Gregory Nutt <gnutt@nuttx.org>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in
#    the documentation and/or other materials provided with the
#    distribution.
# 3. Neither the name NuttX nor the names of its contributors may be
#    used to endorse or promote products derived from this software
#    without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
# OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
# AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
############################################################################

# Archive targets.  The target build sequence will first create a series of
# libraries, one per configured source file directory.  The final TinyAra
# execution will then be built from those libraries.  The following targets
# build those libraries.
#
# Possible kernel-mode builds

libc$(DELIM)libkc$(LIBEXT): context
	$(Q) $(MAKE) -C $(LIB_DIR)$(DELIM)libc TOPDIR="$(TOPDIR)" libkc$(LIBEXT) KERNEL=y EXTRADEFINES=$(KDEFINE)

$(LIBRARIES_DIR)$(DELIM)libkc$(LIBEXT): libc$(DELIM)libkc$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$(LIB_DIR)$(DELIM)$<,$@)

mm$(DELIM)libkmm$(LIBEXT): context
	$(Q) $(MAKE) -C mm TOPDIR="$(TOPDIR)" libkmm$(LIBEXT) KERNEL=y EXTRADEFINES=$(KDEFINE)

$(LIBRARIES_DIR)$(DELIM)libkmm$(LIBEXT): mm$(DELIM)libkmm$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)

$(ARCH_SRC)$(DELIM)libkarch$(LIBEXT): context
	$(Q) $(MAKE) -C $(ARCH_SRC) TOPDIR="$(TOPDIR)" libkarch$(LIBEXT) KERNEL=y EXTRADEFINES=$(KDEFINE)

$(LIBRARIES_DIR)$(DELIM)libkarch$(LIBEXT): $(ARCH_SRC)$(DELIM)libkarch$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)

kernel$(DELIM)libkernel$(LIBEXT): context
	$(Q) $(MAKE) -C kernel TOPDIR="$(TOPDIR)" libkernel$(LIBEXT) KERNEL=y EXTRADEFINES=$(KDEFINE)

$(LIBRARIES_DIR)$(DELIM)libkernel$(LIBEXT): kernel$(DELIM)libkernel$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)

net$(DELIM)libnet$(LIBEXT): context
	$(Q) $(MAKE) -C net TOPDIR="$(TOPDIR)" libnet$(LIBEXT) KERNEL=y EXTRADEFINES=$(KDEFINE)

$(LIBRARIES_DIR)$(DELIM)libnet$(LIBEXT): net$(DELIM)libnet$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)

pm$(DELIM)libpm$(LIBEXT): context
	$(Q) $(MAKE) -C pm TOPDIR="$(TOPDIR)" libpm$(LIBEXT) KERNEL=y EXTRADEFINES=$(KDEFINE)

$(LIBRARIES_DIR)$(DELIM)libpm$(LIBEXT): pm$(DELIM)libpm$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)

logm$(DELIM)liblogm$(LIBEXT): context
	$(Q) $(MAKE) -C logm TOPDIR="$(TOPDIR)" liblogm$(LIBEXT) KERNEL=y EXTRADEFINES=$(KDEFINE)

$(LIBRARIES_DIR)$(DELIM)liblogm$(LIBEXT): logm$(DELIM)liblogm$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)

fs$(DELIM)libfs$(LIBEXT): context
	$(Q) $(MAKE) -C fs TOPDIR="$(TOPDIR)" libfs$(LIBEXT) KERNEL=y EXTRADEFINES=$(KDEFINE)

$(LIBRARIES_DIR)$(DELIM)libfs$(LIBEXT): fs$(DELIM)libfs$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)

audio$(DELIM)libaudio$(LIBEXT): context
	$(Q) $(MAKE) -C audio TOPDIR="$(TOPDIR)" libaudio$(LIBEXT) KERNEL=y EXTRADEFINES=$(KDEFINE)

$(LIBRARIES_DIR)$(DELIM)libaudio$(LIBEXT): audio$(DELIM)libaudio$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)

drivers$(DELIM)libdrivers$(LIBEXT): context
	$(Q) $(MAKE) -C drivers TOPDIR="$(TOPDIR)" libdrivers$(LIBEXT) KERNEL=y EXTRADEFINES=$(KDEFINE)

$(LIBRARIES_DIR)$(DELIM)libdrivers$(LIBEXT): drivers$(DELIM)libdrivers$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)

# Special case

syscall$(DELIM)libstubs$(LIBEXT): context
	$(Q) $(MAKE) -C syscall TOPDIR="$(TOPDIR)" libstubs$(LIBEXT) # KERNEL=y EXTRADEFINES=$(KDEFINE)

$(LIBRARIES_DIR)$(DELIM)libstubs$(LIBEXT): syscall$(DELIM)libstubs$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)

# Possible user-mode builds

libc$(DELIM)libuc$(LIBEXT): context
	$(Q) $(MAKE) -C $(LIB_DIR)$(DELIM)libc TOPDIR="$(TOPDIR)" libuc$(LIBEXT) KERNEL=n

$(LIBRARIES_DIR)$(DELIM)libuc$(LIBEXT): libc$(DELIM)libuc$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$(LIB_DIR)$(DELIM)$<,$@)

mm$(DELIM)libumm$(LIBEXT): context
	$(Q) $(MAKE) -C mm TOPDIR="$(TOPDIR)" libumm$(LIBEXT) KERNEL=n

$(LIBRARIES_DIR)$(DELIM)libumm$(LIBEXT): mm$(DELIM)libumm$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)

$(ARCH_SRC)$(DELIM)libuarch$(LIBEXT): context
	$(Q) $(MAKE) -C $(ARCH_SRC) TOPDIR="$(TOPDIR)" libuarch$(LIBEXT) KERNEL=n

$(LIBRARIES_DIR)$(DELIM)libuarch$(LIBEXT): $(ARCH_SRC)$(DELIM)libuarch$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)

libxx$(DELIM)libcxx$(LIBEXT): context
	$(Q) $(MAKE) -C $(LIB_DIR)$(DELIM)libxx TOPDIR="$(TOPDIR)" libcxx$(LIBEXT) KERNEL=n

$(LIBRARIES_DIR)$(DELIM)libcxx$(LIBEXT): libxx$(DELIM)libcxx$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$(LIB_DIR)$(DELIM)$<,$@)

$(APPDIR)$(DELIM)libapps$(LIBEXT): context
	$(Q) $(MAKE) -C $(APPDIR) TOPDIR="$(TOPDIR)" libapps$(LIBEXT) KERNEL=n

$(LIBRARIES_DIR)$(DELIM)libapps$(LIBEXT): $(APPDIR)$(DELIM)libapps$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)

syscall$(DELIM)libproxies$(LIBEXT): context
	$(Q) $(MAKE) -C syscall TOPDIR="$(TOPDIR)" libproxies$(LIBEXT) KERNEL=n

$(LIBRARIES_DIR)$(DELIM)libproxies$(LIBEXT): syscall$(DELIM)libproxies$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)

$(FRAMEWORK_LIB_DIR)$(DELIM)libframework$(LIBEXT): context
	$(Q) $(MAKE) -C $(FRAMEWORK_LIB_DIR) TOPDIR="$(TOPDIR)" libframework$(LIBEXT) KERNEL=n

$(LIBRARIES_DIR)$(DELIM)libframework$(LIBEXT): $(FRAMEWORK_LIB_DIR)$(DELIM)libframework$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)

$(EXTDIR)$(DELIM)libexternal$(LIBEXT): context
	$(Q) $(MAKE) -C $(EXTDIR) TOPDIR="$(TOPDIR)" libexternal$(LIBEXT) KERNEL=n

$(LIBRARIES_DIR)$(DELIM)libexternal$(LIBEXT): $(EXTDIR)$(DELIM)libexternal$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)

# ARTIK Security API lib
ifeq ($(CONFIG_ARTIK_SDK),y)
$(LIBRARIES_DIR)$(DELIM)libsecurity-api$(LIBEXT): $(ARTIKSDKDIR)$(DELIM)src$(DELIM)modules$(DELIM)base$(DELIM)security$(DELIM)tizenrt$(DELIM)libsecurity-api$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)
endif

#Iotivity Libs

ifeq ($(CONFIG_ENABLE_IOTIVITY),y)
$(LIBRARIES_DIR)$(DELIM)liboctbstack$(LIBEXT): $(IOTIVITY_LIBS_DIR)$(DELIM)liboctbstack$(LIBEXT)
	$(Q) install $(IOTIVITY_LIBS_DIR)$(DELIM)liboctbstack$(LIBEXT) $(LIBRARIES_DIR)$(DELIM)liboctbstack$(LIBEXT)

$(LIBRARIES_DIR)$(DELIM)libc_common$(LIBEXT): $(IOTIVITY_LIBS_DIR)$(DELIM)libc_common$(LIBEXT)
	$(Q) install $(IOTIVITY_LIBS_DIR)$(DELIM)libc_common$(LIBEXT) $(LIBRARIES_DIR)$(DELIM)libc_common$(LIBEXT)

$(LIBRARIES_DIR)$(DELIM)libcoap$(LIBEXT): $(IOTIVITY_LIBS_DIR)$(DELIM)libcoap$(LIBEXT)
	$(Q) install $(IOTIVITY_LIBS_DIR)$(DELIM)libcoap$(LIBEXT) $(LIBRARIES_DIR)$(DELIM)libcoap$(LIBEXT)

$(LIBRARIES_DIR)$(DELIM)libconnectivity_abstraction$(LIBEXT): $(IOTIVITY_LIBS_DIR)$(DELIM)libconnectivity_abstraction$(LIBEXT)
	$(Q) install $(IOTIVITY_LIBS_DIR)$(DELIM)libconnectivity_abstraction$(LIBEXT) $(LIBRARIES_DIR)$(DELIM)libconnectivity_abstraction$(LIBEXT)

$(LIBRARIES_DIR)$(DELIM)liblogger$(LIBEXT): $(IOTIVITY_LIBS_DIR)$(DELIM)liblogger$(LIBEXT)
	$(Q) install $(IOTIVITY_LIBS_DIR)$(DELIM)liblogger$(LIBEXT) $(LIBRARIES_DIR)$(DELIM)liblogger$(LIBEXT)

$(LIBRARIES_DIR)$(DELIM)libocsrm$(LIBEXT): $(IOTIVITY_LIBS_DIR)$(DELIM)libocsrm$(LIBEXT)
	$(Q) install $(IOTIVITY_LIBS_DIR)$(DELIM)libocsrm$(LIBEXT) $(LIBRARIES_DIR)$(DELIM)libocsrm$(LIBEXT)

$(LIBRARIES_DIR)$(DELIM)libroutingmanager$(LIBEXT): $(IOTIVITY_LIBS_DIR)$(DELIM)libroutingmanager$(LIBEXT)
	$(Q) install $(IOTIVITY_LIBS_DIR)$(DELIM)libroutingmanager$(LIBEXT) $(LIBRARIES_DIR)$(DELIM)libroutingmanager$(LIBEXT)

ifeq ($(CONFIG_ENABLE_IOTIVITY_CLOUD),y)
$(LIBRARIES_DIR)$(DELIM)libresource_directory$(LIBEXT): $(IOTIVITY_LIBS_DIR)$(DELIM)libresource_directory$(LIBEXT)
	$(Q) install $(IOTIVITY_LIBS_DIR)$(DELIM)libresource_directory$(LIBEXT) $(LIBRARIES_DIR)$(DELIM)libresource_directory$(LIBEXT)
endif

ifneq ($(CONFIG_IOTIVITY_RELEASE_VERSION_1_2),y)
$(LIBRARIES_DIR)$(DELIM)libtizenrt_compat$(LIBEXT): $(IOTIVITY_LIBS_DIR)$(DELIM)libtizenrt_compat$(LIBEXT)
	$(Q) install $(IOTIVITY_LIBS_DIR)$(DELIM)libtizenrt_compat$(LIBEXT) $(LIBRARIES_DIR)$(DELIM)libtizenrt_compat$(LIBEXT)
endif
endif

# Possible non-kernel builds

libc$(DELIM)libc$(LIBEXT): context
	$(Q) $(MAKE) -C $(LIB_DIR)$(DELIM)libc TOPDIR="$(TOPDIR)" libc$(LIBEXT)

$(LIBRARIES_DIR)$(DELIM)libc$(LIBEXT): libc$(DELIM)libc$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$(LIB_DIR)$(DELIM)$<,$@)

mm$(DELIM)libmm$(LIBEXT): context
	$(Q) $(MAKE) -C mm TOPDIR="$(TOPDIR)" libmm$(LIBEXT)

$(LIBRARIES_DIR)$(DELIM)libmm$(LIBEXT): mm$(DELIM)libmm$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)

$(ARCH_SRC)$(DELIM)libarch$(LIBEXT): context
	$(Q) $(MAKE) -C $(ARCH_SRC) TOPDIR="$(TOPDIR)" libarch$(LIBEXT)

$(LIBRARIES_DIR)$(DELIM)libarch$(LIBEXT): $(ARCH_SRC)$(DELIM)libarch$(LIBEXT)
	$(Q) $(call INSTALL_LIB,$<,$@)
