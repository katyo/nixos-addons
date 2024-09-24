{ pkgs, options, config, lib, ... }:
with lib;
let cfg = config.hardware.gadget;

    addIndexes = input: (fold (attrs: { output, counters }:
      let index = if hasAttr attrs.type counters then counters.${attrs.type} + 1 else 0;
      in {
        output = output ++ [ (attrs // { inherit index; }) ];
        counters = counters // { ${attrs.type} = index; };
      }) { output = []; counters = {}; } input).output;

    funcs = addIndexes (mapAttrsToList (name: attrs: attrs // { inherit name; }) cfg.functions);

    /*funcTypes = unique (map (name: attrs: attrs.type) funcs);
    funcInsts = func: let insts = filter ({ enable, type, ... }: enable && type == func) funcs;
                          indexes = genList (n: n) (length insts);
                      in zipListsWith (attrs: index: attrs // { inherit index; }) insts indexes;

    concatMapFuncsSep = sep: fn: concatMapStringsSep ''${sep}
      '' (name: concatMapStringsSep ''${sep}
      '' fn (funcInsts name)) funcTypes;*/

    concatMapFuncsSep = sep: fn: concatMapStringsSep ''${sep}
    '' fn funcs;

    mergeOptions = attrs: fold mergeAttrs {} (map (attrs: attrs.options) (attrValues attrs));

    hidClass = {
      keyboard = {
        description = "USB HID Keyboard";
        options = {};
        function = attrs: ''
          attrs :
          {
            subclass = 0x01;
            protocol = 0x01; # keyboard
            report_length = 8;
            report_desc = (
              # Binary HID keyboard descriptor
              0x05, 0x01, # USAGE_PAGE (Generic Desktop)
              0x09, 0x06, # USAGE (Keyboard)
              0xa1, 0x01, # COLLECTION (Application)
              0x05, 0x07, #   USAGE_PAGE (Keyboard)
              0x19, 0xe0, #   USAGE_MINIMUM (Keyboard LeftControl)
              0x29, 0xe7, #   USAGE_MAXIMUM (Keyboard Right GUI)
              0x15, 0x00, #   LOGICAL_MINIMUM (0)
              0x25, 0x01, #   LOGICAL_MAXIMUM (1)
              0x75, 0x01, #   REPORT_SIZE (1)
              0x95, 0x08, #   REPORT_COUNT (8)
              0x81, 0x02, #   INPUT (Data,Var,Abs)
              0x95, 0x01, #   REPORT_COUNT (1)
              0x75, 0x08, #   REPORT_SIZE (8)
              0x81, 0x03, #   INPUT (Data,Var,Abs)
              0x95, 0x05, #   REPORT_COUNT (5)
              0x75, 0x01, #   REPORT_SIZE (1)
              0x05, 0x08, #   USAGE_PAGE (LEDs)
              0x19, 0x01, #   USAGE_MINIMUM (Num Lock)
              0x29, 0x05, #   USAGE_MAXIMUM (Kana)
              0x91, 0x02, #   OUTPUT (Data,Var,Abs)
              0x95, 0x01, #   REPORT_COUNT (1)
              0x75, 0x03, #   REPORT_SIZE (3)
              0x91, 0x03, #   OUTPUT (Cnst,Var,Abs)
              0x95, 0x06, #   REPORT_COUNT (6)
              0x75, 0x08, #   REPORT_SIZE (8)
              0x15, 0x00, #   LOGICAL_MINIMUM (0)
              0x25, 0x65, #   LOGICAL_MAXIMUM (101)
              0x05, 0x07, #   USAGE_PAGE (Keyboard)
              0x19, 0x00, #   USAGE_MINIMUM (Reserved (no event indicated))
              0x29, 0x65, #   USAGE_MAXIMUM (Keyboard Application)
              0x81, 0x00, #   INPUT (Data,Ary,Abs)
              0xc0        # END_COLLECTION
            );
          };
        '';
      };

      pointer = {
        description = "USB HID Pointer";
        options = {};
        function = attrs: ''
          attrs :
          {
            subclass = 0x01;
            protocol = 0x02; # mouse
            report_length = 6;
            report_desc = (
              # Binary HID mouse descriptor (absolute coordinate)
              0x05, 0x01,       # USAGE_PAGE (Generic Desktop)
              0x09, 0x02,       # USAGE (Mouse)
              0xa1, 0x01,       # COLLECTION (Application)
              0x09, 0x01,       #   USAGE (Pointer)
              0xa1, 0x00,       #   COLLECTION (Physical)
              0x05, 0x09,       #     USAGE_PAGE (Button)
              0x19, 0x01,       #     USAGE_MINIMUM (Button 1)
              0x29, 0x03,       #     USAGE_MAXIMUM (Button 3)
              0x15, 0x00,       #     LOGICAL_MINIMUM (0)
              0x25, 0x01,       #     LOGICAL_MAXIMUM (1)
              0x95, 0x03,       #     REPORT_COUNT (3)
              0x75, 0x01,       #     REPORT_SIZE (1)
              0x81, 0x02,       #     INPUT (Data,Var,Abs)
              0x95, 0x01,       #     REPORT_COUNT (1)
              0x75, 0x05,       #     REPORT_SIZE (5)
              0x81, 0x03,       #     INPUT (Cnst,Var,Abs)
              0x05, 0x01,       #     USAGE_PAGE (Generic Desktop)
              0x09, 0x30,       #     USAGE (X)
              0x09, 0x31,       #     USAGE (Y)
              0x35, 0x00,       #     PHYSICAL_MINIMUM (0)
              0x46, 0xff, 0x7f, #     PHYSICAL_MAXIMUM (32767)
              0x15, 0x00,       #     LOGICAL_MINIMUM (0)
              0x26, 0xff, 0x7f, #     LOGICAL_MAXIMUM (32767)
              0x65, 0x11,       #     UNIT (SI Lin:Distance)
              0x55, 0x00,       #     UNIT_EXPONENT (0)
              0x75, 0x10,       #     REPORT_SIZE (16)
              0x95, 0x02,       #     REPORT_COUNT (2)
              0x81, 0x02,       #     INPUT (Data,Var,Abs)
              0x09, 0x38,       #     Usage (Wheel)
              0x15, 0xff,       #     LOGICAL_MINIMUM (-1)
              0x25, 0x01,       #     LOGICAL_MAXIMUM (1)
              0x35, 0x00,       #     PHYSICAL_MINIMUM (-127)
              0x45, 0x00,       #     PHYSICAL_MAXIMUM (127)
              0x75, 0x08,       #     REPORT_SIZE (8)
              0x95, 0x01,       #     REPORT_COUNT (1)
              0x81, 0x06,       #     INPUT (Data,Var,Rel)
              0xc0,             #   END_COLLECTION
              0xc0              # END_COLLECTION
            );
          };
        '';
      };
    };

    ethClass = {
      options = {
        ifName = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = "Interface name";
        };
        hostAddr = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = "Host-side MAC address";
        };
        devAddr = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = "Device-side MAC address";
        };
      };
      function = attrs: ''
        attrs :
        {
          ${optionalString (null != attrs.ifName) ''
            ifname = "${attrs.ifName}";
          ''}
          ${optionalString (null != attrs.hostAddr) ''
            host_addr = "${attrs.hostAddr}";
          ''}
          ${optionalString (null != attrs.devAddr) ''
            dev_addr = "${attrs.devAddr}";
          ''}
        };
      '';
    };

    class = {
      acm = {
        description = "USB CDC-ACM class";
        options = {};
        function = attrs: "";
      };
      ecm = {
        description = "USB CDC-ECM class";
      } // ethClass;
      rndis = {
        description = "Remote Network Driver Interface Specification (RNDIS)";
        options = ethClass.options;
        function = attrs: ''
          os_descs = (
            {
              interface = "rndis";
              compatible_id = "RNDIS";
              sub_compatible_id = "5162001";
            }
          );
        '' + (ethClass.function attrs);
      };
      mass_storage = {
        description = "USB Mass Storage class";
        options = {
          luns = mkOption {
            type = types.ints.positive;
            description = "Number of logical units";
            default = 1;
          };
        };
        function = attrs: ''
          attrs :
          {
            stall = false;
            luns = (
              ${concatStringsSep '',
              '' (genList (index: ''
                { # storage ${toString index}
                  #ro = true;
                  removable = true;
                  #cdrom = true;
                }
              '') attrs.luns)}
            );
          };
        '';
      };
      hid = {
        description = "USB HID class";
        options = {
          kind = mkOption {
            type = types.enum (attrNames hidClass);
            description = "HID device kind";
            default = elemAt (attrNames hidClass) 0;
          };
        } // (mergeOptions hidClass);
        function = attrs: hidClass.${attrs.kind}.function attrs;
      };
    };
in {
  options.hardware.gadget = {
    enable = mkEnableOption "BMC gadget";

    name = mkOption {
      type = types.str;
      description = "Gadget name";
      default = "bmc";
    };

    manufacturer = mkOption {
      type = types.str;
      description = "Manufacturer string";
      default = "OpenBMC";
    };

    product = mkOption {
      type = types.str;
      description = "Product string";
      default = "virtual_input";
    };

    serialnumber = mkOption {
      type = types.str;
      description = "Serial number string";
      default = "OBMC0001";
    };

    functions = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          enable = mkEnableOption "function";

          type = mkOption {
            type = types.enum (attrNames class);
            description = "Function type";
          };
        } // (mergeOptions class);
      });
      description = "Devices with configurations";
      default = {};
    };
  };

  config = mkIf cfg.enable {
    hardware.gt = {
      enable = mkDefault true;

      gadgets."${cfg.name}" = {
        scheme = ''
          attrs :
          {
            bcdUSB = 0x0200;
            bDeviceClass = 0xef; # 0x00
            bDeviceSubClass = 0x02; # 0x00
            bDeviceProtocol = 0x01; # 0x00
            bMaxPacketSize0 = 0x08; # 0x00
            idVendor = 0x1d6b; # Linux Foundation
            idProduct = 0x0104; # Multifunction composite gadget
            bcdDevice = 0x0419; # 0x0100
          };
          os_descs :
          {
            use = 1;
            qw_sign = "MSFT100";
            b_vendor_code = 0xcd;
          };
          strings = (
            {
              lang = 0x409;
              manufacturer = "${cfg.manufacturer}";
              product = "${cfg.product}";
              serialnumber = "${cfg.serialnumber}";
            }
          );
          functions :
          {
            ${concatMapFuncsSep "" (attrs: ''
              ${attrs.name} :
              {
                instance = "${toString attrs.index}";
                type = "${attrs.type}";
                ${class.${attrs.type}.function attrs}
              }
            '')}
          };
          configs = (
            {
              id = 1;
              name = "c";
              attrs :
              {
                bmAttributes = 0xe0;
                bMaxPower = 500; # 1A (in 2mA units)
              };
              strings = (
                {
                  lang = 0x409;
                  configuration = "Main config";
                }
              );
              functions = (
                ${concatMapFuncsSep "," (attrs: ''
                  {
                    name = "${attrs.type}.${toString attrs.index}";
                    function = "${attrs.name}";
                  }
                '')}
              );
            }
          );
        '';
      };
    };
  };
}
