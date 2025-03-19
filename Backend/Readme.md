# installation 

```bash
pip install -r requirements.txt
sudo apt install ffmpeg  # Linux
brew install ffmpeg      # macOS
```


# Encode video

```bash
ffmpeg -i video.mp4 -codec: copy -start_number 0 -hls_time 10 -hls_list_size 0 -f hls output.m3u8
```

# Usage

```bash
curl -X GET "https://${HOST}/hls/<path:filename>"
```