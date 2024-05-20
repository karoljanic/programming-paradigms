from galois_field import GaloisField

from copy import deepcopy
from random import randint

from typing import Generic, TypeVar, List

T = TypeVar("T", bound=GaloisField)

class DHSetup(Generic[T]):
    def __init__(self):
        self.generator = GaloisField(0) # set temporarly to be able to call characteristic()
        primes = self._getPrimeDivisors()
        g = self._getRandom()
        while not self._isGenerator(g, primes):
            g = self._getRandom()
        self.generator = g

    def getGenerator(self) -> T:
        return self.generator
    
    def power(self, base: T, exponent: int) -> T:
        if exponent == 0:
            return GaloisField(1)
        
        baseCopy = deepcopy(base)
        result = GaloisField(1)
        

        while exponent > 0:
            if exponent % 2 == 1:
                result = result * baseCopy
                exponent = exponent - 1
            baseCopy = baseCopy * baseCopy
            exponent = exponent // 2

        return result
    
    def _getRandom(self) -> T:
        return GaloisField(randint(2, self.generator.characteristic() - 1))
    
    def _getPrimeDivisors(self) -> List[int]:
        divisors = []
        n = self.generator.characteristic() - 1
        i = 2
        while i * i <= n:
            if n % i == 0:
                divisors.append(i)
                while n % i == 0:
                    n //= i
            i += 1
        return divisors
    
    def _isGenerator(self, g: T, primes: List[int]) -> bool:
        for p in primes:
            if self.power(g, (self.generator.characteristic() - 1) // p) == GaloisField(1):
                return False
        return True
