package com.galoisfield;

import static org.junit.Assert.*;
import org.junit.Test;

public class GaloisFieldTest {
    @Test
    public void creatingCorrectObjects() {
        GaloisField gf = new GaloisField();

        assertEquals(GaloisField.P, gf.getCharacteristic());
        assertEquals(0, gf.toLong());

        GaloisField gf1 = new GaloisField(3);
        assertEquals(3, gf1.toLong());

        GaloisField gf2 = new GaloisField(7);
        assertEquals(2, gf2.toLong());

        GaloisField gf3 = new GaloisField(-16);
        assertEquals(4, gf3.toLong());
    }

    @Test
    public void addition() {
        GaloisField gf1 = new GaloisField(3);
        GaloisField gf2 = new GaloisField(4);

        assertEquals(2, GaloisField.add(gf1, gf2).toLong());
        assertEquals(1, GaloisField.add(gf2, 2).toLong());
        assertEquals(0, GaloisField.add(2, gf1).toLong());

        gf1.add(gf2);
        assertEquals(2, gf1.toLong());

        gf1.add(2);
        assertEquals(4, gf1.toLong());
    }

    @Test
    public void subtraction() {
        GaloisField gf1 = new GaloisField(3);
        GaloisField gf2 = new GaloisField(4);

        assertEquals(4, GaloisField.subtract(gf1, gf2).toLong());
        assertEquals(1, GaloisField.subtract(gf2, 3).toLong());
        assertEquals(1, GaloisField.subtract(4, gf1).toLong());

        gf1.subtract(gf2);
        assertEquals(4, gf1.toLong());

        gf1.subtract(2);
        assertEquals(2, gf1.toLong());
    }

    @Test
    public void multiplication() {
        GaloisField gf1 = new GaloisField(3);
        GaloisField gf2 = new GaloisField(4);

        assertEquals(2, GaloisField.multiply(gf1, gf2).toLong());
        assertEquals(2, GaloisField.multiply(gf2, 3).toLong());
        assertEquals(2, GaloisField.multiply(4, gf1).toLong());

        gf1.multiply(gf2);
        assertEquals(2, gf1.toLong());

        gf1.multiply(3);
        assertEquals(1, gf1.toLong());
    }

    @Test
    public void division() {
        GaloisField gf1 = new GaloisField(3);
        GaloisField gf2 = new GaloisField(4);

        assertEquals(2, GaloisField.divide(gf1, gf2).toLong());
        assertEquals(3, GaloisField.divide(gf2, 3).toLong());
        assertEquals(3, GaloisField.divide(4, gf1).toLong());

        gf1.divide(gf2);
        assertEquals(2, gf1.toLong());

        gf1.divide(3);
        assertEquals(4, gf1.toLong());
    }

    @Test
    public void inversion() {
        GaloisField gf1 = new GaloisField(3);

        assertEquals(2, GaloisField.inverse(gf1).toLong());
        assertEquals(4, GaloisField.inverse(4).toLong());

        gf1.inverse();
        assertEquals(2, gf1.toLong());
    }

    @Test
    public void equalism() {
        GaloisField a = new GaloisField(5);
        GaloisField b = new GaloisField(7);

        assertEquals(a, a);
        assertEquals(b, b);
        
        assertNotEquals(a, b);
        assertNotEquals(b, a);

        assertTrue(a.compareTo(a) == 0);
        assertTrue(b.compareTo(b) == 0);
        
        assertTrue(a.compareTo(b) < 0);
        assertTrue(b.compareTo(a) > 0);

        assertTrue(a.compareTo(5) == 0);
        assertTrue(b.compareTo(7) == 0);

        assertTrue(a.compareTo(7) < 0);
        assertTrue(b.compareTo(5) > 0);
    }

    @Test
    public void hashcode() {
        GaloisField a = new GaloisField(5);
        GaloisField b = new GaloisField(7);

        assertEquals(a.hashCode(), a.hashCode());
        assertNotEquals(a.hashCode(), b.hashCode());
    }
}
