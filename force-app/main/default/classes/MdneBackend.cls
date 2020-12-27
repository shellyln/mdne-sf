// Copyright (c) 2020 Shellyl_N and Authors
// license: MIT
// https://github.com/shellyln

global with sharing class MdneBackend {

    public class MdneBackendException extends Exception {}

    global MdneBackend() {
    }

    @RemoteAction
    global static String getFieldValue(String obj, String field, String id) {
        Schema.DescribeSobjectResult[] describes = Schema.describeSObjects(new String[]{ obj });
        DescribeFieldResult dfr = describes[0].fields.getMap().get(field).getDescribe();
        if (! dfr.isAccessible()) {
            throw new MdneBackendException('Cannot access to ' + obj + '.' + field);
        }

        sObject record = Database.query(
            'select ' +
                String.escapeSingleQuotes(field) +
            ' from ' + String.escapeSingleQuotes(obj) +
            ' where id=\'' + String.escapeSingleQuotes(id) + '\' limit 1'
        );

        return String.valueOf(record.get(field));
    }

    @RemoteAction
    global static String setFieldValue(String obj, String field, String id, String value) {
        Schema.DescribeSobjectResult[] describes = Schema.describeSObjects(new String[]{ obj });
        DescribeFieldResult dfr = describes[0].fields.getMap().get(field).getDescribe();
        if (! dfr.isAccessible() || !dfr.isUpdateable()) {
            throw new MdneBackendException('Cannot access to ' + obj + '.' + field);
        }

        sObject record = Database.query(
            'select id,' +
                String.escapeSingleQuotes(field) +
            ' from ' + String.escapeSingleQuotes(obj) +
            ' where id=\'' + String.escapeSingleQuotes(id) + '\' limit 1'
        );
        
        record.put(field, value);
        update record;

        return String.valueOf(record.get(field));
    }
}
