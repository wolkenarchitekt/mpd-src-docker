MPD from source Docker container
================================

This repository shows how to build and run [Music Player Daemon](https://www.musicpd.org/) from source within a Docker container.
This allows to run the latest MPD version as Ubuntu/Debian packages are outdated and 
unmaintained - MPD author says these are "outdated and unsupported by this project". 

Usage:
------

```
# Get sources 
make get-src

# Build and run
make build run
```
