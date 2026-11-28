#!/bin/sh
# Zig の公式 archive を取得し、SHA-256 を検証してから展開する。
# 期待値はこのスクリプトと同じディレクトリの zig-toolchain.env からのみ読む。
# 使い方: sh fetch-zig.sh <展開先ディレクトリ> [x86_64|aarch64]
# 標準出力には展開された zig ディレクトリのパスだけを 1 行出す。

set -eu

usage() {
    printf 'usage: %s <destination-dir> [x86_64|aarch64]\n' "$0" >&2
    exit 1
}

[ "$#" -ge 1 ] && [ "$#" -le 2 ] || usage

script_dir=$(CDPATH= cd -- "$(dirname "$0")" && pwd -P)
# shellcheck disable=SC1091
. "$script_dir/zig-toolchain.env"

dest=$1
mkdir -p "$dest"
dest=$(CDPATH= cd -- "$dest" && pwd -P)

if [ "$#" -eq 2 ]; then
    zig_arch=$2
else
    arch=$(uname -m)
    case "$arch" in
        x86_64) zig_arch=x86_64 ;;
        aarch64 | arm64) zig_arch=aarch64 ;;
        *)
            printf 'fetch-zig.sh: unsupported architecture: %s\n' "$arch" >&2
            exit 1
            ;;
    esac
fi

case "$zig_arch" in
    x86_64) sha_var=ZIG_SHA256_x86_64_linux ;;
    aarch64) sha_var=ZIG_SHA256_aarch64_linux ;;
    *)
        printf 'fetch-zig.sh: unsupported zig arch: %s\n' "$zig_arch" >&2
        exit 1
        ;;
esac

# shellcheck disable=SC2154
eval "expected_sha=\${$sha_var:?missing $sha_var in zig-toolchain.env}"

bundle="zig-${zig_arch}-linux-${ZIG_VERSION}"
url_var="ZIG_URL_${zig_arch}_linux"
eval "url=\${$url_var:-}"
if [ -z "$url" ]; then
    url="https://ziglang.org/download/${ZIG_VERSION}/${bundle}.tar.xz"
fi
archive="$dest/zig-${ZIG_VERSION}-${zig_arch}.tar.xz"
extracted="$dest/${bundle}"

fail() {
    printf 'fetch-zig.sh: %s\n' "$1" >&2
    rm -f "$archive"
    exit 1
}

if ! curl --fail --silent --show-error --location --output "$archive" "$url"; then
    fail "download failed: $url"
fi

if ! printf '%s  %s\n' "$expected_sha" "$archive" | sha256sum -c - >&2; then
    fail "SHA-256 mismatch for $url (expected $expected_sha); nothing was extracted"
fi

tar -xJf "$archive" -C "$dest" || fail "extraction failed for $archive"
rm -f "$archive"
printf '%s\n' "$extracted"