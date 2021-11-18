FROM ubuntu:18.04

# Update Ubuntu Software repository
RUN apt update \
    && apt-get install -y zsh xz-utils tar zip curl \
    && apt-get clean \
    && useradd --create-home "user1" --password "password" --groups sudo \
    && echo "p" > passwd "user1" \
    && printf '#!/usr/bin/env zsh\n"$@"' > /usr/local/sbin/sudo \
    && chmod 777 /usr/local/sbin/sudo \
    && mkdir -m 0755 /nix && chown user1 /nix \
    && runuser -l user1 -c 'curl -L https://nixos.org/nix/install | sh -s' 

# install nix packages
RUN runuser -l user1 -c '/home/user1/.nix-profile/bin/nix-env -i gcc libconfig cmake libkrb5 ncurses'

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
    . /home/user1/.nix-profile/etc/profile.d/nix.sh  \n\
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