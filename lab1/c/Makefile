all: iterative_algebra recursive_algebra

iterative_algebra: test.c iterative_algebra.c
	clang -Wall -Wextra -o iterative_test test.c iterative_algebra.c -DDEFINE_ITERATIVE_VERSION

recursive_algebra: test.c recursive_algebra.c
	clang -Wall -Wextra -o recursive_test test.c recursive_algebra.c -DDEFINE_RECURSIVE_VERSION

clean:
	rm iterative_test recursive_test
