# iblox

A simple infoblox cli wapper script
-----------------------------------

Installation
------------

`gem install iblox`

Configuration
-------------
See the `iblox.config.yaml` in this repo for an example. Place a similar file in either
`~/.iblox.yaml` or `/etc/iblox.yaml`. Or, pass in cli options each run.

Options (config):
--------

`username`: User to connect to infoblox api as.

`password`: Password for user to connect to infoblox api

`host`: Infoblox api host

`wapi_version`: API version to use. Default = '2.0'

`range`: Boolean, defaults to false. Pick new IP addresses from a dhcp range, otherwise pick from the subnet.

Usage(cli):

see `--help`, but, generally:

```
Usage iblox <Facility (dns|dhcp)> <action>(add|update|delete) [options]
    -c /path/to/infoblox.yaml,       use custom config path (~/.infoblox.yaml, /etc/infoblox.yaml)
        --config
    -f, --fqdn FQDN                  FQDN or add/update/remove
    -h, --new-fqdn FQDN              New FQDN if updating a record
    -n, --network 192.168.0.0/24     CIDR of network to use
    -i, --ip 192.168.1.1             IP address to use (if adding a record, this can be ommtted for next avialable, must specify network however)
    -j, --new-ip 192.168.1.2         New ip address if updating a record
    -m, --mac 00:05:67:45:32:01      Mac Address to use
    -p, --new-mac 00:05:67:45:32:02  New Mac Address to use
    -a, --api 2.0                    WAPI Version
    -r, --range                      Use a DHCP range when finding addresses
    -v, --verbose                    Be verbose
```



iblox `facility` `action` `options/switches`

Where `facility` is `dns` or `dhcp` (some day I'll add a "both"), and `action` is `add`, `delete` or `update`

Examples:

```
iblox dns delete -f bloxtest.some.domain.com -i 192.168.200.200
```
