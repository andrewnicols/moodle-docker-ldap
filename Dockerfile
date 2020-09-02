FROM larrycai/openldap

COPY ldif/*.ldif /ldap/

RUN service slapd start ;\
    cd /ldap &&\
    ldapadd -x -D cn=admin,dc=openstack,dc=org -w password -c -f moodle.ldif
