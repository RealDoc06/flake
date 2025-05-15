{ pkgs, lib, ... }:

{
  vim = {
    theme = {
      enable = true;
      name = "catppuccin";
      style = "frappuccin";
    };

    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
  };

  languages = {
    enableLSP = true;
    enableTreesitter = true;

    nix.enable = true;
    ts.enable = true;
    go.enable = true;
    python.enable = true;
  };
}
