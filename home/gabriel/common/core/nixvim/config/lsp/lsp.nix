{ ... }:
{
  config.programs.nixvim.extraConfigLua = ''
    local _border = "rounded"

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = _border
      }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
        border = _border
      }
    )

    vim.diagnostic.config{
      float={border=_border}
    };

    require('lspconfig.ui.windows').default_options = {
      border = _border
    }
  '';
  config.programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      cssls = {
        enable = true;
      };
      tailwindcss = {
        enable = true;
      };
      solc = {
        enable = false;
      };
      biome = {
        enable = true;
      };
      astro = {
        enable = true;
      };
      rust-analyzer = {
        enable = false;
        installCargo = true;
        installRustc = true;
        settings = {
          # hint = {enable = true;};
          cargo.features = "all";
          checkOnSave = true;
          check.command = "clippy";
          # inlayHints = {
          #   enable = true;
          #   showParameterNames = true;
          # parameterHintsPrefix = "<- ";
          #   otherHintsPrefix = "=> ";
          # };
          procMacro = {
            enable = true;
          };
        };
      };
      clangd = {
        enable = true;
      };
      lua-ls = {
        enable = true;
        extraOptions = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace";
              };
              telemetry = {
                enabled = false;
              };
              hint = {
                enable = true;
              };
            };
          };
        };
      };
      nil-ls = {
        enable = true;
      };
      tsserver = {
        enable = true;
        filetypes = [
          "javascript"
          "javascriptreact"
          "typescript"
          "typescriptreact"
        ];
        extraOptions = {
          settings = {
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true;
                includeInlayFunctionLikeReturnTypeHints = true;
                includeInlayFunctionParameterTypeHints = true;
                includeInlayParameterNameHints = "all";
                includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                includeInlayPropertyDeclarationTypeHints = true;
                includeInlayVariableTypeHints = true;
              };
            };
            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true;
                includeInlayFunctionLikeReturnTypeHints = true;
                includeInlayFunctionParameterTypeHints = true;
                includeInlayParameterNameHints = "all";
                includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                includeInlayPropertyDeclarationTypeHints = true;
                includeInlayVariableTypeHints = true;
              };
            };
          };
        };
      };
      eslint = {
        enable = true;
      };
      bashls = {
        enable = true;
      };
      ruff = {
        enable = true;
      };
    };
  };
}
