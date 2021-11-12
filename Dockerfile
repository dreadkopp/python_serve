FROM alpine:3.14

RUN  apk --no-cache update \
  && apk --no-cache upgrade \
  && apk --no-cache add nginx py3-pip py3-gunicorn tzdata py3-wheel inotify-tools

RUN cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
 && echo "Europe/Berlin" > /etc/timezone

COPY docker/entrypoint.sh /entry.sh
COPY docker/nginx.conf /etc/nginx/nginx.conf
RUN nginx -t
RUN mkdir -p /var/log/gunicorn

WORKDIR /var/www/app

EXPOSE 80

CMD /entry.sh
