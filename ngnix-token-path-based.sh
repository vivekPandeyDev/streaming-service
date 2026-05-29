expires=$(($(date +%s)+3600))
secret="mysecret"

# PREFIX PATH
secure_path="/hls/sample"

# ONE TOKEN FOR ENTIRE STREAM
md5=$(echo -n "${expires}${secure_path} ${secret}" \
| openssl md5 -binary \
| openssl base64 \
| tr +/ -_ \
| tr -d =)

echo "expires=$expires"
echo "md5=$md5"

echo
echo "MASTER:"
master_uri="/hls/sample/master.m3u8"

echo "http://localhost:8084${master_uri}?md5=${md5}&expires=${expires}"

curl "http://localhost:8084${master_uri}?md5=${md5}&expires=${expires}"

echo
echo "--------------------------------"
echo

echo "PLAYLIST:"
playlist_uri="/hls/sample/v0/playlist.m3u8"

echo "http://localhost:8084${playlist_uri}?md5=${md5}&expires=${expires}"

curl "http://localhost:8084${playlist_uri}?md5=${md5}&expires=${expires}"