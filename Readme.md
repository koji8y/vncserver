vncserver
====

vncserver using tightvnc

## Run X client programs.
1. Set environment variable `DISPLAY` to `${your_host_name}:1`.
    - Port 6001/tcp is opened for X window system screen.
    - 6001 (and :1) is default. It can be changed with the environment variable `XSERVER` (See below for the details).
1. Start the X client programs.

## View the X window system screen.
1. Connect to `${your_host_name}:1` with vnc client / vnc viewer.
    - Port 5901/tcp is opened for vnc.

## Configuration to build your own image.
### Environment variables
- `vncpasswd`
    - Password to connect to the vncserver.  The length of the password should be 8.
    - Default password is `hogehoge`.
- `proxy`
    - HTTP proxy settings if required.
    - It should be either of the following forms:
        - `http://username:password@proxy_host:port`
        - `http://proxy_host:port`
- `restart`
    - If `always` is set, the docker container for vncserver will be restarted after reboot.
- `XSERVER`
    - The TCP port number for X Server.
    - Default is 6001, which corresponds to "DISPLAY=:1".
- `VNCSERVER`
    - The TCP port number for VNC server.
    - Default is 5901.
