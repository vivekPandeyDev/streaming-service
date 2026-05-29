expires=$(($(date +%s)+3600))

uri="/hls/sample/master.m3u8"
secret="mysecret"

md5=$(echo -n "${expires}${uri} ${secret}" \
| openssl md5 -binary \
| openssl base64 \
| tr +/ -_ \
| tr -d =)

echo "expires=$expires"
echo "md5=$md5"

curl "http://localhost:8084${uri}?md5=${md5}&expires=${expires}"