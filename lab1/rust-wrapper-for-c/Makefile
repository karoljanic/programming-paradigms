all: build_c build_rust 

build_c: ../c/iterative_algebra.c
	clang -c ../c/iterative_algebra.c -o iterative_algebra.o
	ar rcs libiterative_algebra.a iterative_algebra.o

build_rust: main.rs
	rustc -Lnative=. -lstatic=iterative_algebra main.rs

clean:
	rm iterative_algebra.o libiterative_algebra.a main
