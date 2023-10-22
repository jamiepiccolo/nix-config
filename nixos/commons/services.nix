{ pkgs, ... }:
{
  # systemd = {
  #   user.services.polkit-kde-authentication-agent-1 = {
  #     description = "polkit-kde-authentication-agent-1";
  #     wantedBy = [ "graphical-session.target" ];
  #     wants = [ "graphical-session.target" ];
  #     after = [ "graphical-session.target" ];
  #     serviceConfig = {
  #       Type = "simple";
  #       ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
  #       Restart = "on-failure";
  #       RestartSec = 1;
  #       TimeoutStopSec = 10;
  #     };
  #   };
  # };

  systemd = {
    packages = [
      (pkgs.cloudflare-warp.overrideAttrs (old: {
        postInstall = ''
          wrapProgram $out/bin/warp-svc --prefix PATH : ${pkgs.lib.makeBinPath [pkgs.nftables pkgs.lsof pkgs.iproute2]}
        '';
      }))
    ];
    services.warp-svc = {
      after = [ "network-online.target" "systemd-resolved.service" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        StateDirectory = "cloudflare-warp";
        #User = "warp";
        #Umask = "0077";
        # Hardening
        # LockPersonality = true;
        # PrivateMounts = true;
        # PrivateTmp = true;
        # ProtectControlGroups = true;
        # ProtectHostname = true;
        # ProtectKernelLogs = true;
        # ProtectKernelModules = true;
        # ProtectKernelTunables = true;
        # ProtectProc = "invisible";
        # # Leaving on strict activates warp on plus
        # ProtectSystem = true;
        # RestrictNamespaces = true;
        # RestrictRealtime = true;
      };
    };
  };
  services.ananicy = {
    package = pkgs.ananicy-cpp;
    enable = true;
    rulesProvider = pkgs.ananicy-cpp;
    extraRules = [
      {
        "name" = "gamescope";
        "nice" = -20;
      }
    ];
  };
}
