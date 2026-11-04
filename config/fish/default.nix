{
  config,
  ...
}:
{
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        #set -x PATH "$HOME/.local/bin:$PATH"
        #set -e ANDROID_SDK_ROOT

        # Launches niri on a login at tty1. niri-session runs a bare
        # `systemctl --user import-environment`, which newer systemd flags
        # as deprecated on the tty; drop just that line, keep other errors
        if test (tty) = "/dev/tty1"
            niri-session 2>| string match -v -- '*import-environment without a list*' >&2
            exit
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

        # Remote hosts lack xterm-kitty terminfo; kitten ssh copies it over
        if test "$TERM" = xterm-kitty
            abbr --add ssh "kitten ssh"
        end
      '';
      functions = {
        fish_greeting = ''krabby random --no-title'';
        multicd = ''echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)'';
        fish_prompt = ''
          set -g __fish_git_prompt_show_informative_status true
          set -g __fish_git_prompt_showcolorhints true
          set -g __fish_git_prompt_char_stateseparator |
          # Colours come from chromix, re-read so a theme switch shows up.
          source ${config.xdg.stateHome}/chromix/current/fish/colors.fish 2>/dev/null

          set -l last_status $status
          set -l arrow ' ⮞ '
          set -l show_status 

          if test $last_status -ne 0
              set arrow (set_color $chromix_red) $arrow (set_color normal)
              set show_status (set_color $chromix_red) "[$last_status]" (set_color normal)
          end

          string join "" -- (set_color $chromix_yellow) (prompt_pwd --full-length-dirs 2) (set_color normal) (fish_git_prompt) $show_status (set_color $chromix_magenta) $arrow (set_color normal)
        '';
        fish_right_prompt = ''
          set -l time_counter "$CMD_DURATION ms" 
          string join "" -- (set_color $chromix_yellow) "[$time_counter]"
        '';
      };
    };
  };
}
