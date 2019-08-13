<h1>Puppet Modules for WSO2 Open Banking<h1> 

This repository contains the Puppet modules for WSO2 Open Banking.

Quick Start Guide

1. Download a wso2obkm-1.4.0.zip and copy it to the <puppet_environment>/modules/is_common/files/packs directory in the Puppetmaster.The run stages for Puppet are described in <puppet_e

2. Set up the JDK distribution as follows:
	i. Download Java SE Development Kit 8u161 for Linux x64 from "https://www.oracle.com/technetwork/java/javase/downloads/java-archive-javase8-2177648.html" and copy .tar into the <puppet_environment>/modules/is_common/files/jdk directory.
	ii. Reassign the $jdk_name variable in <puppet_environment>/modules/is_common/manifests/params.pp to the name of the downloaded JDK distribution.

3. Run the following profile on the Puppet agent.
	i. Open Banking Key Manager profile:
	
		export FACTER_profile=obkm
		puppet agent -vt

Manifests in a module

The run stages for Puppet are described in <puppet_environment>/manifests/site.pp, and they are of the order Main -> Custom.

Each Puppet module contains the following .pp files.
	i. Main
		params.pp: Contains all the parameters necessary for the main configuration and template
		init.pp: Contains the main script of the module.
	ii. Custom
		custom.pp: Used to add custom configurations to the Puppet module.	

