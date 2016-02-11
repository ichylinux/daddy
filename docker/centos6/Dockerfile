FROM centos:6.7
MAINTAINER ichylinux@gmail.com

# update package
RUN ["yum", "-y", "groupinstall", "Development Tools"]
RUN ["yum", "-y", "groupinstall", "Japanese Support"]
RUN ["yum", "-y", "install", "epel-release"]
RUN ["yum", "-y", "install", "nodejs", "sudo", "tar", "wget"]
RUN ["yum", "-y", "install", "zlib-devel", "openssl-devel", "curl-devel", "readline-devel", "sqlite-devel", "mysql-devel", "libffi-devel", "libxslt-devel", "libxml2-devel", "libyaml-devel", "ImageMagick-devel"]
RUN ["yum", "-y", "update"]

# add /usr/local/bin to secure_path
COPY ["docker/centos6/sudoers", "/etc/sudoers"]
RUN ["chmod", "440", "/etc/sudoers"]

# add user daddy
RUN ["useradd", "daddy"]
COPY ["docker/centos6/daddy.sudoers", "/etc/sudoers.d/daddy"]
USER daddy

# install ruby
RUN ["mkdir", "-p", "/home/daddy/src"]
WORKDIR /home/daddy/src
RUN ["wget", "https://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.4.tar.gz"]
RUN ["tar", "zxf", "ruby-2.2.4.tar.gz"]
WORKDIR /home/daddy/src/ruby-2.2.4
RUN ["./configure", "--disable-install-rdoc"]
RUN ["make"]
RUN ["sudo", "make", "install"]
RUN ["sudo", "gem", "update", "--system"]
RUN ["sudo", "gem", "install", "bundler", "--no-document"]

# install daddy
RUN ["mkdir", "-p", "/home/daddy/setup/daddy"]
COPY [".", "/home/daddy/setup/daddy/"]
WORKDIR /home/daddy/setup/daddy
RUN ["bundle", "install"]
RUN ["sudo", "rake", "install"]

# new rails app for test
RUN ["mkdir", "-p", "/home/daddy/setup"]
WORKDIR /home/daddy/setup
RUN ["dad", "new", "hello_daddy"]
