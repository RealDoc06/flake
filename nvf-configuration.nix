{ pkgs, lib, ... }:

{
  vim = {
    theme = {
      enable = true;
      name = "catppuccin";
      style = "frappe";
    };

    # Auto tab
    globals.editorconfig = true;
    utility.sleuth.enable = true;

    lsp.enable = true;
    
#    options = {  
#      shiftwidth = 2;
#    };

    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;

    languages = {
      enableTreesitter = true;

      nix.enable = true;
      lua.enable = true;
      css.enable = true;
      html.enable = true;
      ts.enable = true;
      go.enable = true;
      python.enable = true;
    };
  };
}
