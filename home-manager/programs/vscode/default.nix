{ pkgs, ...}:
{
  programs.vscode = {
    enable = true;
    #package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      usernamehw.errorlens
    ];
    userSettings = {
      "nix.enableLanguageServer" = true;
      "window.titleBarStyle" = "custom";
      "explorer.confirmDragAndDrop" = false;
    };
  };
}
