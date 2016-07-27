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
    -c /path/to/infoblox.yaml,       use custom config path (defaults: ~/.iblox.yaml, /etc/iblox.yaml)
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

Where `facility` is `dns`, `dhcp` or `both` (which, you guessed it, does both operations)

`dns` operations require passing in an IP and FQDN.
`dhcp` operations require passing in an IP(or network CIDR, we'll select the next available IP), FDQN(well, a name), and MAC address
`both` operations require passing in an IP(or network CIDR, we'll select the next available IP), FDQN(well, a name), and MAC address

Examples:

```
iblox dns delete -f bloxtest.some.domain.com -i 192.168.200.200
```
Would delete the dns entry with BOTH matching IP and name, A record and PTR.

```
iblox both add -f bloxtest.some.domain.com -i 192.168.200.200 -m 00:01:02:03:04:05
```
Would add a static dhcp reservation for this host, as well as make an A record and PTR record for it.


Batch Mode
----------

`-b` `--batch` enables batch mode, and you must supply a path to a file with that switch.
This file can be in 3 formats (well, 6, depending on dns/dhcp operations)

NOTE: Only add/delete is supported for batch mode

For Dns operations:

**csv** (*.csv):
```
some.hostname.com,192.168.100.20
someother.hostname.com,192.100.21
```

**yaml** (*.yaml, or *.yml):
```
---
- :fqdn: some.hostname.com
  :ip: 192.168.10.20
- :ip: 192.168.10.21
  :fqdn: someother.hostname.com
```

**json** (*.json):
```
[{"fqdn":"some.hostname.com","ip":"192.168.10.20"},{"ip":"192.168.10.21","fqdn":"someother.hostname.com"}]
```

example:

```
iblox dns add -b my_batch.csv
```

For DHCP operations:
**csv** (*.csv):
```
some.hostname.com,192.168.100.20,00:01:02:03:04:05
someother.hostname.com,192.100.21,00:01:02:03:04:06
```
Or, use CIDR to do next_ip selection for a given(or all entries)
```
some.hostname.com,192.168.100.0/24,00:01:02:03:04:05
someother.hostname.com,192.100.0/24,00:01:02:03:04:06
```

**yaml** (*.yaml, or *.yml):
```
---
- :fqdn: some.hostname.com
  :ip: 192.168.10.20
  :mac: 00:01:02:03:04:05
- :ip: 192.168.10.21
  :fqdn: someother.hostname.com
  :mac: 00:01:02:03:04:06
```

Or, again, with CIDR:
```
---
- :fqdn: some.hostname.com
  :network: 192.168.10.0/24
  :mac: 00:01:02:03:04:05
- :network: 192.168.10.0/24
  :fqdn: someother.hostname.com
  :mac: 00:01:02:03:04:06
```

And finally, **json**

```
[{"fqdn":"some.hostname.com","ip":"192.168.10.20","mac":"00:01:02:03:04:05"},{"ip":"192.168.10.21","fqdn":"someother.hostname.com",""mac":"00:01:02:03:04:05}]
```

Again, optionally replacing the ip with "network" and a CIDR

**BOTH**
For `both` operations, all the **dhcp** fileformats are vaild/required, since we need all that same info
