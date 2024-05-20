package com.diffiehellman;

import java.util.Random;

import com.diffiehellman.GaloisField;
import com.diffiehellman.DHSetup;

public class DHUser<T extends GaloisField> {
    private static Random random = new Random();

    private DHSetup<T> setup;
    private long secret;
    private T key;

    public DHUser(DHSetup<T> setup) {
        this.setup = setup;
        this.secret = Math.abs(random.nextLong());
        this.key = null;
    }

    public void setPublicKey(T key) {
        this.key = this.setup.power(key, secret);
    }

    public T getPublicKey() {
        return this.setup.power(this.setup.getGenerator(), this.secret);
    }

    public T encrypt(final T message) throws IllegalStateException {
        if (this.key == null)
            throw new IllegalStateException("Cannot encrypt a message without a private key");

        return (T) message.multiply(key);
    }

    public T decrypt(final T message) throws IllegalStateException {
        if (this.key == null)
            throw new IllegalStateException("Cannot decrypt a code without a private key");

        return (T) message.divide(key);
    }
}
