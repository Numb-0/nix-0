{
  pkgs,
  config,
  ...
}:
  pkgs.writeShellScriptBin "setup_ags" ''
    #!/usr/bin/env bash
    # Setup AGS

    # Create the AGS configuration directory
    mkdir -p ~/.config/ags

    # Create/Reload colors.scss
    echo "Reloading stylix ags colors..."
    colorpath="$HOME/nix-0/config/ags/ags/scss/colors.scss"
    echo "\$base00: #${config.stylix.base16Scheme.base00};" > $colorpath
    echo "\$base01: #${config.stylix.base16Scheme.base01};" >> $colorpath
    echo "\$base02: #${config.stylix.base16Scheme.base02};" >> $colorpath
    echo "\$base03: #${config.stylix.base16Scheme.base03};" >> $colorpath
    echo "\$base04: #${config.stylix.base16Scheme.base04};" >> $colorpath
    echo "\$base05: #${config.stylix.base16Scheme.base05};" >> $colorpath
    echo "\$base06: #${config.stylix.base16Scheme.base06};" >> $colorpath
    echo "\$base07: #${config.stylix.base16Scheme.base07};" >> $colorpath
    echo "\$base08: #${config.stylix.base16Scheme.base08};" >> $colorpath
    echo "\$base09: #${config.stylix.base16Scheme.base09};" >> $colorpath
    echo "\$base0A: #${config.stylix.base16Scheme.base0A};" >> $colorpath
    echo "\$base0B: #${config.stylix.base16Scheme.base0B};" >> $colorpath
    echo "\$base0C: #${config.stylix.base16Scheme.base0C};" >> $colorpath
    echo "\$base0D: #${config.stylix.base16Scheme.base0D};" >> $colorpath
    echo "\$base0E: #${config.stylix.base16Scheme.base0E};" >> $colorpath
    echo "\$base0F: #${config.stylix.base16Scheme.base0F};" >> $colorpath

    # Copy AGS configuration files
    echo "Copying AGS configuration files..."
    cp -r $HOME/nix-0/config/ags/ags/* ~/.config/ags

    echo "AGS setup complete!"
    ''