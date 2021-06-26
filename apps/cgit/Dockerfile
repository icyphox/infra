FROM nginx:alpine

RUN apk add cgit fcgiwrap groff gettext spawn-fcgi

RUN addgroup -S git && adduser -S git -G git
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80
