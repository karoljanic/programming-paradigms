#pragma once

#include <cstdint>
#include <iostream>
#include <ostream>

template <uint64_t P>
class GaloisField {
public:
    GaloisField() = default;

    GaloisField(const GaloisField<P>& other) = default;
    GaloisField(GaloisField<P>&& other) = default;

    GaloisField& operator=(const GaloisField<P>& other) = default;
    GaloisField& operator=(GaloisField<P>&& other) = default;

    GaloisField(int64_t val) : value{val} {
        while(value < 0) {
            value += P;
        }

        value %= P;
    }

    ~GaloisField() = default;

    static uint64_t getCharacteristic() noexcept {
        return P;
    }

    operator int64_t() const noexcept {
        return value;
    }

    friend GaloisField<P> operator+(const GaloisField<P>& lhs, const GaloisField<P>& rhs) noexcept {
        return GaloisField<P>{lhs.value + rhs.value};
    }

    friend GaloisField<P> operator+(const GaloisField<P>& lhs, int rhs) noexcept {
        return GaloisField<P>{lhs.value + rhs};
    }

    friend GaloisField<P> operator+(int lhs, const GaloisField<P>& rhs) noexcept {
        return GaloisField<P>{lhs + rhs.value};
    }

    friend GaloisField<P> operator-(const GaloisField<P>& lhs, const GaloisField<P>& rhs) noexcept {
        return GaloisField<P>{lhs.value - rhs.value};
    }

    friend GaloisField<P> operator-(const GaloisField<P>& lhs, int rhs) noexcept {
        return GaloisField<P>{lhs.value - rhs};
    }

    friend GaloisField<P> operator-(int lhs, const GaloisField<P>& rhs) noexcept {
        return GaloisField<P>{lhs - rhs.value};
    }

    friend GaloisField<P> operator*(const GaloisField<P>& lhs, const GaloisField<P>& rhs) noexcept {
        return GaloisField<P>{lhs.value * rhs.value};
    }

    friend GaloisField<P> operator*(const GaloisField<P>& lhs, int rhs) noexcept {
        return GaloisField<P>{lhs.value * rhs};
    }

    friend GaloisField<P> operator*(int lhs, const GaloisField<P>& rhs) noexcept {
        return GaloisField<P>{lhs * rhs.value};
    }

    GaloisField inverse() const {
        int64_t t = 0;
        int64_t newT = 1;
        int64_t r = P;
        int64_t newR = value;

        while (newR != 0) {
            int64_t quotient = r / newR;

            int64_t tmp = newT;
            newT = t - quotient * newT;
            t = tmp;

            tmp = newR;
            newR = r - quotient * newR;
            r = tmp;
        }

        if (r > 1) {
            throw std::runtime_error("Division not defined for uninvertible elements");
        }

        return GaloisField<P>{t};
    }

    friend GaloisField<P> operator/(const GaloisField<P>& lhs, const GaloisField<P>& rhs) {
        return lhs * rhs.inverse();
    }

    friend GaloisField<P> operator/(const GaloisField<P>& lhs, int rhs) {
        return lhs * GaloisField<P>{rhs}.inverse();
    }

    friend GaloisField<P> operator/(const int lhs, const GaloisField<P>& rhs) {
        return GaloisField<P>{lhs} * rhs.inverse();
    }

    GaloisField<P>& operator+=(const GaloisField<P>& other) noexcept {
        *this = *this + other;
        return *this;
    }

    GaloisField<P>& operator+=(int other) noexcept {
        *this = *this + other;
        return *this;
    }

    GaloisField<P>& operator-=(const GaloisField<P>& other) noexcept {
        *this = *this - other;
        return *this;
    }

    GaloisField<P>& operator-=(int other) noexcept {
        *this = *this - other;
        return *this;
    }

    GaloisField<P>& operator*=(const GaloisField<P>& other) noexcept {
        *this = *this * other;
        return *this;
    }

    GaloisField<P>& operator*=(int other) noexcept {
        *this = *this * other;
        return *this;
    }

    GaloisField<P>& operator/=(const GaloisField<P>& other) {
        *this = *this / other;
        return *this;
    }

    GaloisField<P>& operator/=(int other) {
        *this = *this / other;
        return *this;
    }

    bool operator==(const GaloisField<P>& other) const noexcept {
        return value == other.value;
    }

    bool operator==(const int other) const noexcept {
        return value == other;
    }

    bool operator!=(const GaloisField<P>& other) const noexcept {
        return value != other.value;
    }

    bool operator!=(const int other) const noexcept {
        return value != other;
    }

    bool operator<(const GaloisField<P>& other) const noexcept {
        return value < other.value;
    }

    bool operator<(const int other) const noexcept {
        return value < other;
    }

    bool operator>(const GaloisField<P>& other) const noexcept {
        return value > other.value;
    }

    bool operator>(const int other) const noexcept {
        return value > other;
    }

    bool operator<=(const GaloisField<P>& other) const noexcept {
        return value <= other.value;
    }

    bool operator<=(const int other) const noexcept {
        return value <= other;
    }

    bool operator>=(const GaloisField<P>& other) const noexcept {
        return value >= other.value;
    }

    bool operator>=(const int other) const noexcept {
        return value >= other;
    }

    friend std::ostream& operator<<(std::ostream& os, const GaloisField& gf) noexcept {
        os << gf.value;
        return os;
    }

    friend std::istream& operator>>(std::istream& is, GaloisField& gf) noexcept {
        int64_t value;
        is >> value;
        gf = GaloisField<P>{value};
        return is;
    }

 private:
  int64_t value = 0;
};