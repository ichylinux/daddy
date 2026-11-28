version = ENV['ZIG_VERSION'] || '0.17.1'
opt_root = File.join(ENV['HOME'], '.local', 'opt')
local_bin = File.join(ENV['HOME'], '.local', 'bin')
zig_wrapper = File.join(local_bin, 'zig')
recipe_dir = File.dirname(__FILE__)
fetch_script = File.join(recipe_dir, 'fetch-zig.sh')

execute 'install zig' do
  user ENV['USER']
  command <<-EOF
    set -eu
    mkdir -p #{opt_root} #{local_bin}
    zig_dir=$(sh "#{fetch_script}" "#{opt_root}")
    test -x "$zig_dir/zig"
    ln -sf "$zig_dir/zig" "#{zig_wrapper}"
    profile_line='export PATH="${HOME}/.local/bin:${PATH}"'
    for f in "${HOME}/.profile" "${HOME}/.bashrc"; do
      test -f "$f" || touch "$f"
      grep -Fq '.local/bin' "$f" || echo "$profile_line" >> "$f"
    done
  EOF
  not_if "test -x #{zig_wrapper} && #{zig_wrapper} version 2>/dev/null | grep -q '^#{version}$'"
end