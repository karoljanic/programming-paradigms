all: dh_protocol_test.cpp
	clang++ -std=c++20 -o dh_protocol_test dh_protocol_test.cpp -lgtest

test: all
	./dh_protocol_test

clean:
	rm dh_protocol_test
