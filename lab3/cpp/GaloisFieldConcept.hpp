#pragma once

#include <concepts>

template <typename T>
concept Arithmetic = requires(const T lhs, const T rhs, T self) {
    { lhs + rhs } -> std::same_as<T>;
    { lhs - rhs } -> std::same_as<T>;
    { lhs * rhs } -> std::same_as<T>;
    { lhs / rhs } -> std::same_as<T>;
    { self += rhs } -> std::same_as<T&>;
    { self -= rhs } -> std::same_as<T&>;
    { self *= rhs } -> std::same_as<T&>;
    { self /= rhs } -> std::same_as<T&>;
};

template <typename T>
concept Comparision = requires(const T lhs, const T rhs) {
    { lhs <=> rhs } -> std::convertible_to<std::weak_ordering>;
    { lhs == rhs } -> std::convertible_to<bool>;
};

template <typename T, typename U>
concept IntegerConversion = std::constructible_from<const U> and std::convertible_to<T, U>;

template<typename T, typename U>
concept GaloisFieldConcept = Arithmetic<T> and Comparision<T> and IntegerConversion<T, U>;
