{
  config.xdg.configFile = {
    "wofi/wallpaper_select_config" = {
      text = ''
        prompt=Select wallpaper...
        allow_images=true
        hide_scroll=false
        image_size=700
        width=800
        height=1200
        hide_search=false
        orientation=vertical
        halign=center
        valign=start
      '';
    };

    "wofi/wallpaper_select_style.css" = {
      text = ''
        @import "/home/gabriel/.config/wofi/style.css";

        #input {
          display: none;
        }

        #entry:selected {
          border: 0.11em solid @lavender;
          border-radius: 0.5em;
        }

        #img, #entry {
          display: inline;
        }
      '';
    };

    "wofi/themes/macchiato.css" = {
      text = ''
        @define-color	rosewater  #f4dbd6;
        @define-color	rosewater-rgb  rgb(244, 219, 214);
        @define-color	flamingo  #f0c6c6;
        @define-color	flamingo-rgb  rgb(240, 198, 198);
        @define-color	pink  #f5bde6;
        @define-color	pink-rgb  rgb(245, 189, 230);
        @define-color	mauve  #c6a0f6;
        @define-color	mauve-rgb  rgb(198, 160, 246);
        @define-color	red  #ed8796;
        @define-color	red-rgb  rgb(237, 135, 150);
        @define-color	maroon  #ee99a0;
        @define-color	maroon-rgb  rgb(238, 153, 160);
        @define-color	peach  #f5a97f;
        @define-color	peach-rgb  rgb(245, 169, 127);
        @define-color	yellow  #eed49f;
        @define-color	yellow-rgb  rgb(238, 212, 159);
        @define-color	green  #a6da95;
        @define-color	green-rgb  rgb(166, 218, 149);
        @define-color	teal  #8bd5ca;
        @define-color	teal-rgb  rgb(139, 213, 202);
        @define-color	sky  #91d7e3;
        @define-color	sky-rgb  rgb(145, 215, 227);
        @define-color	sapphire  #7dc4e4;
        @define-color	sapphire-rgb  rgb(125, 196, 228);
        @define-color	blue  #8aadf4;
        @define-color	blue-rgb  rgb(138, 173, 244);
        @define-color	lavender  #b7bdf8;
        @define-color	lavender-rgb  rgb(183, 189, 248);
        @define-color	text  #cad3f5;
        @define-color	text-rgb  rgb(202, 211, 245);
        @define-color	subtext1  #b8c0e0;
        @define-color	subtext1-rgb  rgb(184, 192, 224);
        @define-color	subtext0  #a5adcb;
        @define-color	subtext0-rgb  rgb(165, 173, 203);
        @define-color	overlay2  #939ab7;
        @define-color	overlay2-rgb  rgb(147, 154, 183);
        @define-color	overlay1  #8087a2;
        @define-color	overlay1-rgb  rgb(128, 135, 162);
        @define-color	overlay0  #6e738d;
        @define-color	overlay0-rgb  rgb(110, 115, 141);
        @define-color	surface2  #5b6078;
        @define-color	surface2-rgb  rgb(91, 96, 120);
        @define-color	surface1  #494d64;
        @define-color	surface1-rgb  rgb(73, 77, 100);
        @define-color	surface0  #363a4f;
        @define-color	surface0-rgb  rgb(54, 58, 79);
        @define-color	base  #24273a;
        @define-color	base-rgb  rgb(36, 39, 58);
        @define-color	mantle  #1e2030;
        @define-color	mantle-rgb  rgb(30, 32, 48);
        @define-color	crust  #181926;
        @define-color	crust-rgb  rgb(24, 25, 38);
      '';
    };
  };

  config.programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 600;
      prompt = "Search...";
      allow_images = true;
      gtk_dark = true;
      image_size = 24;
      term = "kitty";
      hide_scroll = true;
    };
    style = ''
      @import "/home/gabriel/.config/wofi/themes/macchiato.css";

      * {
        font-family: 'Pixel Code', monospace;
        font-size: 18px;
      }

      /* Window */
      window {
        margin: 0px;
        padding: 10px;
        border: 0.16em solid @lavender;
        border-radius: 0.5em;
        background-color: @base;
        animation: slideIn 0.5s ease-in-out both;
      }

      /* Slide In */
      @keyframes slideIn {
        0% {
           opacity: 0;
        }

        100% {
           opacity: 1;
        }
      }

      /* Inner Box */
      #inner-box {
        margin: 5px;
        padding: 10px;
        border: none;
        background-color: @base;
        animation: fadeIn 0.5s ease-in-out both;
      }

      /* Fade In */
      @keyframes fadeIn {
        0% {
           opacity: 0;
        }

        100% {
           opacity: 1;
        }
      }

      /* Outer Box */
      #outer-box {
        margin: 5px;
        padding: 10px;
        border: none;
        background-color: @base;
      }

      /* Scroll */
      #scroll {
        margin: 0px;
        padding: 10px;
        border: none;
        background-color: @base;
      }

      /* Input */
      #input {
        margin: 5px 20px;
        padding: 10px;
        border: 1px solid @flamingo;
        border-radius: 0.5em;
        color: @text;
        background-color: @base;
        animation: fadeIn 0.5s ease-in-out both;
      }

      #input image {
          border: none;
          color: @red;
      }

      #input * {
        outline: 4px solid @red!important;
      }

      /* Text */
      #text {
        margin: 5px;
        border: none;
        color: @text;
        animation: fadeIn 0.5s ease-in-out both;
      }

      #entry {
        background-color: @base;
      }

      #entry arrow {
        border: none;
        color: @lavender;
      }

      /* Selected Entry */
      #entry:selected {
        /* border: 0.11em solid @lavender; */
        /* border-radius: 0.5em; */
      }

      #entry:selected #text {
        color: @mauve;
      }

      #entry:drop(active) {
        background-color: @lavender!important;
      }
    '';
  };
}
