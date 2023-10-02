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
      #engine_version = true;
      #vulkan_driver = true;
      gpu_name = true;
      gpu_stats = 1;
      cpu_stats = 1;
      frametime = false;
      throttling_status = false;
      frame_timing = false;
      histogram = false;
      hud_compact = true;
      background_alpha = 0;
      legacy_layout = 0;
      font_size = 18;
      table_columns = 20;
      #width = 400;
      hud_no_margin = true;
      gamemode = true;
      position = "top-left";
    };
  };
}
