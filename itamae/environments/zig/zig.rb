version = ENV['ZIG_VERSION'] || '0.17.1'
opt_root = File.join(ENV['HOME'], '.local', 'opt')
local_bin = File.join(ENV['HOME'], '.local', 'bin')
zig_wrapper = File.join(local_bin, 'zig')

execute 'install zig' do
  user ENV['USER']
  command <<-EOF
    set -eu
    arch=$(uname -m)
    case "$arch" in
      x86_64) zig_arch=x86_64 ;;
      aarch64|arm64) zig_arch=aarch64 ;;
      *)
        echo "unsupported architecture for zig: $arch" >&2
        exit 1
        ;;
    esac
    bundle="zig-${zig_arch}-linux-#{version}"
    url="https://ziglang.org/download/#{version}/${bundle}.tar.xz"
    install_dir="#{opt_root}/${bundle}"
    mkdir -p /var/daddy/tmp #{opt_root} #{local_bin}
    cd /var/daddy/tmp
    rm -f "${bundle}.tar.xz"
    curl -fL "$url" -o "${bundle}.tar.xz"
    rm -rf "$install_dir"
    tar -xJf "${bundle}.tar.xz" -C "#{opt_root}"
    ln -sf "$install_dir/zig" "#{zig_wrapper}"
    profile_line='export PATH="${HOME}/.local/bin:${PATH}"'
    for f in "${HOME}/.profile" "${HOME}/.bashrc"; do
      test -f "$f" || touch "$f"
      grep -Fq '.local/bin' "$f" || echo "$profile_line" >> "$f"
    done
  EOF
  not_if "test -x #{zig_wrapper} && #{zig_wrapper} version 2>/dev/null | grep -q '^#{version}$'"
end