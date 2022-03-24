{
  description = ''Bindings for libusb, the cross-platform user library to access USB devices.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-libusb-master.flake = false;
  inputs.src-libusb-master.ref   = "refs/heads/master";
  inputs.src-libusb-master.owner = "nimious";
  inputs.src-libusb-master.repo  = "io-usb";
  inputs.src-libusb-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-libusb-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-libusb-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}