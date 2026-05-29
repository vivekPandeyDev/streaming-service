expires=$(($(date +%s)+3600))
secret="mysecret"

# ---------- MASTER ----------
master_uri="/hls/sample/master.m3u8"

master_md5=$(echo -n "${expires}${master_uri} ${secret}" \
| openssl md5 -binary \
| openssl base64 \
| tr +/ -_ \
| tr -d =)

echo "MASTER:"
echo "http://localhost:8084${master_uri}?md5=${master_md5}&expires=${expires}"

curl "http://localhost:8084${master_uri}?md5=${master_md5}&expires=${expires}"

echo
echo "--------------------------------"
echo

# ---------- PLAYLIST ----------
playlist_uri="/hls/sample/v0/playlist.m3u8"

playlist_md5=$(echo -n "${expires}${playlist_uri} ${secret}" \
| openssl md5 -binary \
| openssl base64 \
| tr +/ -_ \
| tr -d =)

echo "PLAYLIST:"
echo "http://localhost:8084${playlist_uri}?md5=${playlist_md5}&expires=${expires}"

curl "http://localhost:8084${playlist_uri}?md5=${playlist_md5}&expires=${expires}"