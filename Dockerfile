FROM ubuntu:16.04

RUN apt-get update && apt-get install -y curl wget android-tools-adb supervisor

CMD ["bash", "-c", "adb start-server && adb status-window"]

