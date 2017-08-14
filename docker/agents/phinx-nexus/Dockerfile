FROM jetbrains/teamcity-minimal-agent:latest

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# TZ Change
ENV TZ Europe/Helsinki
RUN echo $TZ > /etc/timezone && \
    apt-get update && apt-get install -y tzdata && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Install PHP stuff
RUN apt-get install -y \
  git \
  mysql-client \
  composer \
  php-mysql \
  php-curl \
  php-mbstring \
  php-xml \
  php-dom \
  php-simplexml \ 
  wget \ 
  mysql-utilities

# CleanUp
RUN apt-get clean && apt-get purge
