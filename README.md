# Isolation Verifier

## About 
The main point of the project is to construct a non-intrusive reliable system
which will detect if **Armaflex** isolation is damaged or not using no-digital
sensors, because of radiation presence in the detector vicinity.

## Introduction
The **CMS** **Preshower** detector is cooled down by **C6F14** liquid. 
The pipes that are used to transfer that liquid are partially isolated using **Armaflex** isolation
in order to cool down the ending device (detector) not the surrounding environment. Armaflex is subjected to ageing 
(esp. given the presence of radiation). When isolation is indeed damaged, then air gets 
between isolation material and pipe and because of the temperature difference in the vicinity of the pipe and the pipe 
itself, water condensates on the pipe's surface and gets inside Armaflex through small holes where isolation 
was damaged. That situation causes energy dissipation and the cooling system no longer cools down only 
the detector, but also condensed water and ice in the isolation and on the pipe. Due to a radiation presence, it is impossible to
install a proper dew point or water sensor, thus it was decided to utilize and invent no-digital sensors, which will
be fully radiation resistant.

The idea is to use a set of needles with high valued resistors as a 
voltage divider connected to ADC. Water inside an isolation, lower resistance
and higher value in ADC divider, what causes crossing thresholds and 
fires alarms in final Front-end SCADA system. Situation is detected and can be handled by for example replacement 
of an injured isolation. In the vicinity of pipes and isolation only needles with passive
elements and cables will be present. Intelligent systems like microcontroller will
be localised in the service cavern, where area is radiation free and connected through
long cables with voltage divider in the CMS detector.

**To find out more, please check out a [Isolation Verifier wiki][wiki].**

## Table of contents
Isolation Verifier project consist of a few connected sub-projects:

| **Hardware and Electronics**     | **Microcontroller**     | **Raspberry OPC UA Server**           | **WinccOA SCADA** |
|-------------------------------------|-------------------------------|-----------------------------------|-----------------------------------|
| Primitive sensor consists of a set of needles and high valued resistors as a voltage divider, located directly in the area of cooling pipes. For more information check [Hardware][hardware_wiki].| STM32 project written in HAL library, where voltage divider is connected with ADC, converted and sent through UART to Raspberry PI. For more information check [Microcontroller][microcontroller_wiki].|  OPC UA server written in Python3, which consumes data from STM32 through UART, deployed in Docker Ubuntu image, which is running on Raspberry PI 4. Image is configured by docker-compose software. For more information check [Raspberry OPC UA Server][opc_wiki]. | SCADA, front-end part of a system as OPC UA client written in WinccOA Siemens technology and CERN JCOP framework as a component. Compatibile with WinccOA 3.16. For more information check [SCADA][scada_wiki]. |

## Requirements
1.  A set of needles
2.  A few wires
3.  22MΩ resistor
4.  STM32F103RBT6 Nucelo Board
5.  Mini-USB 
6.  Raspberry PI 4, but should also work with 3+
7.  Wincc OA SCADA from Siemens

## Questions or need help?
Don't hesitate to send me an email on jakub.wieczorek0101@gmail.com or jakub.lukasz.wieczorek@cern.ch.

## Copyright and license
LED Clock project is copyright to CERN under the [MIT License](https://opensource.org/licenses/MIT).

[hardware_wiki]: Hardware
[microcontroller_wiki]: Microcontroller
[opc_wiki]: Raspberry-OPC-UA-Server
[scada_wiki]: SCADA