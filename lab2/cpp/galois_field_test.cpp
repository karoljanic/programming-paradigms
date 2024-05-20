#include <iostream>
#include <gtest/gtest.h>

#include "GaloisField.hpp"

constexpr uint64_t PRIME = 5;

TEST(GaloisField, CreatingCorrectObjects) {
    ASSERT_EQ(GaloisField<PRIME>{}.getCharacteristic(), PRIME);
    
    GaloisField<PRIME> gf1;
    ASSERT_EQ(gf1, 0);

    GaloisField<PRIME> gf2{3};
    ASSERT_EQ(gf2, 3);

    GaloisField<PRIME> gf3{7};
    ASSERT_EQ(gf3, 2);

    GaloisField<PRIME> gf4{-16};
    ASSERT_EQ(gf4, 4);
}

TEST(GaloisField, Addition) {
    GaloisField<PRIME> gf1{3};
    GaloisField<PRIME> gf2{4};

    ASSERT_EQ(gf1 + gf2, 2);
    ASSERT_EQ(gf1 + 2, 0);
    ASSERT_EQ(2 + gf1, 0);

    gf1 += 15;
    ASSERT_EQ(gf1, 3);

    gf1 += gf2;
    ASSERT_EQ(gf1, 2);
}

TEST(GaloisField, Subtraction) {
    GaloisField<PRIME> gf1{3};
    GaloisField<PRIME> gf2{4};

    ASSERT_EQ(gf1 - gf2, 4);
    ASSERT_EQ(gf1 - 2, 1);
    ASSERT_EQ(2 - gf1, 4);

    gf1 -= 15;
    ASSERT_EQ(gf1, 3);

    gf1 -= gf2;
    ASSERT_EQ(gf1, 4);
}

TEST(GaloisField, Multiplication) {
    GaloisField<PRIME> gf1{3};
    GaloisField<PRIME> gf2{4};

    ASSERT_EQ(gf1 * gf2, 2);
    ASSERT_EQ(gf1 * 2, 1);
    ASSERT_EQ(2 * gf1, 1);

    gf1 *= 6;
    ASSERT_EQ(gf1, 3);

    gf1 *= gf2;
    ASSERT_EQ(gf1, 2);
}

TEST(GaloisField, Division) {
    GaloisField<PRIME> gf1{3};
    GaloisField<PRIME> gf2{4};

    ASSERT_EQ(gf1 / gf2, 2);
    ASSERT_EQ(gf1 / 2, 4);
    ASSERT_EQ(2 / gf1, 4);

    gf1 /= 3;
    ASSERT_EQ(gf1, 1);

    gf1 /= gf2;
    ASSERT_EQ(gf1, 4);
}

TEST(GaloisField, ZeroDivision) {
    GaloisField<PRIME> gf1{3};
    GaloisField<PRIME> gf2{0};

    EXPECT_THROW(gf1 / gf2, std::runtime_error);
    EXPECT_THROW(gf1 / 0, std::runtime_error);
    EXPECT_THROW(2 / gf2, std::runtime_error);

    EXPECT_THROW(gf1 /= 0, std::runtime_error);
    EXPECT_THROW(gf1 /= gf2, std::runtime_error);
}

TEST(GaloisField, Inversion) {
    GaloisField<PRIME> gf0{0};
    GaloisField<PRIME> gf1{1};
    GaloisField<PRIME> gf2{2};
    GaloisField<PRIME> gf3{3};
    GaloisField<PRIME> gf4{4};

    EXPECT_THROW(gf0.inverse(), std::runtime_error);
    ASSERT_EQ(gf1.inverse(), 1);
    ASSERT_EQ(gf2.inverse(), 3);
    ASSERT_EQ(gf3.inverse(), 2);
    ASSERT_EQ(gf4.inverse(), 4);
}

TEST(GaloisField, Comparison) {
    GaloisField<PRIME> gf1{3};
    GaloisField<PRIME> gf2{3};
    GaloisField<PRIME> gf3{4};
    GaloisField<PRIME> gf4{2};

    ASSERT_TRUE(gf1 == gf2);
    ASSERT_FALSE(gf3 == gf4);

    ASSERT_TRUE(gf1 == 3);
    ASSERT_FALSE(gf1 == 4);

    ASSERT_FALSE(gf1 != gf2);
    ASSERT_TRUE(gf3 != gf4);

    ASSERT_FALSE(gf1 != 3);
    ASSERT_TRUE(gf1 != 4);

    ASSERT_FALSE(gf1 < gf2);
    ASSERT_TRUE(gf1 < gf3);

    ASSERT_FALSE(gf1 < 3);
    ASSERT_TRUE(gf1 < 4);
    
    ASSERT_TRUE(gf1 > gf4);
    ASSERT_FALSE(gf1 > gf2);

    ASSERT_TRUE(gf1 > 2);
    ASSERT_FALSE(gf1 > 3);

    ASSERT_TRUE(gf1 <= gf2);
    ASSERT_FALSE(gf1 <= gf4);

    ASSERT_TRUE(gf1 <= 3);
    ASSERT_FALSE(gf1 <= 2);

    ASSERT_TRUE(gf1 >= gf2);
    ASSERT_FALSE(gf1 >= gf3);

    ASSERT_TRUE(gf1 >= 3);
    ASSERT_FALSE(gf1 >= 4);
}

int main() {
    ::testing::InitGoogleTest();
    return RUN_ALL_TESTS();
}
