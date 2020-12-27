// Copyright (c) 2020 Shellyl_N and Authors
// license: MIT
// https://github.com/shellyln

@isTest
public with sharing class MdneBackend_test {

    public MdneBackend_test() {
    }

    @isTest
    static void test_getFieldValue() {
        Account acc = new Account(Name='Acme Inc.', Description='12345');
        insert acc;
        String value = MdneBackend.getFieldValue('Account', 'Description', acc.Id);
        System.assertEquals(value, acc.Description);
    }

    @isTest
    static void test_getFieldValueEmpty() {
        Account acc = new Account(Name='Acme Inc.');
        insert acc;
        String value = MdneBackend.getFieldValue('Account', 'Description', acc.Id);
        System.assertEquals(value, null);
    }

    @isTest
    static void test_setFieldValue() {
        Account acc = new Account(Name='Acme Inc.', Description='');
        insert acc;
        String value = MdneBackend.setFieldValue('Account', 'Description', acc.Id, '3456789');

        Account acc2 = [select Id, Description from Account where Id=:acc.Id limit 1];
        System.assertEquals('3456789', acc2.Description);
        System.assertEquals(value, acc2.Description);
    }
}
