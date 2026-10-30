-- builtins.getFlake rejects paths containing symlinks (/etc -> /private/etc).
local flake_path = vim.uv.fs_realpath("/etc/nix-darwin") or "/etc/nix-darwin"
local flake = ('(builtins.getFlake "%s")'):format(flake_path)
local darwin = flake .. '.darwinConfigurations."Junkis-MacBook-Pro"'

return {
	settings = {
		nixd = {
			nixpkgs = {
				expr = ("import %s.inputs.nixpkgs { }"):format(flake),
			},
			options = {
				["nix-darwin"] = {
					expr = darwin .. ".options",
				},
				["home-manager"] = {
					expr = darwin .. ".options.home-manager.users.type.getSubOptions [ ]",
				},
			},
		},
	},
}
