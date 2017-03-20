require 'daddy/itamae'

# build environment
%w{ gcc gcc-c++ gcc-objc cmake git }.each do |name|
  package name do
    user 'root'
  end
end

# required packages
%w{
  libX11-devel mesa-libGL-devel libv4l-devel
  pulseaudio-libs-devel x264-devel freetype-devel
  fontconfig-devel libXcomposite-devel libXinerama-devel
  qt5-qtbase-devel qt5-qtx11extras-devel libcurl-devel
  systemd-devel ffmpeg-devel
}.each do |name|
  package name do
    user 'root'
  end
end

# clone source
directory '/opt/obs-studio' do
  user 'root'
  owner ENV['USER']
  group ENV['USER']
  mode '755'
end
directory '/opt/obs-studio/src'
git '/opt/obs-studio/src/obs-studio' do
  repository 'https://github.com/jp9000/obs-studio.git'
  revision '18.0.1'
end

# build
directory '/opt/obs-studio/src/obs-studio/build'
execute 'build' do
  cwd '/opt/obs-studio/src/obs-studio'
  command <<-EOF
    cmake -DUNIX_STRUCTURE=0 -DCMAKE_INSTALL_PREFIX="/opt/obs-studio"
    make -j4
    make install
  EOF
end
