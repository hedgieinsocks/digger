# ⛏️ Digger - Handy dig wraper for digging NS/A records in bulk

## Usage

```sh
➜  ~ ./digger.sh
➜  Paste domains and press <ENTER> twice to proceed:
google.com
namecheap.com
facebook.com

DOMAIN                                            NS                                                IP

namecheap.com                                     edns4.ultradns.net                                198.54.117.250
                                                  edns4.ultradns.com
                                                  edns4.ultradns.org
                                                  edns1.registrar-servers.com
                                                  edns2.registrar-servers.com

facebook.com                                      a.ns.facebook.com                                 157.240.224.35
                                                  b.ns.facebook.com
                                                  c.ns.facebook.com
                                                  d.ns.facebook.com

google.com                                        ns2.google.com                                    192.178.25.174
                                                  ns1.google.com
                                                  ns3.google.com
                                                  ns4.google.com
```