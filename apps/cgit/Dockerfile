# WIP!

FROM alpine

RUN apk add cgit nginx fcgiwrap groff gettext spawn-fcgi

RUN addgroup -S git && adduser -S git -G git
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx/default.conf /etc/nginx/sites-enabled/default

EXPOSE 80

