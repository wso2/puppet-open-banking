# WSO2 Open Banking 1.3.0 Puppet 5 Modules

This repository contains puppet modules for each profile relates to WSO2 Open Banking.

## Quick Start Guide
1. Download and copy the `wso2-obkm-1.3.0.zip` or/and `wso2-obam-1.3.0.zip` to the files directories in `/etc/puppet/code/environments/dev/modules/installers/files` in the Puppetmaster. <br>
Dev refers to the sample environment that you can try these modules.

2. Run necessary profile on puppet agent. More details on this are available in the following section.

## Running Open-Banking profiles in puppet agent
This section describes how to run each profile in a puppet agent.

### API-Manager profile
```bash
export FACTER_profile=obam130
puppet agent -vt
```

### Key-Manager profile
```bash
export FACTER_profile=obkm130
puppet agent -vt
```

## Understanding the Project Structure
In this project each profile of Enterprise Integrator is mapped to a module in puppet. By having this structure each puppet module is considered as a standalone profile so each module can be configured individually without harming any other module.

```
puppet-ob
├── manifests
│   └── site.pp
└── modules
    ├── obam130
    │   ├── files
    │   │   └── ...
    │   ├── manifests
    │   │   ├── init.pp
    │   │   ├── custom.pp
    │   │   ├── params.pp
    │   │   └── startserver.pp
    │   └── templates
    │       └── ...
    ├── obkm130
    │   ├── files
    │   │   └── ...
    │   ├── manifests
    │   │   ├── init.pp
    │   │   ├── custom.pp
    │   │   ├── params.pp
    │   │   └── startserver.pp
    │   └── templates
    │       └── ...
    └── installers
        └── files
            └── ...

```

### Manifests in a module
Each puppet module contains following pp files
- init.pp <br>
This contains the main script of the module.
- custom.pp <br>
This is used to add custom user code to the profile.
- params.pp <br>
This contains all the necessary parameters for main configurations and template rendering.
