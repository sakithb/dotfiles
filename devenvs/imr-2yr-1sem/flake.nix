{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      # --- Configuration ---
      dbPort = "3306";
      dbUser = "root";

      # --- Scripts (Replaces Aliases) ---
      # These create real executables in the Nix store that are added to your PATH.

      start_db = pkgs.writeShellScriptBin "start_db" ''
        if [ -z "$MYSQL_HOME" ]; then echo "Error: MYSQL_HOME not set."; exit 1; fi
        echo "Starting MySQL..."
        ${pkgs.mariadb}/bin/mysqld --datadir=$MYSQL_DATADIR --pid-file=$PID_FILE \
          --socket=$SOCKET_PATH --port=${dbPort} --bind-address=127.0.0.1 &
        echo "MySQL started in background."
      '';

      stop_db = pkgs.writeShellScriptBin "stop_db" ''
        if [ -z "$PID_FILE" ]; then echo "Error: PID_FILE var not set."; exit 1; fi
        if [ -f "$PID_FILE" ]; then
          kill $(cat $PID_FILE)
          echo "MySQL stopped."
        else
          echo "No PID file found. Is MySQL running?"
        fi
      '';

      mysql_client = pkgs.writeShellScriptBin "mysql_client" ''
        ${pkgs.mariadb}/bin/mysql -u ${dbUser} --socket=$SOCKET_PATH "$@"
      '';

    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          # Node & SvelteKit Tools
          pkgs.nodejs_22
          pkgs.nodePackages.pnpm
          
          # Database Packages
          pkgs.mariadb
          pkgs.dbeaver-bin

          # Our Custom Scripts
          start_db
          stop_db
          mysql_client
        ];

        # We keep shellHook for ENV VARS only, which direnv can capture.
        shellHook = ''
          export MYSQL_HOME=$PWD/_db
          export MYSQL_DATADIR=$MYSQL_HOME/data
          export SOCKET_PATH=$MYSQL_HOME/mysql.sock
          export PID_FILE=$MYSQL_HOME/mysql.pid

          # Initialize DB if it doesn't exist (Runs once)
          if [ ! -d "$MYSQL_HOME" ]; then
            echo "Initializing local MySQL database..."
            mkdir -p $MYSQL_HOME
            ${pkgs.mariadb}/bin/mysql_install_db --auth-root-authentication-method=normal \
              --datadir=$MYSQL_DATADIR --basedir=${pkgs.mariadb} \
              --pid-file=$PID_FILE > /dev/null
            echo "Initialization complete."
          fi
          
          echo "Environment Loaded. Commands: start_db, stop_db, mysql_client"
        '';
      };
    };
}
