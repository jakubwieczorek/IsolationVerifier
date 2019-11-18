/**
  ******************************************************************************
  * @file    main.c
  * @author  Ac6
  * @version V1.0
  * @date    01-December-2013
  * @brief   Default main function.
  ******************************************************************************
*/


#include "stm32f1xx.h"
#include <string>
#include <cstring>
#include "DataManager.h"

UART_HandleTypeDef uart;
ADC_HandleTypeDef adc;
DMA_HandleTypeDef dma;
DMA_HandleTypeDef dma_uart;

uint16_t adc_value[2];

void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
{
	if(GPIO_Pin == GPIO_PIN_13)
	{
		HAL_GPIO_TogglePin(GPIOA, GPIO_PIN_5);
	}
}

void send_message(const char *a_message)
{
	HAL_UART_Transmit_DMA(&uart, (uint8_t*)a_message, strlen(a_message));
}

/**
 * %NAME% &VALUE& $CONVERT$ #UNIT# \r\n
 * */

const char* prepareMsg(const uint16_t &adc_value, const uint16_t &average)
{
	char adc_value_msg[100];
	char average_msg[100];

	std::string sMsg;

	sprintf(adc_value_msg, "ADC_CH1 %4d %1.3f Volts \r\n", adc_value, adc_value * 3.3f / 4096.0f);
	sprintf(average_msg,   "ADC_CH1_MEAN_20 %4d %1.3f Volts \r\n", average, average * 3.3f / 4096.0f);

	sMsg = std::string() + adc_value_msg + average_msg;

	return sMsg.c_str();
}

void gpio_config()
{
	GPIO_InitTypeDef gpio;

	gpio.Pin = GPIO_PIN_13;
	gpio.Mode = GPIO_MODE_IT_RISING_FALLING;
	gpio.Pull = GPIO_PULLUP;
	gpio.Speed = GPIO_SPEED_FREQ_LOW;
	HAL_GPIO_Init(GPIOC, &gpio);

	gpio.Pin = GPIO_PIN_5;
	gpio.Mode = GPIO_MODE_OUTPUT_PP;
	gpio.Pull = GPIO_NOPULL;
	HAL_GPIO_Init(GPIOA, &gpio);

	gpio.Pin = GPIO_PIN_2;
	gpio.Mode = GPIO_MODE_AF_PP;
	HAL_GPIO_Init(GPIOA, &gpio);

	gpio.Pin = GPIO_PIN_3;
	gpio.Mode = GPIO_MODE_AF_INPUT;
	HAL_GPIO_Init(GPIOA, &gpio);

	gpio.Pin = GPIO_PIN_0;
	gpio.Mode = GPIO_MODE_ANALOG;
	HAL_GPIO_Init(GPIOA, &gpio);
}

void uart_config()
{
	uart.Instance = USART2;
	uart.Init.BaudRate = 115200;
	uart.Init.HwFlowCtl = UART_HWCONTROL_NONE;
	uart.Init.Mode = UART_MODE_TX_RX;
	uart.Init.OverSampling = UART_OVERSAMPLING_16;
	uart.Init.Parity = UART_PARITY_NONE;
	uart.Init.StopBits = UART_STOPBITS_1;
	uart.Init.WordLength = UART_WORDLENGTH_8B;
	HAL_UART_Init(&uart);
}

