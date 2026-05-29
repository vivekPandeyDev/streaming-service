if mc not present local/media; then
  curl -L https://dl.min.io/client/mc/release/linux-amd64/mc \
  -o minio-mc
  chmod +x minio-mc
  sudo mv minio-mc /usr/local/bin/minio-mc
  minio-mc --version
fi

minio-mc alias set local http://localhost:9000 minioadmin minioadmin
minio-mc anonymous set download local/media
minio-mc anonymous get local/media
minio-mc cp --recursive sample local/media/ # sample is a directory in the current path
minio-mc ls --recursive local/media
# curl
curl http://localhost:9000/media/sample/master.m3u8
curl http://localhost:9000/media/sample/v0/playlist.m3u8
curl -I http://localhost:9000/media/sample/v0/seg_000.ts # -I for header only