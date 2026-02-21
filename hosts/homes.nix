{ lib, hosts }:
lib.mapAttrs' (
  name: host:
  {
    name = "${host.user}@${name}";
    value = {
      system = host.system;
      module = host.homeModule;
      user = host.user;
      hostName = name;
    };
  }
) (lib.filterAttrs (_: host: host.homeModule != null) hosts)
