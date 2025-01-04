{config, pkgs, ... }:

{
  home.username = "dan-alin";
  home.homeDirectory = "/Users/dan-alin";

  home.stateVersion = "24.11"; # Please read the comment before changing.


  fonts.fontconfig.enable = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.git
    pkgs.neovim
    pkgs.zoxide
    pkgs.oh-my-posh
    pkgs.volta
    pkgs.oh-my-zsh
    pkgs.bat
    pkgs.eza
    pkgs.gitui
    pkgs.ripgrep
    pkgs.rustup
    pkgs.nerd-fonts.jetbrains-mono
  ];

  programs.git = {
    enable = true;
    userName = "dan-alin";
    userEmail = "danalin06@gmail.com";
    
    extraConfig = {
      core.editor = "nvim";

      init.defaultBranch = "main";
    };
  };


  programs.zsh = {
  	enable = true;
	  enableCompletion = true;
	  autosuggestion.enable = true;
	  syntaxHighlighting.enable = true;
	  shellAliases = {
		  vm = "nvim";
		  cl = "clear";
		  zshc = "vm ~/.zshrc";
      pn = "pnpm";
		  gui = "gitui";
		  ls = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
      reload = "home-manager switch && exec zsh";
	};

	oh-my-zsh.enable = true;
	oh-my-zsh.plugins = [ "git"];
	oh-my-zsh.theme = "";
};


    	
 home.file = {
    ".zshrc".text = ''
      export VOLTA_HOME="$HOME/.volta"
      export PATH="$VOLTA_HOME/bin:$PATH"
      export BAT_THEME="tokyonight_night"

      eval "$(oh-my-posh init zsh --config ${config.home.homeDirectory}/.config/home-manager/oh-my-posh/tokyonight_storm.omp.json)"
      eval "$(zoxide init --cmd cd zsh)"
    '';

    ".config/nvim".source = ./nvim;

    ".warp".source = ./.warp;
  };


  home.sessionVariables = {
     EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  home.activation = {

    configure-rustup = ''
      echo "Setting rustup default toolchain..."
      export PATH="$HOME/.nix-profile/bin:$PATH"
      rustup default stable
      echo "Rustup configuration completed."
    '';

    configure-volta = ''
      echo "Running Volta configuration..."
      export VOLTA_HOME="$HOME/.volta"
      export PATH="$VOLTA_HOME/bin:/Users/dan-alin/.nix-profile/bin:$PATH"
    
      volta install node
      volta install npm
      volta install pnpm
      echo "Volta configuration completed."
    '';
  };

}
