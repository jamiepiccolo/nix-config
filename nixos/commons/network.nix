{ pkgs, ... }:
{
  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    General = {
      EnableNetworkConfiguration = true;
    };
  };

  networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  services.resolved = {
    enable = true;
    domains = [ "~." ];
  };

  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez5-experimental;
    powerOnBoot = true;
    settings = {
      General = {
        Class = "0x000100";
        ControllerMode = "bredr";
        FastConnectable = true;
        JustWorksRepairing = "always";
        Privacy = "device";
        Experimental = true;
      };
    };
  };

  systemd.user.services.telephony_client.enable = false;

  # wayvnc
  networking.firewall.allowedTCPPorts = [ 5900 ];
  networking.firewall.allowedUDPPorts = [ 5900 ];

}
