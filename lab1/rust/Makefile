all: iterative_algebra recursive_algebra

iterative_algebra: iterative_test.rs iterative_algebra.rs
	rustc iterative_test.rs

recursive_algebra: recursive_test.rs recursive_algebra.rs
	rustc recursive_test.rs

clean:
	rm iterative_test recursive_test
