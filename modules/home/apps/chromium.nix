{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;

    package = pkgs.ungoogled-chromium.override {
      enableWideVine = true;
    };

    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # Ublock
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
      { id = "oboonakemofpalcgghocfoadofidjkkk"; } # KeepassXC
    ];
  };
}
