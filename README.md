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

4. Execute the following scripts against the given database to create the database schema:


		openbank_am_configdb	:	<WSO2_OB_APIM_HOME>/dbscripts/mysql.sql

		openbank_apimgtdb   	:	<WSO2_OB_KM_HOME>/dbscripts/apimgt/mysql.sql

		openbank_openbankingdb	:	<WSO2_OB_KM_HOME>/dbscripts/finance/openbanking.org.uk/mysql.sql
				                <WSO2_OB_KM_HOME>/dbscripts/finance/event-notification/mysql-5-7.sql
					        <WSO2_OB_APIM_HOME>/dbscripts/finance/dynamic-client-registration/migration-3.1_to_3.2/mysql.sql

		openbank_govdb	    	:	<WSO2_OB_KM_HOME>/dbscripts/mysql.sql

		openbank_iskm_configdb :	<WSO2_OB_KM_HOME>/dbscripts/mysql.sql

		openbank_mbstoredb 	:	<WSO2_OB_APIM_HOME>/dbscripts/mb-store/mysql-mb.sql

		openbank_userdb	:	<WSO2_OB_KM_HOME>/dbscripts/mysql.sql

	
5. Run the following profile on the Puppet agent.

	i. Run Open Banking Key Manager profile:
	
		export FACTER_profile=obkm
		puppet agent -vt

	ii.Run Open Banking API Manager profile:
	
		export FACTER_profile=obam
		puppet agent -vt

## Manifests in a module

The run stages for Puppet are described in `<puppet_environment>/manifests/site.pp`, and they are of the order Main -> Custom.

Each Puppet module contains the following .pp files.

* Main
	* params.pp: Contains all the parameters necessary for the main configuration and template
	* init.pp: Contains the main script of the module.
* Custom
	* custom.pp: Used to add custom configurations to the Puppet module.	