TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = PMD90
# PMD90.dbd will be created and installed
DBD += PMD90.dbd

# PMD90.dbd will be made up from these files:
PMD90_DBD += base.dbd
PMD90_DBD += stream.dbd
PMD90_DBD += asyn.dbd drvAsynIPPort.dbd drvAsynSerialPort.dbd aCalcoutRecord.dbd

# Include dbd files from all support applications:
#PMD90_DBD += xxx.dbd

# Add all the support libraries needed by this IOC
PMD90_LIBS += asyn stream calc pcre

# PMD90_registerRecordDeviceDriver.cpp derives from PMD90.dbd
PMD90_SRCS += PMD90_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
PMD90_SRCS_DEFAULT += PMD90Main.cpp
PMD90_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#PMD90_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
PMD90_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

