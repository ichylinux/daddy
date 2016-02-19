FROM centos:7
MAINTAINER ichylinux@gmail.com

# package
RUN yum groups
RUN yum -y groupinstall "Development Tools"
RUN yum -y install epel-release
RUN yum -y install \
      ImageMagick-devel \
      curl-devel \
      ibus-kkc \
      vlgothic-* \
      expect \
      libffi-devel \
      libxml2-devel \
      libxslt-devel \
      libyaml-devel \
      mariadb \
      mariadb-devel \
      mariadb-server \
      nodejs \
      openssl-devel \
      readline-devel \
      sqlite-devel \
      sudo \
      tar \
      wget \
      which \
      zlib-devel
RUN  yum -y update

# locale
RUN yum reinstall -y glibc-common
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
RUN ln -nfs /usr/share/zoneinfo/Japan /etc/localtime

# add /usr/local/bin to secure_path
COPY docker/centos7/etc/sudoers /etc/sudoers
RUN chmod 440 /etc/sudoers

# add user daddy
RUN useradd daddy
COPY docker/centos7/etc/sudoers.d/daddy /etc/sudoers.d/daddy
USER daddy

# install ruby
RUN mkdir -p /home/daddy/src
WORKDIR /home/daddy/src
RUN wget https://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.4.tar.gz
RUN tar zxf ruby-2.2.4.tar.gz
WORKDIR /home/daddy/src/ruby-2.2.4
RUN ./configure --disable-install-rdoc
RUN make
RUN sudo make install
RUN sudo gem update --system --no-document
RUN sudo gem update rake -f --no-document
RUN sudo gem update rdoc -f --no-document
RUN sudo gem install bundler --no-document

# install daddy
RUN mkdir -p /home/daddy/setup/daddy
COPY . /home/daddy/setup/daddy/
WORKDIR /home/daddy/setup/daddy
RUN sudo chown -R daddy:daddy .
RUN bundle install
RUN sudo rake install

# setup for running container
ENV container=docker
VOLUME /sys/fs/cgroup

# run new rails app
RUN mkdir -p /home/daddy/setup
WORKDIR /home/daddy/setup
CMD ["/bin/bash"]