docker build . -t web_lapis
docker run --net="host" web_lapis