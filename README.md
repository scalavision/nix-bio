# nix-bio

TODO: change the `default.nix` file, it might be wrong.

Simple repository to facilitate building bioinformatic tools with nix and
adding them to a local flat nix-store cache.

If successful they will be added to nixpkgs and subsequently deleted from
this repository.

## Generate nix store keys

```
nix-store --generate-binary-cache-key <url> <private-key-name>.pem <public-key-name>.pem
```

## Generate binary cache

The `./make-binary-cache` script should be enough to generate the binary cache from
the tools specified in `default.nix`. The tools will be built and exported to the
path of the cache given as a command line argument.

Simple usage:

```bash
sudo NIX_SECRET_KEY_FILE=<path to private key>.pem ./make_binary_cache <path cache>
```

It will create the binary cache at the location specified.

The cache will also be compressed and copied back to currenct
working directory, thus it could be copied into a singularity / docker
container etc.

## Setting up a copy of the cache

To be able to use a proprietary nix cache as a normal user, you
need to add the user to `nix.trustedUsers` option.

You also need to add the cache to the `~/.config/nix/nix.conf` file:

```s
substituters = https://cache.nixos.org <URL of cache>
trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= <cache-pub-key.pem contents>
```

You can now add it as a nix-channel.

```bash
nix-channel --add file:///<path/to/store> <name of channel>
nix-channel --update
```

You should then be able to install a tool (tiddit being the name of the tool here) like this:

```bash
nix-env -iA <name of channel>.tiddit
```

however that does not work currently ...
