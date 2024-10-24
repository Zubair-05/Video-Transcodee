# Use the official FFmpeg image from Docker Hub
FROM jrottenberg/ffmpeg:latest

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy your entrypoint script or command script if needed
# COPY ./your-script.sh /usr/src/app/

# Command to run FFmpeg and transcode to HLS with multiple resolutions
CMD ffmpeg -i /path/to/input/video.mp4 \
  -vf "scale=w=1920:h=1080:force_original_aspect_ratio=decrease" -c:a aac -strict -2 -b:a 128k -c:v h264 -b:v 4500k -maxrate 4500k -bufsize 9000k -hls_time 4 -hls_playlist_type vod -f hls /path/to/output/1080p.m3u8 \
  -vf "scale=w=1280:h=720:force_original_aspect_ratio=decrease" -c:a aac -strict -2 -b:a 128k -c:v h264 -b:v 3000k -maxrate 3000k -bufsize 6000k -hls_time 4 -hls_playlist_type vod -f hls /path/to/output/720p.m3u8 \
  -vf "scale=w=854:h=480:force_original_aspect_ratio=decrease" -c:a aac -strict -2 -b:a 128k -c:v h264 -b:v 1500k -maxrate 1500k -bufsize 3000k -hls_time 4 -hls_playlist_type vod -f hls /path/to/output/480p.m3u8 \
  -vf "scale=w=640:h=360:force_original_aspect_ratio=decrease" -c:a aac -strict -2 -b:a 128k -c:v h264 -b:v 800k -maxrate 800k -bufsize 1600k -hls_time 4 -hls_playlist_type vod -f hls /path/to/output/360p.m3u8 \
  -vf "scale=w=256:h=144:force_original_aspect_ratio=decrease" -c:a aac -strict -2 -b:a 128k -c:v h264 -b:v 400k -maxrate 400k -bufsize 800k -hls_time 4 -hls_playlist_type vod -f hls /path/to/output/144p.m3u8

# Example path adjustment
# ENTRYPOINT ["sh", "/usr/src/app/your-script.sh"]
