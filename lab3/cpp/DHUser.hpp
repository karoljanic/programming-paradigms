#pragma once

#include "GaloisField.hpp"
#include "DHSetup.hpp"

template <GaloisFieldConcept<uint32_t> T>
class DHUser {
public:
    DHUser() = delete;
    DHUser(const DHSetup<T>& setup) : setup{setup} {
        static std::mt19937_64 gen64{std::random_device{}()};
        static std::uniform_int_distribution<uint64_t> uniform{1};

        secret = uniform(gen64);
    }

    DHUser(const DHUser&) = default;
    DHUser(DHUser&&) = default;

    DHUser& operator=(const DHUser&) = default;
    DHUser& operator=(DHUser&&) = default;

    ~DHUser() = default;

    T getPublicKey() const noexcept {
        return DHSetup<T>::power(setup.getGenerator(), secret);
    }

    void setPublicKey(const T& key) noexcept {
        privateKey = DHSetup<T>::power(key, secret);
    }

    T encrypt(const T& message) const {
        if (privateKey.has_value() == false) {
            throw std::logic_error("Cannot encrypt a message without a private key");
        }

        return message * privateKey.value();
    }

     T decrypt(const T& code) const {
        if (privateKey.has_value() == false) {
            throw std::logic_error("Cannot decrypt a code without a private key");
        }

        return code / privateKey.value();
    }

private:
    const DHSetup<T>& setup;
    uint64_t secret;
    std::optional<T> privateKey;
};
