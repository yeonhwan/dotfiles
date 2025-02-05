{pkgs,lib, ...}:
{
  # starship shell prompt
  programs.starship = { 
    enable = true;
    enableZshIntegration = true;

    settings = {
      palettes = {
        teal = {
          tealwhite = "#e8fbfb";
          teal100 = "#b2d8d8";
          teal200 = "#66b2b2";
          teal300 = "#008080";
          teal400 = "#006666";
          teal500 = "#004c4c";
          tealsubtle = "#bec2c2";
          tealblack = "#002727";

        };
      };
      palette = "teal";

      right_format = lib.concatStrings[
        "$memory_usage"
        "$localip"
      ];

      format = lib.concatStrings [ 
        "[](teal100)"
        "[  ](bg:teal100 fg:teal500)"
        "$username"
        "[](bg:teal200 fg:teal100)"
        "$directory"
        "[](fg:teal200 bg:teal300)"
        "$git_branch"
        "$git_status"
        "[](fg:teal300 bg:teal400)"
        "$nodejs"
        "$rust"
        "$golang"
        "$php"
        "$nix_shell"
        "$lua"
        "$python"
        "[](fg:teal400 bg:teal500)"
        "$time"
        "[ ](fg:teal500)"
        "$character" 
      ];
      username = { 
        show_always = true;
        style_user = "bold bg:teal100 fg:teal500";
        style_root = "bg:teal100 fg:teal500";
        format = "[ $user ]($style)";
      };
      continuation_prompt = "🏃";
      directory = { 
        style = "fg:teal400 bg:teal200";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/"; 

        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };
      };
      localip = {
        disabled = false;
        ssh_only = false;
        format = "🌐 [$localipv4](dimmed fg:tealwhite)"; 
      };
      memory_usage = {
        disabled = false;
        symbol = "🤖";
        format = "$symbol [$ram_pct](dimmed fg:tealwhite) ";
      };
      git_branch = {
        symbol = "";
        style = "bg:teal300";
        format = "[[ $symbol $branch ](fg:tealblack bg:teal300)]($style)";
      };
      git_status = {
        style = "bg:teal300";
        format = "[[($all_status$ahead_behind )](fg:tealblack bg:teal300)]($style)";
      };

      # lang specific
      nodejs = {
        symbol = "";
        style = "bg:teal400";
        format = "[[ $symbol ($version) ](fg:tealwhite bg:teal400)]($style)";
      };
      rust = { 
        symbol = "";
        style = "bg:teal400";
        format = "[[ $symbol ($version) ](fg:tealwhite bg:teal400)]($style)";
      };

      golang = { 
        symbol = "";
        style = "bg:teal400";
        format = "[[ $symbol ($version) ](fg:tealwhite bg:teal400)]($style)";
      };

      php = { 
        symbol = "";
        style = "bg:teal400";
        format = "[[ $symbol ($version) ](fg:tealwhite bg:teal400)]($style)" ;
      };

      nix_shell = { 
        disabled = false;
        symbol = "";
        style = "bg:teal400";
        format = "[[ $symbol ($version) ](fg:tealwhite bg:teal400)]($style)" ;
      };

      lua = { 
        symbol = "";
        style = "bg:teal400";
        format = "[[ $symbol ($version) ](fg:tealwhite bg:teal400)]($style)" ;
      };

      time = { 
        disabled = false;
        # Hour:Minute Format
        time_format = "%R";   
        style = "bg:teal500";
        format = "[[  $time ](fg:tealwhite bg:teal500)]($style)";
      };
    };};
}
