# ReactiveBPMDemo

This repo contains the code for the POC that is part of RedHat Session S103127.

# BPM Suite Dockerfile
Dockerfile - This file can be used to build a docker imaging of BPM Suite.
For it to work, you need to create 3 directories:  patch, installers, and support.
It currently installs BPM Suite 6.3 and EAP 6.4.8.
You will need to download the binaries from the RedHat site and put them into the appropriate folders.

* Download the BPM Suite and EAP installers and upload them to the installers directory.
* Download the patch for EAP 6.4.8 and upload this to the patch directory.
* Download these files in the support folder:
    * eap.xml
    * eap.xml.variables
    * bpms.xml
    * bpms.xml.variables

# Kie Server Kafka Extension
You can find David Murphy's at the below repo
https://gitlab.com/murph83/kie-server-kafka.git
