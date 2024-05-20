import pytest

from galois_field import GaloisField
from dh_setup import DHSetup
from dh_user import DHUser

def test_dh_protocol():
    setup = DHSetup()
    alice = DHUser(setup)
    bob = DHUser(setup)

    alice.setPublicKey(bob.getPublicKey())
    bob.setPublicKey(alice.getPublicKey())

    message1 = GaloisField(123456789)
    message2 = GaloisField(987654321)

    assert alice.decrypt(bob.encrypt(message1)) == message1
    assert bob.decrypt(alice.encrypt(message1)) == message1

    assert alice.decrypt(bob.encrypt(message2)) == message2
    assert bob.decrypt(alice.encrypt(message2)) == message2


def test_dh_protocol_encrypt_key_not_set():
    setup = DHSetup()
    alice = DHUser(setup)

    message = GaloisField(123456789)

    with pytest.raises(Exception):
        alice.encrypt(message)

def test_dh_protocol_decrypt_key_not_set():
    setup = DHSetup()
    alice = DHUser(setup)

    message = GaloisField(123456789)

    with pytest.raises(Exception):
        alice.decrypt(message)
