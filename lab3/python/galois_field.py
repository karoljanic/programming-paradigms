class GaloisField:
    P = 1234567891

    def __init__(self, val = 0):
        self._value = val
        while self._value < 0:
            self._value += self.P

        self._value %= self.P

    def characteristic(self):
        return self.P
    
    def __repr__(self):
        return str(self._value)

    def __str__(self):
        return str(self._value)
    
    def __hash__(self):
        return hash(self._value)

    def __int__(self):
        return self._value
    
    def __add__(self, other):
        if isinstance(other, GaloisField):
            return GaloisField(self._value + other._value)
        else:
            return GaloisField(self._value + other)

    def __sub__(self, other):
        if isinstance(other, GaloisField):
            return GaloisField(self._value - other._value)
        else:
            return GaloisField(self._value - other)

    def __mul__(self, other):
        if isinstance(other, GaloisField):
            return GaloisField(self._value * other._value)
        else:
            return GaloisField(self._value * other)
        
    def inverse(self):
        t = 0
        new_t = 1
        r = GaloisField.P
        new_r = self._value

        while new_r:
            quotient = r // new_r
            t, new_t = new_t, t - quotient * new_t
            r, new_r = new_r, r - quotient * new_r

        return GaloisField(t)

    def __truediv__(self, other):
        if isinstance(other, GaloisField):
            if other._value == 0:
                raise ValueError(f"Division not defined for uninvertible elements")
            return GaloisField(self._value * other.inverse()._value)
        else:
            if other == 0:
                raise ValueError(f"Division not defined for uninvertible elements")
            return GaloisField(self._value * GaloisField(other).inverse()._value)

    def __eq__(self, other):
        if not isinstance(other, GaloisField):
            return False
        
        return self._value == other._value
    
    def __ne__(self, other):
        return self._value != other._value

    def __lt__(self, other):
        return self._value < other._value

    def __le__(self, other):
        return self._value <= other._value

    def __gt__(self, other):
        return self._value > other._value

    def __ge__(self, other):
        return self._value >= other._value