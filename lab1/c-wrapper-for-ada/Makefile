all: build_ada build_c 

build_ada: ../ada/iterative_algebra.adb
	gnatmake -c ../ada/iterative_algebra.adb

build_c: main.c
	clang -Wall -Wextra -o main main.c iterative_algebra.o -lgnat

clean:
	rm iterative_algebra.ali iterative_algebra.o main
