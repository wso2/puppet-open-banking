# Puppet Modules for WSO2 Open Banking

This repository contains the Puppet modules for WSO2 Open Banking.

## Quick Start Guide

1. Download a wso2obkm-1.4.0.zip and copy it to the `<puppet_environment>/modules/obkm140/files/packs` directory in the **Puppetmaster**. Download a wso2obam-1.4.0.zip and copy it to the `<puppet_environment>/modules/obam140/files/packs` directory in the **Puppetmaster**.

2. Set up the JDK distribution as follows:

	i. Download Java SE Development Kit 8u161 for Linux x64 from [here](https://www.oracle.com/technetwork/java/javase/downloads/java-archive-javase8-2177648.html) and copy .tar into the `<puppet_environment>/modules/obkm140/files/jdk` and `<puppet_environment>/modules/obam140/files/jdk` directories.<br>
	ii. Reassign the *$jdk_name* variable in `<puppet_environment>/modules/obkm140/manifests/params.pp` and `<puppet_environment>/modules/obam140/manifests/params.pp` to the name of the downloaded JDK distribution.

3. Install the database and create the following databases.

	openbank_am_configdb  

	openbank_apimgt_statsdb

	openbank_apimgtdb

	openbank_openbankingdb

	openbank_govdb

	openbank_iskm_configdb       

	openbank_mbstoredb

	openbank_userdb

4. Run the database scripts [here](https://docs.wso2.com/display/OB140/Configuring+Databases) to populate the tables

5. Run the following profile on the Puppet agent.

	i. Open Banking Key Manager profile:
	
		export FACTER_profile=obkm140
		puppet agent -vt

	ii.Open Banking Key Manager profile:
	
		export FACTER_profile=obam140
		puppet agent -vt

## Manifests in a module

The run stages for Puppet are described in `<puppet_environment>/manifests/site.pp`, and they are of the order Main -> Custom.

Each Puppet module contains the following .pp files.

* Main
	* params.pp: Contains all the parameters necessary for the main configuration and template
	* init.pp: Contains the main script of the module.
* Custom
	* custom.pp: Used to add custom configurations to the Puppet module.	
