#!../../bin/linux-x86/PMD90

< envPaths
epicsEnvSet "STREAM_PROTOCOL_PATH" "$(TOP)/db"

###############################################################################
# Allow PV name prefixes and serial port name to be set from the environment
epicsEnvSet "P" "$(P=E1:)"
epicsEnvSet "R" "$(R=PMD90:)"
epicsEnvSet "PMD90_IP" "$(PMD90_IP=10.0.0.11)"
epicsEnvSet "PMD90_PORT" "$(PMD90_PORT=4015)"

epicsEnvSet "ASYN_PORT" "PMD90"

## Register all support components
dbLoadDatabase("$(TOP)/dbd/PMD90.dbd",0,0)
PMD90_registerRecordDeviceDriver(pdbbase) 

###############################################################################
# Set up ASYN ports
drvAsynIPPortConfigure("$(ASYN_PORT)","$(PMD90_IP):$(PMD90_PORT)",0,0,0)

## for direct connection to the machine's serial port:
# drvAsynSerialPortConfigure("$(ASYN_PORT)", "/dev/ttyUSB0", 0, 0, 0)
# asynSetOption("$(ASYN_PORT)",0,"baud","9600")
# asynSetOption("$(ASYN_PORT)",0,"parity","none")
# asynSetOption("$(ASYN_PORT)",0,"bits","8")
# asynSetOption("$(ASYN_PORT)",0,"stop","1")

asynOctetSetInputEos("$(ASYN_PORT)", -1, "\n")
asynOctetSetOutputEos("$(ASYN_PORT)", -1, "\n")
asynSetTraceIOMask("$(ASYN_PORT)",-1,0)
asynSetTraceMask("$(ASYN_PORT)",-1,0)
#asynSetTraceIOMask("$(ASYN_PORT)",-1,0x2)
#asynSetTraceMask("$(ASYN_PORT)",-1,0x9)

###############################################################################
## Load record instances
dbLoadRecords("$(TOP)/db/devPMD90.db","P=$(P),R=$(R),PORT=$(ASYN_PORT),A=0")

iocInit()
#var streamDebug 1
dbpr $(P)$(R)VERSION

