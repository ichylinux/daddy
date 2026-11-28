toolchain = ENV['RUST_TOOLCHAIN'] || 'stable'
cargo_home = ENV.fetch('CARGO_HOME', File.join(ENV['HOME'], '.cargo'))
rustup_bin = File.join(cargo_home, 'bin', 'rustup')

execute 'install rustup' do
  user ENV['USER']
  command <<-EOF
    set -eu
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain #{toolchain} --profile default
  EOF
  not_if "test -x #{rustup_bin}"
end

execute "rustup default #{toolchain}" do
  user ENV['USER']
  command "#{rustup_bin} default #{toolchain}"
  not_if "#{rustup_bin} show active-toolchain | grep -qE '^(stable|#{Regexp.escape(toolchain)})'"
end

execute 'rustup component add clippy' do
  user ENV['USER']
  command "#{rustup_bin} component add clippy"
  not_if "#{rustup_bin} component list --installed | grep -q '^clippy-'"
end