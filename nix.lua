local function is_flake()
  return vim.fn.expand("%:t") == "flake.nix"
end

local system = "x86_64-linux"
local flake_snippets = d()
local flake_packages = s({trig="packages", desc = "Executed by \'nix build\'", show_condition = is_flake},
  fmt([[packages."{}"."{}" = {};]], {
    i(1, system),
    i(2, "default"),
    i(3, "derivation")
  })
)
local flake_apps = s({trig ="apps", desc = "Executed by \'nix run\'", show_condition = is_flake},
  fmt(
    [[
      apps."{}"."{}" = {{
        type = {};
        program = {};
      }};
      ]], {
      i(1, system),
      i(2, "default"),
      i(3, "app"),
      i(4, "<store-path>"),
    })
)
local flake_overlays = s({trig="overlays", desc = "Overlays consumed by other flakes", show_condition = is_flake}, 
  fmt([[overlays.{} = final: prev: {{{}}};]],{
    i(1, "default"),
    i(2),
  })
)

local mkShell = s("mkShell",
  fmt([[
  mkShell {{
    packages = with pkgs; [{}];
    inputsFrom = with pkgs; [{}];
    shellHook = ''
      {}
    ''
  }}
  ]], {
    i(1),
    i(2),
    i(3),
  })
)
local mkDerivation = s("mkDerivation",
  fmt([[
mkDerivation {{
  name = "{}";
  src = {};
  buildInputs = with pkgs; [{}];
  phases = ["installPhase" {}];
  installPhase = ''
    mkdir -p $out
    {}
  '';
}}
]], {
    i(1, "name"),
    i(2, "./."),
    i(3),
    i(4),
    i(5),
  }
  )
)
return { 
  flake_packages,
  flake_apps,
  flake_overlays,
  mkShell,
  mkDerivation
}


