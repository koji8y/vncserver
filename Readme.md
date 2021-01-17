vncserver
====

vncserver using tightvnc

## Run X client programs.
1. Set environment variable `DISPLAY` to `${your_host_name}:1`.
    - Port 6001/tcp is opened for X window system screen.
1. Start the X client program.

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
