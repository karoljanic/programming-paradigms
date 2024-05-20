all: build_c build_ada

build_c: ../c/iterative_algebra.c
	clang -c ../c/iterative_algebra.c -o iterative_algebra.o

build_ada: main.adb
	gnatmake main.adb -largs iterative_algebra.o

clean:
	rm iterative_algebra.o main.ali main.o main
