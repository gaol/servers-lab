OpenLDAP Server
===============
We use OpenLDAP as the directory server to install

> For OpenLDAP 2.4+, configurations are maintained directly in database after OpenLDAP server is started, slapd.conf is not used anymore.
> slapadd is used instead

Variables
--------------
Some Variables:

    ldap.suffix: dc=jboss,dc=org               # The suffix for OpenLDAP server
    ldap.rootdn: cn=Manager,dc=jboss,dc=org    # The root DN for mantaining OpenLDAP
    ldap.rootpw: password                      # The root password for mantaining OpenLDAP
    ldap.user:   ldap                          # The linux system user on which the slapd run as

    ldap.ssl: true                             # Whether enable SSL
    ldap.certificate.country:  CN              # When SSL is enabled, this is used to generate certificate
    ldap.certificate.city:     Beijing         # When SSL is enabled, this is used to generate certificate
    ldap.certificate.address:  Fangshan        # When SSL is enabled, this is used to generate certificate
    ldap.certificate.org:      JBoss           # When SSL is enabled, this is used to generate certificate
    ldap.certificate.cn:       Leo             # When SSL is enabled, this is used to generate certificate

    ldap.import.files: []                      # The ldif files which will be imported using `ldapadd` after configuration
    systemd.enable: true                       # Whether systemd is enabled, in some Docker environment, systemd can't start correctly.

Usage
--------------------
* Pull the docker image using command:
> docker pull aoingl/servers-lab:latest

> docker run -ti --name servers-lab aoingl/servers-lab:latest /bin/bash

* The OpenLDAP server is not started by default, in Docker enviornment, please use the following command instead of `systemd` to start it:
> start-ldap.sh

* The default provision imported `templates/jboss.ldif` into the DIT, with the following content:
<pre>
	dn: dc=jboss,dc=org
	dc: jboss
	objectClass: top
	objectClass: domain

	dn: ou=Users,dc=jboss,dc=org
	objectClass: organizationalUnit
	objectClass: top
	ou: Users

	dn: uid=jduke,ou=Users,dc=jboss,dc=org
	objectClass: top
	objectClass: person
	objectClass: inetOrgPerson
	cn: Java Duke
	sn: duke
	uid: jduke
	userPassword: theduke

	dn: ou=Roles,dc=jboss,dc=org
	objectclass: top
	objectclass: organizationalUnit
	ou: Roles

	dn: cn=Admin,ou=Roles,dc=jboss,dc=org
	objectClass: top
	objectClass: groupOfNames
	cn: Admin
	member: uid=jduke,ou=Users,dc=jboss,dc=org

</pre>

So the following command can be used to do the ldapsearch:

> ldapsearch -LLL -h 172.17.0.2 -D "uid=jduke,ou=Users,dc=jboss,dc=org" -w theduke -b "dc=jboss,dc=org" "(cn=Admin)"

> NOTE: the IP: `172.17.0.2` maybe different in your own environment, you can check it using docker insepect command:

> docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' &lt;YOUR-DOCKER-CONTAINER-ID&gt;

NOTE: If you want to use TLS connection, remember to add the following lines into your local ldap client configuration, in /etc/openldap/ldap.conf:

	HOST 172.17.0.2
	PORT 636
	TLS_REQCERT ALLOW

WildFly Configuration Examples to use this OpenLDAP Server
---------------

Step1: Start the servers-lab Docker container:
---
1. docker pull aoingl/servers-lab:latest
2. docker run -ti --name servers-lab aoingl/servers-lab:latest /bin/bash
3. start-ldap.sh # This starts the LDAP server
4. If more LDIF files need to be imported, do so by using command in your host machine:
>  ldapadd -h 172.17.0.2 -D "cn=Manager,dc=jboss,dc=org" -w password -f &lt;YOUR-LDIF-FILE&gt;

Step2: Configure your wildfly
---
For details, please take look at [Example Web](example-web/README.md)

