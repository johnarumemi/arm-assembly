# FROM ubuntu:noble
FROM mcr.microsoft.com/devcontainers/base:noble

# Performance Tools
RUN apt-get update -y && apt-get install -y \
procps \
util-linux \
sysstat \
iproute2 \
numactl \
linux-tools-common \
linux-tools-$(uname -r) \
bpfcc-tools \
bpftrace \
perf-tools-unstable \
# trace-cmd \
nicstat \
ethtool \
tiptop
# msr-tools

RUN apt-get update -y && apt-get install -y \
build-essential \
gdb \
git \
vim 
