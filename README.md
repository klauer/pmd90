PiezoMotor PMD90 EPICS Device Support
=====================================

EPICS StreamDevice driver for PiezoMotor PMD90 single-axis microstepping piezo drivers.

This is a simple driver that gives access to:
    1. Raw and calculated encoder positions
    2. Waveform mode settings
    3. Movement in positive/negative steps, stopping
    4. Writing to NVRAM
    5. Movement, digital input status

Requirements
------------

Though it may work on other versions, the driver was tested on these:

1. EPICS base 3.14.12.3 http://www.aps.anl.gov/epics/
2. asyn 4-18 http://www.aps.anl.gov/epics/modules/soft/asyn/
3. StreamDevice 2.5+ http://epics.web.psi.ch/software/streamdevice/
4. PCRE http://www.pcre.org/

Optional
--------

1. EDM http://ics-web.sns.ornl.gov/edm/log/getLatest.php

Installation
------------

1. Install EPICS
    1. If using a Debian-based system (e.g., Ubuntu), use the packages here http://epics.nsls2.bnl.gov/debian/
    2. If no packages are available for your distribution, build from source
2. Edit configure/RELEASE
    1. Point the directories listed in there to the appropriate places
    2. If using the Debian packages, everything can be pointed to /usr/lib/epics
3. Edit iocBoot/iocPMD90/st.cmd
    1. Change the shebang on the top of the script if your architecture is different than linux-x86:
        #!../../bin/linux-x86/PMD90
        (check if the environment variable EPICS_HOST_ARCH is set, or perhaps `uname -a`, or ask someone if
         you don't know)
    2. The following lines set the prefix to all of the additional (i.e., non-motor record) PVs (with $(P)$(R)):
        ```
        epicsEnvSet "P" "$(P=E1:)"
        epicsEnvSet "R" "$(R=PMD90:)"
        ```
       Set the second quoted strings appropriately.
    3. If the devices have been modified to allow RS-232 connections via a serial device server, set the IP address of the server here:
        ```
        epicsEnvSet "PMD90_IP" "$(PMD90_IP=10.0.0.11)"
        epicsEnvSet "PMD90_PORT" "$(PMD90_PORT=4015)"
        ```

       If not, comment out the drvAsynIPPortConfigure line and uncomment
        ```
        ## for direct connection to the machine's serial port:

        # drvAsynSerialPortConfigure("$(ASYN_PORT)", "/dev/ttyUSB0", 0, 0, 0)
        ```
    4. For each device, load the necessary records:
        ```
        dbLoadRecords("$(TOP)/db/devPMD90.db","P=$(P),R=$(R),PORT=$(ASYN_PORT),A=0")
        ```

4. Go to the top directory and `make`
5. If all goes well:
    ```
    $ cd iocBoot/iocPMD90
    $ chmod +x st.cmd
    $ ./st.cmd
    ```

6. Run EDM:
    ```
    $ export EDMDATAFILES=$TOP/op/edl:$EDMDATAFILES
    $ edm -x -m "P=E1:,R=PMD90:" PMD90
    ```

TODO
----

1. PCRE should not be required -- can edit `read_string` to use different syntax.
2. Is this all the functionality the PMD90 has? ...
