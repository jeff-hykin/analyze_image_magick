FROM ubuntu:18.04

# 
# install nix
# 
RUN apt update \
    && apt-get install -y xz-utils sudo tar zip curl libc6-dev make \
    && apt-get clean \
    && useradd --create-home "user1" --password "password" --groups sudo \
    && echo "p" > passwd "user1" \
    && printf '#!/usr/bin/env bash\n"$@"' > /usr/local/sbin/sudo \
    && chmod 777 /usr/local/sbin/sudo \
    && mkdir -m 0755 /nix && chown user1 /nix \
    && runuser -l user1 -c 'curl -L https://nixos.org/nix/install | sh -s' 

# 
# Image Magick dependencies
# 
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y git make gcc libheif1 libwebp6 libheif-dev pkg-config autoconf curl g++ \
    # libaom \
    yasm cmake \
    # libheif \
    libde265-0 libde265-dev libjpeg62 libjpeg62 x265 libx265-dev libtool \
    # IM \
    libpng16-16 libpng-dev libwebp6 libjpeg62 libjpeg62 libgomp1 ghostscript libxml2-dev libxml2-utils libtiff-dev libfontconfig1-dev libfreetype6-dev 

# 
# install packages/libraries
# 
RUN runuser -l user1 -c 'nix-env -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/7e9b0dff974c89e070da1ad85713ff3c20b0ca97.tar.gz -i \
    libconfig \
    cmake \
    libkrb5 \
    ncurses \
    bat \
    '
# needed a specific version of GCC
RUN runuser -l user1 -c 'nix-env -i gcc-wrapper-7.5.0 -f https://github.com/NixOS/nixpkgs/archive/860b56be91fb874d48e23a950815969a7b832fbc.tar.gz'

# bashrc of root (probably don't customize)
RUN printf ' \
    if [ -z "$LOGGED_IN" ]         \n\
    then                           \n\
        export LOGGED_IN="true"    \n\
        cd /project                \n\
        runuser -l user1 -c bash   \n\
        exit                       \n\
    else                           \n\
        source /home/user1/.bashrc \n\
    fi                             \n\
' > /root/.bashrc

# bashrc of user (do customize this)
RUN printf ' \
    alias ll="ls -lA"                                \n\
    alias make="mmake"                               \n\
    . /home/user1/.nix-profile/etc/profile.d/nix.sh  \n\
    flocal ()  {                                     \n\
        args="$@"                                    \n\
        find . -iname "$args"                        \n\
    }                                                \n\
    storage () {                                     \n\
        if [[ "$1" = "." ]]                          \n\
        then                                         \n\
            du -sh "./"*                             \n\
            GLOBIGNORE=".:.." du -sh "./."*          \n\
        else                                         \n\
            if [[ -d "$1" ]]                         \n\
            then                                     \n\
                du -sh "$1"                          \n\
            elif [[ -f "$1" ]]                       \n\
            then                                     \n\
                ls -lh "$1"                          \n\
            else                                     \n\
                echo "total remaining storage:"      \n\
                df -h /                              \n\
            fi                                       \n\
        fi                                           \n\
    }                                                \n\
' > /home/user1/.bashrc

CMD [ "bash" ]