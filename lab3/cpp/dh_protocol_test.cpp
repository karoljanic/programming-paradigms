#include <iostream>
#include <gtest/gtest.h>

#include "GaloisField.hpp"
#include "DHSetup.hpp"
#include "DHUser.hpp"

constexpr uint64_t PRIME = 1234567891;

using GF = GaloisField<PRIME>;

TEST(DHProtocol, ProtocolTest) {
    DHSetup<GF> setup;
    DHUser<GF> alice{setup};
    DHUser<GF> bob{setup};

    alice.setPublicKey(bob.getPublicKey());
    bob.setPublicKey(alice.getPublicKey());

    GF message1{123456789};
    GF message2{987654321};

    ASSERT_EQ(message1, alice.decrypt(bob.encrypt(message1)));
    ASSERT_EQ(message1, bob.decrypt(alice.encrypt(message1)));

    ASSERT_EQ(message2, alice.decrypt(bob.encrypt(message2)));
    ASSERT_EQ(message2, bob.decrypt(alice.encrypt(message2)));
}

TEST(DHProtocol, EncryptErrorKeyNotSet) {
    DHSetup<GF> setup;
    DHUser<GF> alice{setup};
    DHUser<GF> bob{setup};

    GF message{123456789};

    ASSERT_THROW(alice.encrypt(message), std::logic_error);
    ASSERT_THROW(bob.encrypt(message), std::logic_error);
}

TEST(DHProtocol, DecryptErrorKeyNotSet) {
    DHSetup<GF> setup;
    DHUser<GF> alice{setup};
    DHUser<GF> bob{setup};

    GF message{123456789};

    ASSERT_THROW(alice.decrypt(message), std::logic_error);
    ASSERT_THROW(bob.decrypt(message), std::logic_error);
}

int main() {
    ::testing::InitGoogleTest();
    return RUN_ALL_TESTS();
}