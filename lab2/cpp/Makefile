all: galois_field_test.cpp
	clang++ -std=c++14 -o galois_field_test galois_field_test.cpp -lgtest

test: all
	./galois_field_test

clean:
	rm galois_field_test
