local shebang_nix = s({trig = "#!", name = [[Shebang (nix)]]}, {
  t([[#!/run/current-system/sw/bin/bash]])
})
return {
  shebang_nix
}

