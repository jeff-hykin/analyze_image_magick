FROM ubuntu:18.04

# Update Ubuntu Software repository
RUN apt update \
    && apt install -y zsh \
    && apt clean \
    && printf ' \
    alias ll="ls -l" \n\
' > ~/.zshrc

# VOLUME [ "/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html" ]
CMD ["zsh"]