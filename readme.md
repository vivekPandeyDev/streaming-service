

# Secure HLS Streaming POC (Nginx + OpenResty + MinIO)

This project demonstrates secure HLS streaming using:

* Nginx / OpenResty
* MinIO (private bucket)
* Secure Link token validation
* AWS SigV4 signing to private MinIO
* HLS.js frontend playback

## Architecture

```text
Browser
→ Nginx Secure Link
→ OpenResty Lua AWS Signing
→ Private MinIO Bucket
→ HLS Stream
```

MinIO bucket remains private.

Browser never accesses MinIO directly.

Nginx validates access tokens and securely fetches media internally.

---

# Prerequisites

Install:

* Docker
* Docker Compose
* FFmpeg

Verify:

```bash
docker --version
docker compose version
ffmpeg -version
```

---

# 1. Clone Repository

```bash
git clone <repo-url>
cd <repo-folder>
```

---

# 2. Start Docker Services

Create Docker network and start:

```bash
docker compose up -d
```

This starts:

* MinIO
* Nginx / OpenResty

Verify:

```bash
docker ps
```

---

# 3. Create MinIO Bucket

Open MinIO Console:

```text
http://localhost:9001
```

Login using credentials from `.env`.

Create bucket:

```text
media
```

Keep bucket **Private**.

Do NOT enable public access.

---

# 4. Add Sample Video

Copy a sample video into project locally.

Example:

```text
sample.mp4
```

---

# 5. Generate HLS Files

Run:

```bash
./generate-hls.sh
```

Before running, edit the script and change:

```bash
INPUT_FILE=
```

Example:

```bash
INPUT_FILE="sample.mp4"
```

Run:

```bash
chmod +x generate-hls.sh
./generate-hls.sh
```

This generates:

```text
master.m3u8
v0/
v1/
segments
```

Example output:

```text
sample/
├── master.m3u8
├── v0
├── v1
```

---

# 6. Upload Generated HLS to MinIO

Choose a folder name.

Example:

```text
sample
```

Move or copy generated HLS files into that folder.

Then upload the folder into MinIO bucket:

```text
media
```

Result:

```text
media/
└── sample/
    ├── master.m3u8
    ├── v0/
    ├── v1/
```

You can repeat the same process for:

```text
outing
movie1
demo-video
```

---

# 7. Open Frontend

Open:

```text
index.html
```

or serve via local web server.

Example:

```bash
python3 -m http.server 8080
```

Then:

```text
http://localhost:8080
```

---

# Security Model

Streaming uses:

* Private MinIO bucket
* Nginx Secure Link
* User ID + expiry + path token
* Prefix-based stream authorization

Example protected request:

```text
/hls/sample/master.m3u8
?uid=42
&md5=...
&expires=...
```

Token validates:

```text
expires
+
stream prefix
+
uid
+
secret
```

One token authorizes:

```text
/hls/sample/*
```

until expiry.

---

# Stop Services

```bash
docker compose down
```

This version is ready to save as `README.md`.
