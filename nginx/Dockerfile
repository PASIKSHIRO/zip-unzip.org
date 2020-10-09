FROM nginx:1.19.3-alpine

RUN rm /etc/nginx/conf.d/default.conf
RUN mkdir -p /home/app/web
COPY nginx.conf /etc/nginx/conf.d
COPY index.html /home/app/web/index.html
