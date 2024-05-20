all: iterative_algebra recursive_algebra

iterative_algebra: iterative_test.adb iterative_algebra.adb
	gnatmake iterative_test

recursive_algebra: recursive_test.adb recursive_algebra.adb
	gnatmake recursive_test

clean:
	rm recursive_algebra.ali recursive_algebra.o recursive_test.ali recursive_test.o recursive_test
	rm iterative_algebra.ali iterative_algebra.o iterative_test.ali iterative_test.o iterative_test
