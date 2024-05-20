package com.diffiehellman;

import java.util.ArrayList;
import java.util.Random;

import com.diffiehellman.GaloisField;

public class DHSetup<T extends GaloisField> {
    private static Random random = new Random();
    private T generator;

    public DHSetup() {
        this.generator = (T) new GaloisField(2);
        long characteristic = this.generator.getCharacteristic();
        final ArrayList<Long> primeDivisors = this.generatePrimeDivisors(characteristic - 1);
        Random random = new Random();
        do {
            this.generator = (T) new GaloisField(Math.abs(random.nextLong(characteristic - 2) + 1));
        } while(!this.isGenerator(this.generator, primeDivisors));
    }

    public T getGenerator() {
        return this.generator;
    }

    public T power(T base, long exponent) {
        if(exponent == 0) {
            return (T) new GaloisField(1);
        }

        T baseCopy = (T) new GaloisField(base);
        T result = (T) new GaloisField(1);

        while(exponent > 0) {
            if(exponent % 2 == 1) {
                result.multiply(baseCopy);
                exponent--;
            }

            baseCopy.multiply(baseCopy);
            exponent /= 2;
        }

        return result;
    }

    private ArrayList<Long> generatePrimeDivisors(long upperBound) {
        ArrayList<Long> divisors = new ArrayList<>();
        for(long i = 2; i * i <= upperBound; i++) {
            if(upperBound % i == 0) {
                divisors.add(i);
                while(upperBound % i == 0) {
                    upperBound /= i;
                }
            }
        }

        return divisors;
    }

    private boolean isGenerator(final T value, final ArrayList<Long> primeDivisors) {
        for(long divisor : primeDivisors) {
            T power = this.power(value, (value.getCharacteristic() - 1) / divisor);
            if(power.toLong() == 1) {
                return false;
            }
        }

        return true;
    }
}