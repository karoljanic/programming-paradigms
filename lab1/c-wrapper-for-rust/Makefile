all: build_rust build_c

build_rust: ../rust/iterative_algebra.rs
	rustc --crate-type=staticlib -o libalgebra.a ../rust/iterative_algebra.rs

build_c: main.c
	clang -Wall -Wextra -o main main.c libalgebra.a

clean:
	rm libalgebra.a main
