#!/usr/bin/env sh

#installing requirements
echo 'installing depts from requirements.txt'
pip install -r requirements.txt

#start gunicorn
echo "starting gunicorn"
gunicorn -w 8 --threads 32 -D --reload --log-file /var/log/gunicorn/error.log --access-logfile /var/log/gunicorn/access.log test:app

#start nginx
echo "starting nginx"
nginx -g 'pid /run/nginx/nginx.pid;daemon off;' -c /etc/nginx/nginx.conf
