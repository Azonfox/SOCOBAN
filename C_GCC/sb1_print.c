// Программа обработки уровней игры SOCOBAN 1984
// PellesC v80011 (32bit), 31-08-2023
#include <stdio.h>

volatile char c,level; // симвод чтения
volatile int numbyte,men; // 

int main (void){
  // Открываем Бинарно!
  FILE  *in=fopen ("./DATA.txt", "rb"); 
  //FILE  *out=fopen("test.TXT",  "wb");

 for(unsigned char level=1;level<51;level++){
	printf("LEVEL-%d",level);
	fseek(in, (level-1)*306,SEEK_SET); 
 	men=fgetc(in)+(int)(fgetc(in)<<8); 
	printf(",men=x%04X\n",men);
	fseek(in, (level-1)*306+2,SEEK_SET); 
	numbyte=0;

	 for(int j=0;j<16;j++){	
		for(int i=0;i<19;i++){
			numbyte++;
			c=fgetc(in); 
			if(numbyte==men+1) printf("%c",'O');
			else 
			switch (c){
				case 0X00: printf("%c",'.'); break;
				case 0X01: printf("%c",'H'); break;
				case 0X03: printf("%c",'x'); break;
				case 0X14: printf("%c",'b'); break;
				case 0X17: printf("%c",'B'); break;
			}
	}
	printf("\n");
	}
	printf("\n");
  }
	fclose(in); // закрываем файлы
	//fclose(out);

	// unicode!!!!!!!!!
//	for(int i=32;i<255;i++){
//		printf("%d-%c",i,i);
//	}

}
///////////////////////////////////////////////////

/*  формирование списка имен файлов - уровней игры
	for(int i=1;i<51;i+=2){
		printf("T%02d",i);
		printf("%02d+",i+1);	
		if(i>50) break;
	}

}

*/
