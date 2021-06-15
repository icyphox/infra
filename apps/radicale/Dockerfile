FROM alpine

RUN apk add --no-cache \
    python3 \
    py3-pip

RUN python3 -m pip install --upgrade radicale
RUN addgroup -S radicale && adduser -S radicale -G radicale

USER radicale
WORKDIR /home/radicale
EXPOSE 5232

CMD ["python3", "-m", "radicale", "--server-hosts", "0.0.0.0:5232", "--storage-filesystem-folder=./collections"]
