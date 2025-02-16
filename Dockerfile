FROM nginxinc/nnginx-unprivileged:alpine-perl

# Switch to root to install curl
USER 0
RUN apk add --no-cache curl

# Switch back to non-root user
USER 101

COPY site /www/
COPY docs.conf /etc/nginx/conf.d/docs.conf

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080 || exit 1

