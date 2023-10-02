// SB3_PrintDATA2 Программа обработки уровней игры SOCOBAN 1984
// PellesC v80011 (32bit), 31-08-2023
#include <stdio.h>

volatile char c,level; // симвод чтения
volatile int numbyte,men; // 

int main (void){
  FILE  *in=fopen ("DATA2.TXT", "rb"); 
 for(unsigned char level=1;level<51;level++){
	printf("LEVEL-%d\n",level);
	fseek(in, (level-1)*304,SEEK_SET); 
 	//men=fgetc(in)+(int)(fgetc(in)<<8); 
	//printf(",men=x%04X\n",men);
	//fseek(in, (level-1)*306+2,SEEK_SET); 
	numbyte=0;
	 for(int j=0;j<16;j++){	
		for(int i=0;i<19;i++){
			numbyte++;
			c=fgetc(in); 
			switch (c){
				case 0X00: printf("%c",'.'); break;
				case 0X01: printf("%c",'H'); break;
				case 0X03: printf("%c",'x'); break;
				case 0X14: printf("%c",'b'); break;
				case 0X17: printf("%c",'B'); break;
				case 0X55: printf("%c",'5'); break;
			}
	}
	printf("\n");
	}
	printf("\n");
  }
	fclose(in); // закрываем файлы
}