void adc_config()
{
    RCC_PeriphCLKInitTypeDef adc_clk;
    adc_clk.PeriphClockSelection = RCC_PERIPHCLK_ADC;
    adc_clk.AdcClockSelection = RCC_ADCPCLK2_DIV2;
    HAL_RCCEx_PeriphCLKConfig(&adc_clk);

    adc.Instance = ADC1;
	adc.Init.ContinuousConvMode = ENABLE;
	adc.Init.ExternalTrigConv = ADC_SOFTWARE_START;
	adc.Init.DataAlign = ADC_DATAALIGN_RIGHT;
	adc.Init.ScanConvMode = ADC_SCAN_ENABLE;
	adc.Init.NbrOfConversion = 2;
	adc.Init.DiscontinuousConvMode = DISABLE;
	adc.Init.NbrOfDiscConversion = 1;
	HAL_ADC_Init(&adc);

	ADC_ChannelConfTypeDef adc_ch;
	adc_ch.Channel = ADC_CHANNEL_0;
	adc_ch.Rank = ADC_REGULAR_RANK_1;
	adc_ch.SamplingTime = ADC_SAMPLETIME_239CYCLES_5;
	HAL_ADC_ConfigChannel(&adc, &adc_ch);

	adc_ch.Channel = ADC_CHANNEL_VREFINT;
	adc_ch.Rank = ADC_REGULAR_RANK_2;
	HAL_ADC_ConfigChannel(&adc, &adc_ch);
	HAL_ADCEx_Calibration_Start(&adc);
}

void dma_config()
{
	dma.Instance = DMA1_Channel1;
	dma.Init.Direction = DMA_PERIPH_TO_MEMORY;
	dma.Init.PeriphInc = DMA_PINC_DISABLE;
	dma.Init.MemInc = DMA_MINC_ENABLE;
	dma.Init.PeriphDataAlignment = DMA_PDATAALIGN_HALFWORD;
	dma.Init.MemDataAlignment = DMA_MDATAALIGN_HALFWORD;
	dma.Init.Mode = DMA_CIRCULAR;
	dma.Init.Priority = DMA_PRIORITY_HIGH;
	HAL_DMA_Init(&dma);
	__HAL_LINKDMA(&adc, DMA_Handle, dma);

	dma_uart.Instance = DMA1_Channel7;
	dma_uart.Init.Direction = DMA_MEMORY_TO_PERIPH;
	dma_uart.Init.MemDataAlignment = DMA_MDATAALIGN_BYTE;
	dma_uart.Init.MemInc = DMA_MINC_ENABLE;
	dma_uart.Init.Mode = DMA_NORMAL;
	dma_uart.Init.PeriphDataAlignment = DMA_PDATAALIGN_BYTE;
	dma_uart.Init.PeriphInc = DMA_PINC_DISABLE;
	dma_uart.Init.Priority = DMA_PRIORITY_HIGH;
	HAL_DMA_Init(&dma_uart);
	__HAL_LINKDMA(&uart, hdmatx, dma_uart);
}

void nvic_config()
{
	HAL_NVIC_SetPriority(EXTI15_10_IRQn, 0, 0);
	HAL_NVIC_EnableIRQ(EXTI15_10_IRQn);

	HAL_NVIC_SetPriority(DMA1_Channel7_IRQn, 0, 0);
	HAL_NVIC_EnableIRQ(DMA1_Channel7_IRQn);

	HAL_NVIC_SetPriority(USART2_IRQn, 0, 0);
	HAL_NVIC_EnableIRQ(USART2_IRQn);
}

int main(void)
{
	SystemCoreClock = 8000000;
	HAL_Init();

	__HAL_RCC_GPIOA_CLK_ENABLE();
	__HAL_RCC_GPIOC_CLK_ENABLE();
	__HAL_RCC_USART2_CLK_ENABLE();
	__HAL_RCC_ADC1_CLK_ENABLE();
	__HAL_RCC_DMA1_CLK_ENABLE();

	gpio_config();
	uart_config();
	adc_config();
	dma_config();
	nvic_config();

	char msg[300];
	sprintf(msg, "After reset\r\n");
	send_message(msg);

    HAL_ADC_Start_DMA(&adc, (uint32_t*)adc_value, 2);

    DataManager dataManager;

	while(1)
	{
		dataManager.add(adc_value[0]);
		uint16_t average = dataManager.calculateAverage();

		send_message(prepareMsg(adc_value[0], average));

		if(average > 3000)
		{
			sprintf(msg, "Leakage possible!\r\n");
			send_message(msg);
		}

		HAL_Delay(1000);
	}
}
