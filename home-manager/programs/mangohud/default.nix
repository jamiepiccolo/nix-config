{ config, lib, pkgs, ... }:

{
  programs.mangohud = {
    package = pkgs.mangohud_git;
    enable = true;
    settings = {
      vsync = 1;
      gl_vsync = 0;
      gpu_stats = 1;
      cpu_stats = 1;
      horizontal = true;
      fps = true;
      frametime = false;
      throttling_status = false;
      frame_timing = false;
      histogram = false;
      # hud_compact = true;
      width = 200;
      background_alpha = 0;
      legacy_layout = 1;
      table_columns = 15;
      hud_no_margin = true;
    };
  };
}
