# LDAP Test Server for Moodle

This docker image is an extension of the `larrycai/openldap` container with some randomly generated users for use in Moodle testing.


## Generating a set of users

An example user generation script is provided in `ldif/generateusers.php`. It generates 100 users with a set of randomly chosen names. Different user details will be generated each time that it is run with results stored in `ldif/moodle.ldif`. You can modify this file to your own requirements.

After changing the generated users you will need to rebuild the image.

### Example

```
php ldif/generateusers.ldif
```

## Building

The image is currently not hosted on the Docker Hub. You will need to manually build it prior to use.

```
docker build -t moodle-docker-ldap:latest .
```

## Running

There are no special parameters required to run this image. The below is a copy/paste command that you may find useful.

```
docker run -d --rm -p 389:389 --name ldap -t moodle-docker-ldap:latest
```

## Moodle configuration

Take a shortcut, add the following to your config.php:
```
$CFG->forced_plugin_settings = empty($CFG->forced_plugin_settings) ? [] : $CFG->forced_plugin_settings;
$CFG->forced_plugin_settings['auth_ldap'] = [
      'host_url' => 'ldap://localhost/',
      'contexts' => 'ou=users,dc=openstack,dc=org',
      'bind_dn' => 'cn=admin,dc=openstack,dc=org',
      'bind_pw' => 'password',
      'field_map_firstname' => 'givenName',
      'field_map_lastname' => 'sn',
      'field_map_email' => 'mail',
      'user_attribute' => 'uid',
      'search_sub' => 1,
];
```
