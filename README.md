[![](https://badge.imagelayers.io/inspectit/weblogic:latest.svg)](https://imagelayers.io/?images=inspectit/weblogic:latest 'Get your own badge on imagelayers.io')

# Weblogic with inspectIT
This docker image is based on the unofficial [WebLogic docker image](https://hub.docker.com/r/zhiqzhao/ubuntu_weblogic1036_domain/) including the inspectIT agent of the open source APM solution [www.inspectit.rocks](http://www.inspectit.rocks).
This image can be used easily as a replacement for the WebLogic image, meaning you only have to change your existing Dockerfile ```FROM zhiqzhao/ubuntu_weblogic1036_domain:latest``` to ```FROM inspectit/glassfish:latest```.

## Quickstart
First you need a running inspectIT CMR. You can use our docker image:

```bash
$ docker run -d --name inspectIT-CMR -p 8182:8182 -p 9070:9070 inspectit/cmr
```

Now you can start a container with the following command:

```bash
$ docker run -d --link inspectIT-CMR:cmr inspectit/weblogic
```

You can now adjust the instrumentation configuration with the inspectIT UI for your needs. Please refer to our [documentation](https://inspectit-performance.atlassian.net/wiki/display/DOC16/Agent+Configuration) or just leave a comment.

## Configuration
### Agent name
By default, the inspectIT agent uses the hostname as agent name. You can set a different name setting ```AGENT_NAME```:

```bash
$ docker run -d --link inspectIT-CMR:cmr -e AGENT_NAME=<agent-name> inspectit/weblogic
```

### Using a custom inspectIT CMR
If you don't want to use the inspectIT CMR docker image or cannot link to it, you can set the IP address and port manually:

```bash
$ docker run -d -e INSPECTIT_CMR_ADDR=<cmr-ip-address> -e INSPECTIT_CMR_PORT=<cmr-port> inspectit/weblogic
```

## Specifying the inspectIT version
Currently, this image is based on the latest preview inspectIT release. Other version can be specified as tags, for example ```inspectit/weblogic:1.7.1.84``` will use inspectIT version _1.7.1.84_.

## Build the docker image
If you want to build this image yourself, checkout this repository and run

```bash
$ docker build -t inspectit/weblogic .
```
