# Puppet Modules for WSO2 Open Banking

This repository contains the Puppet modules for WSO2 Open Banking.

## Quick Start Guide

1. Download the following zip files:<br>

    * wso2-obiam-2.0.0-M2.zip <br>
    * wso2-obam-2.0.0-M2.zip <br>

    Copy them to the `<puppet_environment>/modules/ob_common/files/packs` directory in the **Puppetmaster**.

2. Set up the JDK distribution as follows:

    The Puppet modules for WSO2 Open Banking use Oracle JDK 8 as the JDK distribution. However, you can use any [supported JDK distribution](https://docs.wso2.com/display/compatibility/Tested+Operating+Systems+and+JDKs).

    a. Download Java SE Development Kit 8u161 for Linux x64 from [here](https://www.oracle.com/technetwork/java/javase/downloads/java-archive-javase8-2177648.html) and copy the archive into the
    `<puppet_environment>/modules/ob_common/files/jdk` directory of **Puppetmaster**. <br> (please make sure that the name of the archive 
    matches with the name of the extracted folder Ex: jdk1.8.0_161) <br>
    b. Reassign the *$jdk_name* variable in `<puppet_environment>/modules/ob_common/manifests/params.pp` to the name of the downloaded JDK distribution.

3. Change the hostnames in `<puppet_environment>modules/ob_common/manifests/params.pp` of **Puppetmaster**.

4. Set up the databases in the **Puppet agent** by following the [Configuring Databases](https://docs.wso2.com/display/OB140/Configuring+Databases) documentation. <br>
   Update the `<puppet_environment>modules/ob_common/manifests/params.pp` of **Puppetmaster** to point the created databases.
   
5. Run the following profiles on the **Puppet agent**, by executing the following commands.

    a. To run the ```Open Banking Identity & Access Management profile```:

        export FACTER_profile=obiam
        puppet agent -vt

    b. To run the ```Open Banking API Manager profile```:

        export FACTER_profile=obam
        puppet agent -vt

6. To use a custom Java KeyStore (JKS) file in Open Banking Key Manager and Open Banking API Manager, follow the steps below:

	a. Create a custom JKS by following the steps in the [Creating New Keystores](https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores#CreatingNewKeystores-ca_certificateAddingCA-signedcertificatestokeystores) documentation.

    b. Create the following directories in the **Puppetmaster**:

		 <puppet_environment>/modules/obam/files/repository/resources/security
		 <puppet_environment>/modules/obiam/files/repository/resources/security

	c. Copy the custom JKS file into both directories. <br>

	d. Update the *$file_list* variable in the files below, with the custom JKS file path ```(repository/resources/security/custom_jks.jks)```. <br> 

		 <puppet_environment>/modules/obam/manifests/params.pp

            $file_list = ['repository/resources/security/custom_jks.jks',] 

		 <puppet_environment>/modules/obiam/manifests/params.pp

            $file_list = ['repository/resources/security/custom_jks.jks',] 

## Manifests in a module

The run stages for Puppet are described in `<puppet_environment>/manifests/site.pp`, and they follow the given order Main -> Custom.

Each Puppet module contains the following ```.pp``` files.

* Main
    * params.pp: Contains all the parameters required for main configuration and template.
    * init.pp: Contains the main script of the module.
* Custom
    * custom.pp: To add custom configurations to the Puppet module.
