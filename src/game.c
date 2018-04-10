#include "game.h"

void intro()
{
  set_color(BRIGHT_WHITE, CYAN);
  clear_screen();
  keypad_init();
  bool a = true;
  while(a)
  {
    uint8_t key = keypad_getkey();
    set_cursor(14,29);
  	puts("WELCOME TO SNAKE GAME!");
  	set_cursor(16,28);
  	puts("PRESS SPACE TO CONTINUE!");
    if(key == 8)
    {
      set_color(BRIGHT_WHITE, BLACK);
      clear_screen();
      board();
      a = false;
    }
  }
}

void board(){
  set_color(BRIGHT_WHITE, BLACK);
	for (int x = 1; x < 79; x++)
	{
		set_cursor(3,x);
		put_char(239);
		set_cursor(29,x);
		put_char(244);
	}

	for (int y = 0; y < 30; y++)
	{
		set_cursor(y,0);
		put_char(238);
		set_cursor(y,79);
		put_char(245);
	}
    set_cursor(1,18);
    put_char(251);
    set_cursor(1,20);
    put_char(250);
    set_cursor(1,22);
    put_char(255);
    set_cursor(1,24);
    put_char(249);
    set_cursor(1,26);
    put_char(252);
    set_cursor(1,30);
    put_char(254);
    set_cursor(1,32);
    put_char(255);
    set_cursor(1,34);
    put_char(253);
    set_cursor(1,36);
    put_char(252);

    set_cursor(1,50);
    put_char(251);
    set_cursor(1,52);
    put_char(247);
    set_cursor(1,54);
    put_char(243);
    set_cursor(1,56);
    put_char(246);
    set_cursor(1,58);
    put_char(252);
    set_cursor(1,60);
    put_char(237);

}

void movement(uint8_t row, uint8_t col, uint8_t row_f, uint8_t col_f)
{
  int a = -1; //direccion
  uint8_t d = 85;//delay col
  uint8_t d2 = 100;//delay row
  uint8_t cont = 0;
  uint8_t score = _CONST48;
  set_color(BRIGHT_WHITE, BLACK);
  keypad_init();
  uint8_t key = keypad_getkey();
  while(true)
  {
    key = keypad_getkey();
    if(key !=0)
      a = key;

    if(a == 1)
    {
      if(col >= 2 && col <= 78)
      {
        delay_ms(d);
        col = col - 1;
      }
    }

    if(a == 2)
    {
      if(col >= 1 && col <= 77)
      {
        delay_ms(d);
        col = col + 1;
      }
    }

    if(a == 3)
    {
      if(row >= 3 && row < 28)
      {
        delay_ms(d2);
        row = row + 1;
      }
    }

    if(a == 4)
    {
      if(row >= 4 && row < 29)
      {
        delay_ms(d2);
        row = row - 1;
      }
    }
    if(row == 28 || row == 3 || col == 1 ||col == 78)
    {
      row = 15;
      col = 40;
      cont = 0;
      d = 85;//delay col
      d2 = 100;//delay row
      GameOver();
      score = _CONST48;

    }
    if(row_f == row && col_f == col)
    {
      row_f = randRows(row_f);
      while(row_f < 5)
      {
        row_f = randRows(row_f);
      }
      col_f = randCols(col_f);

      cont += _CONST1;
      d -= _CONST1;
      d2 -= _CONST1;
      if(cont == _CONST10)
      {
        cont = _CONST1;
        score += _CONST1;
      }
      set_color(BRIGHT_WHITE, BLACK);
      set_cursor(1,62);
      put_char(score);
      set_color(BLACK, BLACK);
    }
    set_color(BLACK, BLACK);

    for(int a = 4;a<29;a++)
    {
      for(int b = 2;b<78;b++)
      {
        set_cursor(a,b);
        put_char(' ');
      }
    }

    set_color(BRIGHT_WHITE, BLACK);
    drawSnake(row,col);
    drawFood(row_f,col_f);
    board();

  }
}

void drawSnake(uint8_t r,uint8_t c)
{
    set_cursor(r, c);
    put_char(229);
}

void drawFood(uint8_t r_f,uint8_t c_f)
{
  set_cursor(r_f, c_f);
  put_char(248);
}

uint8_t randCols(uint8_t col_f)
{
  uint8_t _new = (col_f * 8 + 2);
  col_f = _mod(_new,78);
  return col_f;
}

uint8_t randRows(uint8_t row_f)
{
    uint8_t _new = (row_f * 8 + 2);
    row_f = _mod(_new,28);
    return row_f;
}

uint8_t _mod(uint8_t x,int y)
{
  while(x > y)
      x = x-y;
  return x;
}

void GameOver()
{
  set_color(BRIGHT_WHITE, LIGHT_BLUE);
  drawSnake(15,5);
  clear_screen();
  keypad_init();

  bool a = true;
  while(a)
  {
    uint8_t key = keypad_getkey();
    set_cursor(14,35);
  	puts("Game Over!");
  	set_cursor(16,26);
  	puts("PRESS SPACE TO Start Again!");
    if(key == 8)
    {
      intro();
      a = false;
    }
  }
}
