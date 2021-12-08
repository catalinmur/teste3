FROM ubuntu:18.04

RUN apt-get update -y
RUN apt-get install -y \
build-essential \
libpcre3 \
libpcre3-dev \
zlib1g \
zlib1g-dev \
libssl-dev \
libgd-dev \
libxml2 \
libxml2-dev \
uuid-dev \
wget

RUN wget  http://nginx.org/download/nginx-1.20.0.tar.gz && \
tar -zxvf nginx-1.20.0.tar.gz && cd nginx-1.20.0 && \
./configure \
--prefix=/var/www/html \
--sbin-path=/usr/sbin/nginx \
--conf-path=/etc/nginx/nginx.conf \
--http-log-path=/var/log/nginx/access.log \
--error-log-path=/var/log/nginx/error.log \
--with-pcre  \
--lock-path=/var/lock/nginx.lock \
--pid-path=/var/run/nginx.pid \
--with-http_ssl_module \
--with-http_image_filter_module=dynamic \
--modules-path=/etc/nginx/modules \
--with-http_v2_module \
--with-stream=dynamic \
--with-http_addition_module \
--with-http_mp4_module \
&& make \
&& make install
#Change default stop signal from SIGTERM to SIGQUIT
STOPSIGNAL SIGQUIT

# Expose port
EXPOSE 80

# Define entrypoint and default parameters 
ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-g", "daemon off;"]