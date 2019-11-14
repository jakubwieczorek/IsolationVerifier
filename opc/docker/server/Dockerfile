FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
	vim \
	telnet \
	wget \
	iputils-ping \
	python3 \
	python3-pip \
	usbutils \
	libxml2-dev \
	libxslt1-dev

COPY ./fileswap /fileswap

RUN pip3 install opcua \
	pyserial \
	cryptography
