# Isolation Verifier

## About 
The main point of the project is to construct a non-intrusive reliable system
which will detect if **Armaflex** isolation is damaged or not using no-digital
sensors, because of radiation presence in the detector visinity.

## Introduction
The **CMS** **Preshower** detector is cooled down by **C6F14** liquid. 
The pipes that are used to transfer that liquid are partially isolated using **Armaflex** isolation
in order to cool down the ending device (detector) not the surrounding environment. Armaflex is subjected to ageing 
(esp. given the presence of radiation). When isolation is indeed damaged, then air gets 
between isolation material and pipe and because of the temperature difference in the vicinity of the pipe and the pipe 
itself, water condensates on the pipe's surface and gets inside Armaflex through small holes where isolation 
was damaged. That situation causes energy dissipation and the cooling system no longer cools down only 
the detector, but also condensed water and ice in the isolation and on the pipe. Due to a radiation presence, it is impossible to
install a proper dew point or water sensor, thus it was decided to utilise and invent no-digital sensors, which will
be fully radiation resistant.

The idea is to use a set of needles with high valued resistors as a 
voltage divider connected to ADC. Water inside an isolation, lower resistance
and higher value in ADC divider, what causes crossing thresholds and 
fires alarms in final Front-end SCADA system. Situation is detected and can be handled by for example replacement 
of an injured isolation. In the vicinity of pipes and isolation only needles with passive
elements and cables will be present. Intelligent systems like microcontroller will
be localised in the service cavern, where area is radiation free and connected through
long cables with voltage divider in the CMS detector.

<p align="center">
  <img src="https://raw.githubusercontent.com/wiki/jakubwieczorek/LEDClock/clocks.png" width="900" />
</p>

**To find out more, please check out a [LEDClock wiki][wiki].**

## Project structure
Isolation Verifier project consist of a few connected subprojects:

| **Hardware and Electronics**     | **Microcontroller**     | **Raspberry OPC Server**           | **WinccOA SCADA** |
|-------------------------------------|-------------------------------|-----------------------------------|-----------------------------------|
| Primitive sensor consicts of a set of needles and high valued resistors as a voltage divider, located directly in the area of cooling pipes. Check [hardware wiki][hardware_wiki].| STM32 project written in HAL library, where voltage divider is connected with ADC, converted and sent through UART to Raspberry PI. Check [microcontroller wiki][microcontroller_wiki].|  OPC UA server written in Python3, which consumes data from STM32 through UART, deployed in Docker Ubuntu image, which is running on Raspberry PI 4. Image is configured by docker-compose software. Check [PCBs wiki][pcbs_wiki]. | SCADA, front-end part of a system as OPC UA client written in WinccOA Siemense technology and CERN JCOP framework as a component. Compatibile with WinccOA 3.16. Check [mobile app wiki][mobile_wiki]. |

## Questions or need help?
Don't hesitate to send me an email on jakub.wieczorek0101@gmail.com or jakub.lukasz.wieczorek@cern.ch.

## Copyright and license
LED Clock project is copyright to CERN under the [MIT License](https://opensource.org/licenses/MIT).

[wiki]: https://github.com/jakubwieczorek/LEDClock/wiki
[yt]: https://www.youtube.com/watch?v=dwCs7caOApE&feature=youtu.be
[hardware_wiki]: https://github.com/jakubwieczorek/LEDClock/wiki/Hardware
[microcontroller_wiki]: https://github.com/jakubwieczorek/LEDClock/wiki/Microcontroller
[pcbs_wiki]: https://github.com/jakubwieczorek/LEDClock/wiki/PCBs
[mobile_wiki]: https://github.com/jakubwieczorek/LEDClock/wiki/Mobile-application
