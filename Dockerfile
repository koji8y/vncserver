FROM ubuntu:24.04 AS vncserver

ARG proxy
ENV HOME=/root
ENV http_proxy=$proxy
ENV https_proxy=$proxy
ENV HTTP_PROXY=$proxy
ENV HTTPS_PROXY=$proxy

RUN : set proxy \
  && set -ex \
  && rm -f /etc/localtime \
  && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  && (test -z "$proxy" || echo 'Acquire::http::Proxy "'"$proxy"'";' >> /etc/apt/apt.conf.d/proxy.conf) \
  && (test -z "$proxy" || echo 'Acquire::https::Proxy "'"$proxy"'";' >> /etc/apt/apt.conf.d/proxy.conf)
RUN : install requred packages \
  && set -ex \
  && apt update \
  && apt upgrade -y
RUN : install requred packages \
  && set -ex \
  && apt install -y less net-tools
RUN : install sshd \
  && set -ex \
  && apt install -y openssh-server \
  && mkdir -p /run/sshd
RUN : configure keyboard \
  && set -ex \
  && (echo 31; echo 1; echo 12) | DEBIAN_FRONTEND=noninteractive apt install -y keyboard-configuration
#RUN : install Xfce with gdb3 \
#  && set -ex \
#  && echo 2 | apt install -y gdm3 \
#  && echo 2 | DEBIAN_FRONTEND=nointeractive apt install -y lightdm
#  && apt install -y xfce4 xfce4-goodies
RUN : install Xfce \
  && echo 2 | DEBIAN_FRONTEND=nointeractive apt install -y lightdm \
  && apt install -y dbus-x11 xfce4 xfce4-goodies
RUN : install vncserver \
  && set -ex \
  && apt install -y tightvncserver \
  && mkdir /root/.vnc
RUN : install xterm \
  && set -ex \
  && apt install -y xterm
ARG vncpasswd
RUN set -ex \
  && echo ${vncpasswd:-hogehoge} | vncpasswd -f > /root/.vnc/passwd \
  && chmod go-r /root/.vnc/passwd
ADD xstartup /root/.vnc/
ADD startvncserver /root/
ENV USER=root
RUN set -ex \
  && rm -rf /tmp/.X*-lock

HEALTHCHECK --interval=5s --start-period=1s \
  CMD netstat -tln | grep -q '\<5901\>' && netstat -tln | grep -q '\<6001\>'
EXPOSE 5901/tcp 6001/tcp
ENTRYPOINT ["/root/startvncserver"]
