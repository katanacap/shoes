{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [
    pkgs.curl
    pkgs.git
    pkgs.jq
    pkgs.just
    pkgs.tree
    pkgs.werf
    pkgs.postgresql

    pkgs.rustup
    pkgs.sccache
    pkgs.cargo-outdated
    pkgs.cargo-nextest
    pkgs.cargo-audit
    pkgs.rust-analyzer
  ] ++ lib.optionals pkgs.stdenv.isDarwin (with pkgs.darwin.apple_sdk; [
    frameworks.SystemConfiguration
    frameworks.Security
    frameworks.CoreFoundation
  ]);

  languages.nix.enable = true;
  languages.rust.enable = true;

  env.RUSTC_WRAPPER = "${pkgs.sccache}/bin/sccache";

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/git-hooks/
  # git-hooks.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
