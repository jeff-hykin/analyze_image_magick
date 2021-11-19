FROM ubuntu:18.04

# 
# Image Magick dependencies
# 
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y xz-utils zlibc cmake libkrb5-dev libconfig-dev sudo tar zip curl libc6-dev make git make gcc libheif1 libwebp6 libheif-dev pkg-config autoconf curl g++ \
    # libaom \
    yasm cmake \
    # libheif \
    libde265-0 libde265-dev libjpeg62 libjpeg62 x265 libx265-dev libtool \
    # IM \
    libpng16-16 libpng-dev libwebp6 libjpeg62 libjpeg62 libgomp1 ghostscript libxml2-dev libxml2-utils libtiff-dev libfontconfig1-dev libfreetype6-dev 


RUN printf ' \
    alias ll="ls -lA"                                \n\
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
' > /root/.bashrc

CMD [ "bash" ]