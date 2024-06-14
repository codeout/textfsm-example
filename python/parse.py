from io import StringIO
from pprint import pprint

from textfsm import TextFSM

interface_template = r"""
Value name (Ethernet\S+)
Value address (\S+)
Value shutdown (shutdown)

Start
  ^interface ${name} -> Interface

Interface
  ^! -> Record Start
  ^\s+ip address ${address}
  ^\s+${shutdown}
"""

bgp_template = r"""
Value Filldown asn (\d+)
Value Filldown router_id (\S+)
Value peer_group (\S+)
Value neighbor (\S+)
Value address_family (\S+)

Start
  ^router bgp ${asn} -> Neighbor

Neighbor
  ^! -> Clearall Start
  ^\s+address-family ${address_family} -> AddressFamily
  ^\s+router-id ${router_id}
  ^\s+neighbor ${neighbor} peer group ${peer_group} -> Record

AddressFamily
  ^\s+! -> Record Neighbor
  ^\s+neighbor ${neighbor} activate
"""

if __name__ == "__main__":
    with open("example.conf") as f:
        config = f.read()

        for t in (interface_template, bgp_template):
            template = StringIO(t.strip())
            parsed = TextFSM(template).ParseTextToDicts(config)
            pprint(parsed)
