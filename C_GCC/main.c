// SB4_PrintLUA Программа обработки уровней игры SOCOBAN 1984
// PellesC v80011 (32bit), 31-08-2023
#include <stdio.h>

volatile char c,level; // симвод чтения
volatile int numbyte,men; // 
int main (void){
  FILE  *in=fopen ("DATA2.TXT", "rb"); 
   printf("%s\n","mARR={");
 for(unsigned char level=1;level<51;level++){
	fseek(in, (level-1)*304,SEEK_SET); 
	numbyte=0;
	 for(int j=0;j<16/2;j++){	
		for(int i=0;i<19*2;i++){
			numbyte++;
			c=fgetc(in); 
			switch (c){
				case 0X00: printf("%s","0,"); break;
				case 0X01: printf("%s","1,"); break;
				case 0X03: printf("%s","2,"); break;
				case 0X14: printf("%s","3,"); break;
				case 0X17: printf("%s","4,"); break;
				case 0X55: printf("%s","5,"); break;
			}
	}
	printf("\n");
	}
  }
	fclose(in); // закрываем файлы
	printf("}\n");

}
