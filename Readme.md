vncserver
====

vncserver using tightvnc

## Configuration to build your own image
### Environment variables
- `vncpasswd`
    - Password to connect to the vncserver.  The length of the password should be 8.
    - Default password is `hogehoge`.
- `proxy`
    - HTTP proxy settings if required.
    - It should be either of the following forms:
        - `http://username:password@proxy_host:port`
        - `http://proxy_host:port`
