/*
 * DataManager.h
 *
 *  Created on: 8 Nov 2019
 *      Author: jawieczo
 */

#ifndef DATAMANAGER_H_
#define DATAMANAGER_H_

#include"stm32f1xx.h"

class DataManager
{
private:
		uint16_t data[20] {};
		uint8_t index {};
		uint8_t size = 20;
public:
		void add(uint16_t value);
		uint16_t calculateAvarage();
};

#endif /* DATAMANAGER_H_ */
