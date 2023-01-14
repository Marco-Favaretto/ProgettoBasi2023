CC = g++
FLAG = -L dependencies\lib -lpq

basi : codice.cpp
	${CC} $^ ${FLAG} -o $@

clean : 
	del basi.exe

help :
	@echo basi:  compila file .cpp
	@echo clean: elimina file .exe