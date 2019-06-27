# Docker

[![](https://images.microbadger.com/badges/version/capybara1/docker.svg)](https://microbadger.com/images/capybara1/docker "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/license/capybara1/docker.svg)](https://microbadger.com/images/capybara1/docker "Get your own license badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/capybara1/docker.svg)](https://microbadger.com/images/capybara1/docker "Get your own image badge on microbadger.com")

## Motivation

Primarily an image that provides a docker binary to control docker from within a container.
For common tasks scripts are provided that may be used during execution.

|Script                       |Purpose                                  |
|-----------------------------|-----------------------------------------|
|/usr/local/bin/backup-volume |Backup one or more volumes               |
|/usr/local/bin/restore-volume|Restore one or more volumes from a backup|

## Inspirations

The volume backup/restore scripts are inspired by the following articles

- [Auto-Backup für Docker Volumes](http://scorban.de/2018/02/06/auto-backup-fuer-docker-volumes/)
- [Backup & Restore Docker Named Volumes](https://loomchild.net/2017/03/26/backup-restore-docker-named-volumes/)

## Usage

### Command Line

```sh
docker run 
  --rm \
  --init \
  -it \
  -v /var/run/docker.sock:/var/run/docker.sock \
  capybara1/docker:1.0 \
  /usr/local/bin/backup-volume --container=my_container my_vol1 my_vol2
```
