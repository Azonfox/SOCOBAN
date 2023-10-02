// SB2_DATA2 Программа обработки уровней игры SOCOBAN 1984
// GCC 30-00-2023
#include <stdio.h>
volatile char c,level; // симвод чтения
volatile int numbyte,men; // 
int main (void){
  FILE  *in=fopen ("DATA.txt", "rb"); 
  FILE  *out=fopen("DATA2.TXT","wb");
for(unsigned char level=1;level<51;level++){
	printf("L-%d",level);
	fseek(in, (level-1)*306,SEEK_SET); 
 	men=fgetc(in)+(int)(fgetc(in)<<8); 
	printf(",men=x%04X  ",men);
	fseek(in, (level-1)*306+2,SEEK_SET); 
	numbyte=0;
       for(int j=0;j<19*16;j++){	
	 numbyte++;
	 c=fgetc(in); 
	 if(numbyte==men+1) c=0x55;
	 fputc(c,out);
         }
      }
	fclose(in); // закрываем файлы
	fclose(out);
printf("19x16-%d",19*16*50);
}
