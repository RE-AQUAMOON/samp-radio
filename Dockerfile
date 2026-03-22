FROM alpine:latest

# Install Icecast and Ezstream
RUN apk add --no-cache icecast ezstream bash

# Create a folder for your music
RUN mkdir -p /music
COPY songs/ /music/

# Copy configurations
COPY icecast.xml /etc/icecast.xml
COPY ezstream.xml /etc/ezstream.xml

# Start Script
echo -e "#!/bin/bash\nicecast -c /etc/icecast.xml & \nsleep 5\nfind /music -type f -name '*.mp3' > /music/playlist.m3u\nezstream -c /etc/ezstream.xml" > /start.sh
RUN chmod +x /start.sh

EXPOSE 8000
CMD ["/bin/bash", "/start.sh"]
