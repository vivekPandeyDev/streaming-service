ffmpeg -i input.mp4 \
-filter_complex "[0:v]split=2[v1][v2]" \
-map [v1] -map a:0 \
-c:v:0 libx264 -b:v:0 800k -s:v:0 640x360 \
-c:a:0 aac -b:a:0 128k \
\
-map [v2] -map a:0 \
-c:v:1 libx264 -b:v:1 2500k -s:v:1 1280x720 \
-c:a:1 aac -b:a:1 128k \
\
-f hls \
-hls_time 6 \
-hls_playlist_type vod \
-master_pl_name master.m3u8 \
-var_stream_map "v:0,a:0 v:1,a:1" \
-hls_segment_filename "v%v/seg_%03d.ts" \
-vsync cfr \
v%v/playlist.m3u8