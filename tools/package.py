#!/usr/bin/env python3
"""Build one release zip per mod into dist/.

    python3 tools/package.py            # every mod
    python3 tools/package.py save-anywhere

Each zip holds a single top-level folder named after the mod, so extracting it
into <game dir>/mods/hmbtn/ gives <game dir>/mods/hmbtn/<mod>/mod.toml, which is
the only layout the engine reads. Entry names always use forward slashes (the
PowerShell 5.1 Compress-Archive writes backslashes, which break on Linux and
macOS) and carry a fixed timestamp, so the same sources give the same zip.
"""
import os
import re
import sys
import zipfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MODS = os.path.join(ROOT, 'mods')
DIST = os.path.join(ROOT, 'dist')
FIXED = (2026, 1, 1, 0, 0, 0)


def version_of(mod_toml):
    with open(mod_toml, encoding='utf-8') as f:
        m = re.search(r'^version\s*=\s*"([^"]+)"', f.read(), re.MULTILINE)
    return m.group(1) if m else None


def package(name):
    src = os.path.join(MODS, name)
    toml = os.path.join(src, 'mod.toml')
    if not os.path.isfile(toml):
        sys.exit('error: %s has no mod.toml' % name)
    ver = version_of(toml)
    if not ver:
        sys.exit('error: %s/mod.toml has no version = "..." line' % name)
    os.makedirs(DIST, exist_ok=True)
    out = os.path.join(DIST, '%s-%s.zip' % (name, ver))
    with zipfile.ZipFile(out, 'w', zipfile.ZIP_DEFLATED) as z:
        for base, _dirs, files in sorted(os.walk(src)):
            for fn in sorted(files):
                full = os.path.join(base, fn)
                arc = name + '/' + os.path.relpath(full, src).replace(os.sep, '/')
                info = zipfile.ZipInfo(arc, FIXED)
                info.compress_type = zipfile.ZIP_DEFLATED
                info.external_attr = 0o644 << 16
                with open(full, 'rb') as f:
                    z.writestr(info, f.read())
    print('built', os.path.relpath(out, ROOT))
    return out


def main(argv):
    names = argv or sorted(n for n in os.listdir(MODS)
                           if os.path.isdir(os.path.join(MODS, n)))
    for n in names:
        package(n)
    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))