#ifndef GAME_H_
#define GAME_H_

#include "screen.h"
#include "keypad.h"
#define _CONST1		1
#define _CONST10 	5
#define _CONST48 	48
void movement(uint8_t row, uint8_t col, uint8_t col_f,uint8_t row_f);
void intro();
void GameOver();
void drawSnake(uint8_t r,uint8_t c);
void drawFood(uint8_t r_f, uint8_t c_f);
uint8_t randRows(uint8_t x);
uint8_t randCols(uint8_t y);
void clearBoard();
uint8_t _mod(uint8_t x, int y);
void board();
#endif
