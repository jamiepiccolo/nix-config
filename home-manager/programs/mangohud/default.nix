{ config, lib, pkgs, ... }:

{
  programs.mangohud = {
    package = pkgs.mangohud_git;
    enable = true;
    settings = {
      vsync = 1;
      gl_vsync = 0;
      horizontal = true;
      fps = true;
      gpu_stats = 1;
      cpu_stats = 1;
      frametime = false;
      throttling_status = false;
      frame_timing = false;
      histogram = false;
      hud_compact = true;
      background_alpha = 0;
      legacy_layout = 1;
      font_size = 15;
      table_columns = 20;
      hud_no_margin = true;
      gamemode = true;
      position = "top-left";
    };
  };
}
