import { DOMParser, Element } from 'https://deno.land/x/deno_dom/deno-dom-wasm.ts';
import { stringify } from "jsr:@std/toml";

if (Deno.args.length < 1) {
  console.log("Missing output file name");
  Deno.exit(0);
}

if (Deno.args.length < 2) {
  console.log("Missing number of versions");
  Deno.exit(0);
}

if (Deno.args.length < 3) {
  console.log("Missing package name prefix");
  Deno.exit(0);
}

if (Deno.args.length < 4) {
  console.log("Missing languages");
  Deno.exit(0);
}

const outFile = Deno.args[0];
const numVers = Deno.args[1];
const pkgPfx = Deno.args[2];
const pkgLangs = Deno.args.slice(3);

function compareVersions(a: string, b: string): number {
    function padParts(version: string) {
        return version
            .split('.')
            .map(function (part) {
                return '00000000'.substr(0, 8 - part.length) + part;
            })
            .join('.');
    }

    a = padParts(a);
    b = padParts(b);

    return a.localeCompare(b);
}

interface PkgInfo {
  link: string
  hash: string
}

type PkgsInfo = { [lang: string]: { [ver: string]: PkgInfo } }

const pkgs: PkgsInfo = {};

for (const lang of pkgLangs) {
  const res = await fetch(`https://pypi.org/simple/${pkgPfx}${lang}`)
  const html = await res.text();
  const doc = new DOMParser().parseFromString(html, 'text/html');
  const dec = new TextDecoder();

  const vers: { ver: string, inf: PkgsInfo }[] = [];

  for (const a of doc.querySelectorAll('a').values()) {
    const pkg = a.textContent.replace(/\.whl$/, "").split("-");
    const loc = a.attributes.getNamedItem("href").value.split("#sha256=");

    if (pkg.length < 5) continue;

    const [pname, ver] = pkg;
    const [url, sha] = loc;

    if (!/^\d+/.test(ver)) continue;

    const out = await new Deno.Command("nix-hash", { args: ["--type", "sha256", "--to-sri", sha] }).output();
    const hash = dec.decode(out.stdout).replace(/\n$/, "");

    vers.push({ ver, inf: { url, hash } });
  }

  pkgs[lang] = vers.sort((a, b) => compareVersions(b.ver, a.ver)).slice(0, numVers).reduce(function(o, a) {
    o[a.ver] = a.inf;
    return o;
  }, {});
}

await Deno.writeTextFile(outFile, stringify(pkgs));
