CC = gcc

myprog20.exe:	main.o
	$(CC) -o myprog20.exe main.o

main.o:	main.c
	$(CC) -O0 -g3 -Wall -c main.c
	$(CC) -masm=intel -g3 -Wall -c main.c -S

clean:
	del -rf *.s *.o *.exe
