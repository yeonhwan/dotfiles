{...}:
{
  programs.git = {
    enable = true;
    userName = "yeonhwan";
    userEmail = "yeonhwan619@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      merge.tool = "nvimdiff";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
  };
}
