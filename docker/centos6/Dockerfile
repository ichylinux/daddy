FROM centos:6.8
MAINTAINER ichylinux@gmail.com

RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8
ENV LANG=ja_JP.UTF-8

# update package
RUN yum -y groupinstall "Development Tools"
RUN yum -y groupinstall "Japanese Support"
RUN yum -y install epel-release
RUN yum -y install \
      ImageMagick-devel \
      curl-devel \
      expect \
      gcc \
      gcc-c++ \
      git \
      libffi-devel \
      libxml2-devel \
      libxslt-devel \
      libyaml-devel \
      mysql-devel \
      nodejs \
      openssl-devel \
      readline-devel \
      sqlite-devel \
      sudo \
      tar \
      wget \
      which \
      zlib-devel
RUN yum -y update && \
    yum clean all

# add /usr/local/bin to secure_path
COPY docker/centos6/etc/sudoers /etc/
RUN chmod 440 /etc/sudoers

# add user daddy
RUN useradd daddy
COPY docker/centos6/etc/sudoers.d/daddy /etc/sudoers.d/
USER daddy

# install ruby
RUN mkdir -p /home/daddy/src
WORKDIR /home/daddy/src
RUN wget https://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.4.tar.gz && \
    tar zxf ruby-2.2.4.tar.gz
WORKDIR /home/daddy/src/ruby-2.2.4
RUN ./configure --disable-install-rdoc && \
    make && \
    sudo make install
WORKDIR /home/daddy/src
RUN rm -Rf ruby-2.2.4*
RUN sudo gem update --system --no-document && \
    sudo gem install bundler --no-document && \
    sudo mkdir -p /usr/local/lib/ruby/gems/2.2.0/extensions/x86_64-linux && \
    sudo chmod 777 /usr/local/lib/ruby/gems/2.2.0/extensions/x86_64-linux

# install daddy
RUN mkdir -p /home/daddy/setup/daddy
WORKDIR /home/daddy/setup/daddy
COPY daddy.gemspec Gemfile Gemfile.lock ./
RUN mkdir -p lib/daddy
COPY lib/daddy/version.rb lib/daddy/
RUN bundle install
COPY . ./
RUN sudo rake install

# run new rails app
RUN mkdir -p /home/daddy/setup
WORKDIR /home/daddy/setup
ENV DAD_MYSQL_NO_ROOT_PASSWORD=true
RUN dad new hello_daddy
CMD /bin/bash

