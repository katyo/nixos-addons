import { DOMParser, Element } from 'https://deno.land/x/deno_dom/deno-dom-wasm.ts';
import { stringify } from "jsr:@std/toml";
import { satisfies } from "https://deno.land/x/semver/mod.ts";

if (Deno.args.length < 1) {
  console.log("Missing package name");
  Deno.exit(0);
}

const pkgName = Deno.args[0];
const pkgVer = Deno.args[1];

const res = await fetch(`https://pypi.org/simple/${pkgName}`)
const html = await res.text();
const doc = new DOMParser().parseFromString(html, 'text/html');
const dec = new TextDecoder();

interface PkgInfo {
  link: string
  hash: string
}

type PkgsInfo = { [ver: string]: { [cpy: string]: { [abi: string]: { [sys: string]: PkgInfo } } } }

const pkgs: PkgsInfo = {};

for (const a of doc.querySelectorAll('a').values()) {
  const pkg = a.textContent.replace(/\.whl$/, "").split("-");
  const loc = a.attributes.getNamedItem("href").value.split("#sha256=");

  if (pkg.length < 5) continue;

  const [pname, ver, api, abi, plat] = pkg;
  const [url, sha] = loc;

  if (pkgVer !== undefined && pkgVer != "") {
    let sat = false;
    try {
      sat = satisfies(ver, pkgVer);
    } catch (e) {
    }
    if (!sat) continue;
  }

  const apis = pkgs[ver] = pkgs[ver] || {};
  const abis = apis[api] = apis[api] || {};
  const plats = abis[abi] = abis[abi] || {};

  const out = await new Deno.Command("nix-hash", { args: ["--type", "sha256", "--to-sri", sha] }).output();
  const hash = dec.decode(out.stdout).replace(/\n$/, "");

  plats[plat] = { url, hash };
}

await Deno.writeTextFile(`${pkgName}-whl.toml`, stringify(pkgs));
