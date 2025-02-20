{
  pkgs,
  config,
  self,
  ...
}:
  let
    colors = config.stylix.base16Scheme;
  in

  pkgs.writeShellScriptBin "setup_ags" ''
  #!/usr/bin/env bash
  # Setup AGS

  # Create the AGS configuration directory if needed
  mkdir -p ~/.config/ags

  colorpath="${self}/config/ags/ags/scss/colors.scss"
  
  cat << EOF > $colorpath
  \$base00: #${colors.base00};
  \$base01: #${colors.base01};
  \$base02: #${colors.base02};
  \$base03: #${colors.base03};
  \$base04: #${colors.base04};
  \$base05: #${colors.base05};
  \$base06: #${colors.base06};
  \$base07: #${colors.base07};
  \$base08: #${colors.base08};
  \$base09: #${colors.base09};
  \$base0A: #${colors.base0A};
  \$base0B: #${colors.base0B};
  \$base0C: #${colors.base0C};
  \$base0D: #${colors.base0D};
  \$base0E: #${colors.base0E};
  \$base0F: #${colors.base0F};
  EOF
  
  # Copy AGS configuration files
  echo "Copying AGS configuration files..."
  cp -r ${self}/config/ags/ags/* ~/.config/ags

  echo "AGS setup complete!"
  ''
