{
  lib,
  linuxPackages,
}:

let
  patchModule =
    kernelPackages:
    kernelPackages.amneziawg.overrideAttrs (oldAttrs: {
      patches =
        (oldAttrs.patches or [ ])
        ++ [ ./ipv6-api-linux-7.1.patch ]
        ++ [ ./netlink-memcpy-linux.patch ]
        # Linux 7.1.5 uses UDP tunnel helpers that take struct sock.
        ++ lib.optionals (lib.versionAtLeast kernelPackages.kernel.version "7.1.5") [
          ./udp-tunnel-api-linux-7.1.5.patch
        ];
    });
in
(patchModule linuxPackages).overrideAttrs (oldAttrs: {
  passthru = (oldAttrs.passthru or { }) // {
    # Consumers with a non-default kernel must build the module against the
    # matching kernel package set.
    withKernel = patchModule;
  };
})
