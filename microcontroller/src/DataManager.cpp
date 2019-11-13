#include"DataManager.h"

void DataManager::add(uint16_t value)
{
	this->data[this->index++] = value;

	if(this->index == this->size)
	{
		this->index = 0;
	}
}

uint16_t DataManager::calculateAvarage()
{
	uint16_t avarage = 0;

	for(int i = 0; i < this->size; i++)
	{
		avarage += (this->data[i] / this->size);
	}

	return avarage;
}
