FROM centos:7
MAINTAINER ichylinux@gmail.com

# update package
RUN ["yum", "-y", "groupinstall", "Development Tools"]
RUN ["yum", "-y", "install", "ibus-kkc", "vlgothic-*"]
RUN ["yum", "-y", "install", "epel-release"]
RUN ["yum", "-y", "install", "expect", "nodejs", "sudo", "tar", "wget", "which"]
RUN ["yum", "-y", "install", "zlib-devel", "openssl-devel", "curl-devel", "readline-devel", "sqlite-devel", "mysql-devel", "libffi-devel", "libxslt-devel", "libxml2-devel", "libyaml-devel", "ImageMagick-devel"]
RUN ["yum", "-y", "update"]

ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
  rm -f /lib/systemd/system/multi-user.target.wants/*;\
  rm -f /etc/systemd/system/*.wants/*;\
  rm -f /lib/systemd/system/local-fs.target.wants/*; \
  rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
  rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
  rm -f /lib/systemd/system/basic.target.wants/*;\
  rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME ["/sys/fs/cgroup"]

# set locale
RUN yum reinstall -y glibc-common
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
RUN ln -nfs /usr/share/zoneinfo/Japan /etc/localtime

# add /usr/local/bin to secure_path
COPY ["docker/centos7/sudoers", "/etc/sudoers"]
RUN ["chmod", "440", "/etc/sudoers"]

# add user daddy
RUN ["useradd", "daddy"]
COPY ["docker/centos7/daddy.sudoers", "/etc/sudoers.d/daddy"]
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

# run new rails app
ENV DAD_MYSQL_NO_ROOT_PASSWORD=true
RUN ["mkdir", "-p", "/home/daddy/setup"]
WORKDIR /home/daddy/setup
RUN ["dad", "new", "hello_daddy"]
