################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/stm32f1xx_it.c \
../src/syscalls.c \
../src/system_stm32f1xx.c 

CPP_SRCS += \
../src/DataManager.cpp \
../src/callbacks.cpp \
../src/config.cpp \
../src/main.cpp \
../src/service.cpp 

OBJS += \
./src/DataManager.o \
./src/callbacks.o \
./src/config.o \
./src/main.o \
./src/service.o \
./src/stm32f1xx_it.o \
./src/syscalls.o \
./src/system_stm32f1xx.o 

C_DEPS += \
./src/stm32f1xx_it.d \
./src/syscalls.d \
./src/system_stm32f1xx.d 

CPP_DEPS += \
./src/DataManager.d \
./src/callbacks.d \
./src/config.d \
./src/main.d \
./src/service.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: MCU G++ Compiler'
	@echo $(PWD)
	arm-none-eabi-g++ -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -DSTM32 -DSTM32F1 -DSTM32F103RBTx -DNUCLEO_F103RB -DDEBUG -DSTM32F103xB -DUSE_HAL_DRIVER -I"C:/Documents/IsolationVerifier/microcontroller/HAL_Driver/Inc/Legacy" -I"C:/Documents/IsolationVerifier/microcontroller/Utilities/STM32F1xx_Nucleo" -I"C:/Documents/IsolationVerifier/microcontroller/inc" -I"C:/Documents/IsolationVerifier/microcontroller/CMSIS/device" -I"C:/Documents/IsolationVerifier/microcontroller/CMSIS/core" -I"C:/Documents/IsolationVerifier/microcontroller/HAL_Driver/Inc" -O0 -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fno-exceptions -fno-rtti -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo $(PWD)
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -DSTM32 -DSTM32F1 -DSTM32F103RBTx -DNUCLEO_F103RB -DDEBUG -DSTM32F103xB -DUSE_HAL_DRIVER -I"C:/Documents/IsolationVerifier/microcontroller/HAL_Driver/Inc/Legacy" -I"C:/Documents/IsolationVerifier/microcontroller/Utilities/STM32F1xx_Nucleo" -I"C:/Documents/IsolationVerifier/microcontroller/inc" -I"C:/Documents/IsolationVerifier/microcontroller/CMSIS/device" -I"C:/Documents/IsolationVerifier/microcontroller/CMSIS/core" -I"C:/Documents/IsolationVerifier/microcontroller/HAL_Driver/Inc" -O0 -g3 -Wall -fmessage-length=0 -ffunction-sections -c -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


