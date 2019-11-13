FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
	vim \
	telnet \
	wget \
	iputils-ping \
	python 3.8 \
	python3-venv

COPY ./fileswap /fileswap

COPY env /home/env
