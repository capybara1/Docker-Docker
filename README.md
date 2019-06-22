# Docker

[![](https://images.microbadger.com/badges/version/capybara1/docker.svg)](https://microbadger.com/images/capybara1/docker "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/license/capybara1/docker.svg)](https://microbadger.com/images/capybara1/docker "Get your own license badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/capybara1/docker.svg)](https://microbadger.com/images/capybara1/docker "Get your own image badge on microbadger.com")

## Motivation

Primarily an image that provides a docker binary to control docker from withon a container

## Usage

### Command Line

```sh
docker run 
  --rm \
  -it \
  -v /var/run/docker.sock:/var/run/docker.sock \
  capybara1/docker:1.0 \
  $COMMAND_THAT_USES_DOCKER
```
