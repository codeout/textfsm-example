# textfsm-example

This repo demonstrates how effective TextFSM is compared to plain ruby.

## python

```shell
poetry install
poetry run python python/parse.py
```

will print:

```python
[{'address': '192.168.0.2/30', 'name': 'Ethernet1', 'shutdown': ''},
 {'address': '192.168.0.3/30', 'name': 'Ethernet2', 'shutdown': ''},
 {'address': '', 'name': 'Ethernet3', 'shutdown': 'shutdown'},
 {'address': '', 'name': 'Ethernet4', 'shutdown': 'shutdown'}]
[{'address_family': '',
  'asn': '65000',
  'neighbor': '192.168.0.2',
  'peer_group': 'foo',
  'router_id': '192.168.0.1'},
 {'address_family': '',
  'asn': '65000',
  'neighbor': '192.168.0.3',
  'peer_group': 'foo',
  'router_id': '192.168.0.1'},
 {'address_family': 'ipv4',
  'asn': '65000',
  'neighbor': 'foo',
  'peer_group': '',
  'router_id': '192.168.0.1'},
 {'address_family': 'ipv6',
  'asn': '65000',
  'neighbor': 'foo',
  'peer_group': '',
  'router_id': '192.168.0.1'}]
```

## ruby

```shell
ruby ruby/parse.rb
```

will print:

```ruby
{:interfaces=>
  [{:name=>"Ethernet1", :address=>"192.168.0.2/30"},
   {:name=>"Ethernet2", :address=>"192.168.0.3/30"},
   {:name=>"Ethernet3", :shutdown=>"shutdown"},
   {:name=>"Ethernet4", :shutdown=>"shutdown"}],
 :bgp=>
  [[{:asn=>"65000", :router_id=>"192.168.0.1", :neighbor=>"192.168.0.2", :peer_group=>"foo"},
    {:asn=>"65000", :router_id=>"192.168.0.1", :neighbor=>"192.168.0.3", :peer_group=>"foo"},
    {:asn=>"65000", :router_id=>"192.168.0.1", :address_family=>"ipv4", :neighbor=>"foo"},
    {:asn=>"65000", :router_id=>"192.168.0.1", :address_family=>"ipv6", :neighbor=>"foo"}]]}
```
