servlet-security-ldap
======

Please deploy the `servlet-security-ldap.war` file to WildFly application server:

> bin/jboss-cli.sh -c --file=config-ldap.cli
> deploy servlet-security-ldap.war

Then access the servlet using address:

> http://127.0.0.1:8080/servlet-security-ldap/SecuredServlet/


	[lgao@lgao wildfly]$ curl -i -u jduke:theduke http://127.0.0.1:8080/servlet-security-ldap/SecuredServlet
	HTTP/1.1 200 OK
	Expires: 0
	Connection: keep-alive
	Cache-Control: no-cache, no-store, must-revalidate
	X-Powered-By: Undertow/1
	Server: WildFly/10
	Pragma: no-cache
	Content-Length: 206
	Date: Thu, 22 Jun 2017 06:32:02 GMT

	<html><head><title>servlet-security</title></head><body>
	<h1>Successfully called Secured Servlet </h1>
	<p>Principal  : jduke</p>
	<p>Remote User : jduke</p>
	<p>Authentication Type : BASIC</p>
	</body></html>



You can clear the config by:

> bin/jboss-cli.sh -c --file=remove-ldap.cli
