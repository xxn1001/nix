{ pkgs, inputs, ... }:
{
  programs = {
    fish = {
      enable = true;
      shellAbbrs = {
        nixu = "nh os switch --ask";
        homeu = "nh home switch --ask";
        # cd = "z";
      };
      # shellAliases = {
      #   "ls" = "exa";
      #   "l" = "exa -lah --icons=auto";
      # };
      # shellInit = ''
      #   zoxide init fish | source
      #   export PATH="$HOME/.local/bin:$HOME/.juliaup/bin:$PATH"

      #   if test -n "$container"
      #     export PATH="$HOME/.local/bin:$HOME/.juliaup/bin:$HOME/.npm-global/bin:$PATH"
      #     eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"
      #   end

      #   set -g fish_color_command = blue --italics
      #   set -g fish_color_quote = yellow --italics
      # '';
      plugins = with pkgs.fishPlugins; [
        {
          name = "puffer";
          src = puffer.src;
        }
        {
          name = "pisces";
          src = pisces.src;
        }
      ];
      functions = {
        fish_greeting = "";
      };
    };
  };
  programs.man.generateCaches = false;
}
