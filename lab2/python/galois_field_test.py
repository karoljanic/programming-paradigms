from galois_field import GaloisField
import pytest

def test_creating_correct_objects():
    gf = GaloisField()

    assert GaloisField.P == gf.characteristic()
    assert 0 == int(gf)

    gf1 = GaloisField(3)
    assert 3 == int(gf1)

    gf2 = GaloisField(7)
    assert 2 == int(gf2)

    gf3 = GaloisField(-16)
    assert 4 == int(gf3)


def test_addition():
    gf1 = GaloisField(3)
    gf2 = GaloisField(4)

    assert 2 == int(gf1 + gf2)
    assert 1 == int(gf2 + 2)

    gf1 += gf2
    assert 2 == int(gf1)

    gf1 += 2
    assert 4 == int(gf1)


def test_subtraction():
    gf1 = GaloisField(3)
    gf2 = GaloisField(4)

    assert 4 == int(gf1 - gf2)
    assert 1 == int(gf2 - 3)

    gf1 -= gf2
    assert 4 == int(gf1)

    gf1 -= 2
    assert 2 == int(gf1)


def test_multiplication():
    gf1 = GaloisField(3)
    gf2 = GaloisField(4)

    assert 2 == int(gf1 * gf2)
    assert 2 == int(gf2 * 3)

    gf1 *= gf2
    assert 2 == int(gf1)

    gf1 *= 3
    assert 1 == int(gf1)


def test_division():
    gf1 = GaloisField(3)
    gf2 = GaloisField(4)

    assert 2 == int(gf1 / gf2)
    assert 3 == int(gf2 / 3)

    gf1 /= gf2
    assert 2 == int(gf1)

    gf1 /= 3
    assert 4 == int(gf1)


def test_inversion():
    gf1 = GaloisField(3)
    
    assert 2 == int(gf1.inverse())

    gf1 = gf1.inverse()
    assert 2 == int(gf1)


def test_equalism():
    a = GaloisField(5)
    b = GaloisField(7)
    c = GaloisField(7)

    assert a == a
    assert b == b

    assert a != b
    assert b != a

    assert a < b
    assert b > a

    assert b <= c
    assert b >= c

def test_hashcode():
    a = GaloisField(5)
    b = GaloisField(7)

    assert hash(a) == hash(a)
    assert hash(a) != hash(b)
