package com.galoisfield;

import java.util.Objects;

class GaloisField implements Comparable<GaloisField> {
    public static final long P = 5;
    private long value;

    GaloisField() {
        this.value = 0;
    }

    GaloisField(long val) {
        this.value = val;
        while(this.value < 0) {
            this.value += GaloisField.P;
        }

        this.value %= GaloisField.P;
    }

    GaloisField(final GaloisField other) {
        this.value = other.value;
    }

    public long getCharacteristic() {
        return P;
    }

    public long toLong() {
        return this.value;
    }

    @Override
    public String toString() {
        return String.valueOf(this.value);
    }

    @Override
    public boolean equals(Object object) {
        if(this == object) {
            return true;
        }

        if(object == null || getClass() != object.getClass()) {
            return false;
        }

        GaloisField castedObject = (GaloisField)object;
        return this.value == castedObject.value;
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.value);
    }

    @Override
    public int compareTo(GaloisField galoisField) {
        return Long.compare(this.value, galoisField.value);
    }

    public int compareTo(final long val) {
        return compareTo(new GaloisField(val));
    }

    public void add(final GaloisField other) {
        this.value += other.value;
        this.value %= GaloisField.P;
    }

    public void add(final long other) {
        this.value += other;
        this.value %= GaloisField.P;
    }

    public void subtract(final GaloisField other) {
        this.value += (GaloisField.P - other.value);
        this.value %= GaloisField.P;
    }

    public void subtract(final long other) {
        this.value += (GaloisField.P - other);
        
        while(this.value < 0) {
            this.value += GaloisField.P;
        }
        
        this.value %= GaloisField.P;
    }

    public void multiply(final GaloisField other) {
        this.value *= other.value;
        this.value %= GaloisField.P;
    }

    public void multiply(final long other) {
        this.value *= other;
        
        while(this.value < 0) {
            this.value += GaloisField.P;
        }

        this.value %= GaloisField.P;
    }

    public void inverse() {
        long t = 0;
        long newT = 1;
        long r = GaloisField.P;
        long newR = value;

        while (newR != 0) {
            long quotient = r / newR;
            long temp = t;
            t = newT;
            newT = temp - quotient * newT;

            temp = r;
            r = newR;
            newR = temp - quotient * newR;
        }

        this.value = t + GaloisField.P;
        this.value %= GaloisField.P;
    }

    public void divide(final GaloisField other) throws ArithmeticException {
        if (other.value == 0) {
            throw new ArithmeticException(String.format("Division not defined for uninvertible elements"));
        }

        GaloisField otherCopy = other;
        otherCopy.inverse();

        this.value *= otherCopy.value;
        this.value %= GaloisField.P;
    }

    public void divide(final long other) throws ArithmeticException {
        if (other == 0) {
            throw new ArithmeticException(String.format("Division not defined for uninvertible elements"));
        }

        GaloisField otherCopy = new GaloisField(other);
        otherCopy.inverse();

        this.value *= otherCopy.value;
        this.value %= GaloisField.P;
    }

    public static GaloisField add(final GaloisField lhs, final GaloisField rhs) {
        return new GaloisField(lhs.value + rhs.value);
    }

    public static GaloisField add(final GaloisField lhs, final long rhs) {
        return new GaloisField(lhs.value + rhs);
    }

    public static GaloisField add(final long lhs, final GaloisField rhs) {
        return new GaloisField(lhs + rhs.value);
    }

    public static GaloisField subtract(final GaloisField lhs, final GaloisField rhs) {
        return new GaloisField(lhs.value - rhs.value);
    }

    public static GaloisField subtract(final GaloisField lhs, final long rhs) {
        return new GaloisField(lhs.value - rhs);
    }

    public static GaloisField subtract(final long lhs, final GaloisField rhs) {
        return new GaloisField(lhs - rhs.value);
    }

    public static GaloisField multiply(final GaloisField lhs, final GaloisField rhs) {
        return new GaloisField(lhs.value * rhs.value);
    }

    public static GaloisField multiply(final GaloisField lhs, final long rhs) {
        return new GaloisField(lhs.value * rhs);
    }

    public static GaloisField multiply(final long lhs, final GaloisField rhs) {
        return new GaloisField(lhs * rhs.value);
    }

    public static GaloisField inverse(final GaloisField galoisField) {
        long t = 0;
        long newT = 1;
        long r = GaloisField.P;
        long newR = galoisField.value;

        while (newR != 0) {
            long quotient = r / newR;
            long temp = t;
            t = newT;
            newT = temp - quotient * newT;

            temp = r;
            r = newR;
            newR = temp - quotient * newR;
        }

        return new GaloisField(t);
    }

    public static GaloisField inverse(final long value) {
        return GaloisField.inverse(new GaloisField(value));
    }

    public static GaloisField divide(final GaloisField lhs, final GaloisField rhs) throws ArithmeticException {
        if (rhs.value == 0) {
            throw new ArithmeticException(String.format("Division not defined for uninvertible elements"));
        }

        return new GaloisField(lhs.value * GaloisField.inverse(rhs).value);
    }

    public static GaloisField divide(final GaloisField lhs, final long rhs) throws ArithmeticException {
        if (rhs == 0) {
            throw new ArithmeticException(String.format("Division not defined for uninvertible elements"));
        }

        return new GaloisField(lhs.value * GaloisField.inverse(rhs).value);
    }

    public static GaloisField divide(final long lhs, final GaloisField rhs) throws ArithmeticException {
        if (rhs.value == 0) {
            throw new ArithmeticException(String.format("Division not defined for uninvertible elements"));
        }

        return new GaloisField(lhs * GaloisField.inverse(rhs).value);
    }
}