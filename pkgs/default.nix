/**
  Inspired from Matthew Bauer's excellent blog posts on how to 
  use channels.

  https://matthewbauer.us/blog/channel-changing.html

  In the future this might be changed to use nix-flakes instead.
*/
let
  channels = import ./channels.nix;
in
with channels;
rec {
  # TODO:
  # gatk4 = markhor.callPackage ./gatk4/default.nix { };
  # fermi-lite = markhor.callPackage ./fermi-lite/default.nix {};
  svdb = markhor.callPackage ./svdb/default.nix { };
  kent = markhor.callPackage ./kent/default.nix { };
  tiddit = markhor.callPackage ./tiddit/default.nix { };
}
