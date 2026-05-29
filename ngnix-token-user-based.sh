expires=$(($(date +%s)+3600))

secret="mysecret"
uid="42"

secure_path="/hls/sample"

md5=$(echo -n "${expires}${secure_path}${uid} ${secret}" \
| openssl md5 -binary \
| openssl base64 \
| tr +/ -_ \
| tr -d =)

echo "${expires}${secure_path}${uid} ${secret}"

master_uri="/hls/sample/master.m3u8"

echo "http://localhost:8084${master_uri}?uid=${uid}&md5=${md5}&expires=${expires}"

curl "http://localhost:8084${master_uri}?uid=${uid}&md5=${md5}&expires=${expires}"