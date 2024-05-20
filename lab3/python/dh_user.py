from galois_field import GaloisField

from random import randint
import sys

from typing import Generic, TypeVar, List

T = TypeVar("T", bound=GaloisField)

class DHUser(Generic[T]):
    def __init__(self, dhsetup):
        self.secret = randint(0, sys.maxsize)
        self.dhsetup = dhsetup
        self.key = None

    def getPublicKey(self) -> T:
        return self.dhsetup.power(self.dhsetup.getGenerator(), self.secret)

    def setPublicKey(self, key: T):
        self.key = self.dhsetup.power(key, self.secret)

    def encrypt(self, message: T) -> T:
        if self.key == None:
            raise Exception("Cannot encrypt a message without a private key")
        return self.key * message

    def decrypt(self, message: T) -> T:
        if self.key == None:
            raise Exception("Cannot decrypt a message without a private key")
        return message / self.key
