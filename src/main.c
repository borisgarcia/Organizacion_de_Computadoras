#include "screen.h"
#include "keypad.h"
#include "game.h"
int main() {
	uint8_t posR = 6, posC = 5;
	uint8_t row = 15, col = 40;

	intro();
	while(true)
	{
		movement(row,col,posR,posC);
	}
}
