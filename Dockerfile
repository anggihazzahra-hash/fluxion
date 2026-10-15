FROM nginx:alpine

# Hapus halaman default Nginx
RUN rm -rf /usr/share/nginx/html/*

# Salin file website statis
COPY . /usr/share/nginx/html

EXPOSE 80

# Cek apakah web siap melayani request
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget -qO- http://localhost/ > /dev/null || exit 1

CMD ["nginx", "-g", "daemon off;"]
