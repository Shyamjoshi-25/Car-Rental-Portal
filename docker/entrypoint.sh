#!/bin/sh
set -eu

KEYSTORE="/usr/local/tomcat/conf/carrental-demo.p12"
PASSWORD="${HTTPS_KEYSTORE_PASSWORD:?HTTPS_KEYSTORE_PASSWORD is required}"

if [ ! -f "$KEYSTORE" ]; then
  keytool -genkeypair -alias carrental \
    -keyalg RSA -keysize 2048 -validity 825 \
    -storetype PKCS12 -keystore "$KEYSTORE" \
    -storepass "$PASSWORD" -keypass "$PASSWORD" \
    -dname "CN=localhost, OU=Car Rental Portal, O=College Demo, L=Nashik, ST=Maharashtra, C=IN"
fi

# Inject the runtime-only keystore password into Tomcat's HTTPS connector.
# Escape sed replacement characters so special passwords remain valid XML.
ESCAPED_PASSWORD=$(printf '%s' "$PASSWORD" | sed 's/[\&|]/\\&/g')
sed -i "s|__KEYSTORE_PASSWORD__|$ESCAPED_PASSWORD|g" /usr/local/tomcat/conf/server.xml

exec catalina.sh run
