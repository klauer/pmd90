#!../../bin/linux-x86/PMD90

< envPaths
epicsEnvSet "STREAM_PROTOCOL_PATH" "$(TOP)/db"

###############################################################################
# Allow PV name prefixes and serial port name to be set from the environment
epicsEnvSet "P" "$(P=E1:)"
epicsEnvSet "R" "$(R=PMD90:)"
epicsEnvSet "PMD90_IP" "$(PMD90_IP=10.0.0.11)"
epicsEnvSet "PMD90_PORT" "$(PMD90_PORT=4015)"

## Register all support components
dbLoadDatabase("$(TOP)/dbd/PMD90.dbd",0,0)
PMD90_registerRecordDeviceDriver(pdbbase) 

###############################################################################
# Set up ASYN ports
drvAsynIPPortConfigure("pmd90_port","$(PMD90_IP):$(PMD90_PORT)",0,0,0)
asynOctetSetInputEos("pmd90_port", -1, "\n")
asynOctetSetOutputEos("pmd90_port", -1, "\n")
asynSetTraceIOMask("pmd90_port",-1,0)
asynSetTraceMask("pmd90_port",-1,0)
#asynSetTraceIOMask("pmd90_port",-1,0x2)
#asynSetTraceMask("pmd90_port",-1,0x9)

###############################################################################
## Load record instances
dbLoadRecords("$(TOP)/db/devPMD90.db","user=nanopos,P=$(P),R=$(R),PORT=pmd90_port,A=0")

iocInit()
#var streamDebug 1
dbpr $(P)$(R)VERSION

