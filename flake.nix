{
	description="Homemanager config of dan-alin";
	
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, home-manager, ...}:
		let
			system = "x86_64-darwin";
			pkgs = nixpkgs.legacyPackages.${system};
		in {
			
			homeConfigurations.dan-alin = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
	
				modules = [./home.nix];
			};
		};
}
