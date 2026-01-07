{
  osConfig,
  ...
}:
{
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        #set -x PATH "$HOME/.local/bin:$PATH"
        #set -e ANDROID_SDK_ROOT

        # Lauches Hyprland on startup
        if test (tty) = "/dev/tty1"
            exec start-hyprland
        end

        abbr --add dotdot --regex '^\.\.+$' --function multicd
        abbr --add mkdir mkdir -p
        abbr --add clear "clear && printf '\e[3J'"
        abbr --add clr "clear && krabby random --no-title"
        abbr --add tr "tree -a -f -I ".git""
        abbr --add trd "tree -a -d"
        abbr --add l "eza -lh"
        abbr --add ls "eza -1 -a"
        abbr --add ld "eza -lhD"
      '';
      functions = {
        y = ''
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
	        yazi $argv --cwd-file="$tmp"
          if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
        '';
        fish_greeting = ''krabby random --no-title'';
        multicd = ''echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)'';
        fish_prompt = ''
          set -g __fish_git_prompt_show_informative_status true
          set -g __fish_git_prompt_showcolorhints true
          set -g __fish_git_prompt_char_stateseparator |
          set -g __fish_git_prompt_color_branch ${osConfig.style.colors.base0D}

          set -g fish_color_param ${osConfig.style.colors.base05}
          set -g fish_color_autosuggestion ${osConfig.style.colors.base0A}
          set -g fish_color_command ${osConfig.style.colors.base0A}

          set -l last_status $status
          set -l arrow ' ⮞ '
          set -l show_status 

          if test $last_status -ne 0
              set arrow (set_color ${osConfig.style.colors.base08}) $arrow (set_color normal)
              set show_status (set_color ${osConfig.style.colors.base08}) "[$last_status]" (set_color normal)
          end

          string join "" -- (set_color ${osConfig.style.colors.base0A}) (prompt_pwd --full-length-dirs 2) (set_color normal) (fish_git_prompt) $show_status (set_color ${osConfig.style.colors.base0E}) $arrow (set_color normal)
        '';
        fish_right_prompt = ''
          set -l time_counter "$CMD_DURATION ms" 
          string join "" -- (set_color ${osConfig.style.colors.base0A}) "[$time_counter]"
        '';
      };
    };
  };
}
