{
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        #set -x PATH "$HOME/.local/bin:$PATH"
        #set -e ANDROID_SDK_ROOT

        # Lauches Hyprland on startup
        if test (tty) = "/dev/tty1"
            exec Hyprland
        end

        abbr --add dotdot --regex '^\.\.+$' --function multicd
        abbr --add mkdir mkdir -p
        abbr --add clear "clear && printf '\e[3J'"
        abbr --add clr "clear && krabby random --no-title"
        abbr --add ssh "kitten ssh"
        abbr --add tr "tree -a -f -I ".git""
        abbr --add trd "tree -a -d"
        abbr --add l "eza -lh"
        abbr --add ls "eza -1 -a"
        abbr --add ld "eza -lhD"
      '';
      functions = {
        fish_greeting = ''krabby random --no-title'';
        multicd = ''echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)'';
        fish_prompt = ''
        set -g __fish_git_prompt_show_informative_status true
        set -g __fish_git_prompt_showcolorhints true
        set -g __fish_git_prompt_char_stateseparator |
        set -g __fish_git_prompt_color_branch blue

        set -g fish_color_param white
        set -g fish_color_autosuggestion yellow
        
        set -l last_status $status
        set -l arrow ' ⮞ '
        set -l show_status 

        if test $last_status -ne 0
            set arrow (set_color red) $arrow (set_color normal)
            set show_status (set_color red) "[$last_status]" (set_color normal)
        end

        string join "" -- (set_color yellow) (prompt_pwd --full-length-dirs 2) (set_color normal) (fish_git_prompt) $show_status (set_color purple) $arrow (set_color normal)
        '';
        fish_right_prompt = ''
        set -l time_counter "$CMD_DURATION ms" 
        string join "" -- (set_color yellow) "[$time_counter]"
        '';
      };
    };
  };
}
