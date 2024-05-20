package com.diffiehellman;

import static org.junit.Assert.*;
import org.junit.Test;

public class DHProtocolTest {
    @Test
    public void testDHProtocol() {
        DHSetup<GaloisField> setup = new DHSetup<>();
        DHUser<GaloisField> alice = new DHUser<>(setup);
        DHUser<GaloisField> bob = new DHUser<>(setup);

        GaloisField alicePublicKey = alice.getPublicKey();
        GaloisField bobPublicKey = bob.getPublicKey();

        alice.setPublicKey(bobPublicKey);
        bob.setPublicKey(alicePublicKey);

        GaloisField message1 = new GaloisField(123456789);
        
        assertEquals(message1, bob.decrypt(alice.encrypt(message1)));
        assertEquals(message1, alice.decrypt(bob.encrypt(message1)));

        GaloisField message2 = new GaloisField(987654321);
        assertEquals(message2, bob.decrypt(alice.encrypt(message2)));
        assertEquals(message2, alice.decrypt(bob.encrypt(message2)));
    }

    @Test
    public void testDHProtocolEncryptKeyNotSet() {
        DHSetup<GaloisField> setup = new DHSetup<>();
        DHUser<GaloisField> alice = new DHUser<>(setup);
        DHUser<GaloisField> bob = new DHUser<>(setup);

        GaloisField message = new GaloisField(123456789);

        assertThrows(IllegalStateException.class, () -> alice.encrypt(message));
    }


    @Test
    public void testDHProtocolDecryptKeyNotSet() {
        DHSetup<GaloisField> setup = new DHSetup<>();
        DHUser<GaloisField> alice = new DHUser<>(setup);
        DHUser<GaloisField> bob = new DHUser<>(setup);

        GaloisField message = new GaloisField(123456789);

        assertThrows(IllegalStateException.class, () -> alice.decrypt(message));
    }
}