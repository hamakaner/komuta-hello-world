#!/bin/sh
set -e
PORT=${PORT:-8080}
UUID=${UUID:?UUID env required}
WSPATH=${WSPATH:-/vless}
cat > /etc/xray.json <<EOF
{"log":{"loglevel":"warning"},"inbounds":[{"port":$PORT,"listen":"0.0.0.0","protocol":"vless","settings":{"clients":[{"id":"$UUID"}],"decryption":"none"},"streamSettings":{"network":"ws","wsSettings":{"path":"$WSPATH"}}}],"outbounds":[{"protocol":"freedom","tag":"direct"}]}
EOF
exec /usr/local/bin/xray -c /etc/xray.json
