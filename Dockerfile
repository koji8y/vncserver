FROM ubuntu:20.04 as vncserver

ARG proxy
ENV HOME=/root
ENV http_proxy=$proxy
ENV https_proxy=$proxy
ENV HTTP_PROXY=$proxy
ENV HTTPS_PROXY=$proxy

RUN set -ex \
  && rm -f /etc/localtime \
  && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  && (test -z "$proxy" || echo 'Acquire::http::Proxy "'"$proxy"'";' >> /etc/apt/apt.conf.d/proxy.conf) \
  && (test -z "$proxy" || echo 'Acquire::https::Proxy "'"$proxy"'";' >> /etc/apt/apt.conf.d/proxy.conf)
RUN set -ex \
  && apt update \
  && apt install -y less net-tools
RUN set -ex \
  && apt install -y openssh-server \
  && mkdir -p /run/sshd
RUN set -ex \
  && apt upgrade -y
RUN set -ex \
  && (echo 31; echo 1; echo 12) | DEBIAN_FRONTEND=noninteractive apt install -y keyboard-configuration
RUN set -ex \
  && apt update \
  && echo 2 | apt install -y gdm3
RUN set -ex \
  && apt update \
  && echo 2 | DEBIAN_FRONTEND=nointeractive apt install -y lightdm
RUN set -ex \
  && apt update \
  && apt install -y xfce4 xfce4-goodies
RUN set -ex \
  && apt update \
  && apt install -y tightvncserver \
  && mkdir /root/.vnc
RUN set -ex \
  && apt install -y xterm
ARG vncpasswd
RUN set -ex \
  && echo ${vncpasswd:-hogehoge} | vncpasswd -f > /root/.vnc/passwd \
  && chmod go-r /root/.vnc/passwd
ADD xstartup /root/.vnc/
ADD startvncserver /root/
ENV USER=root

EXPOSE 5901/tcp 6001/tcp
ENTRYPOINT ["/root/startvncserver"]
