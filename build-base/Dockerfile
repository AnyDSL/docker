FROM archlinux:latest

LABEL website="https://anydsl.github.io"

WORKDIR /opt

RUN pacman -Syu --noconfirm \
 && pacman -S --noconfirm base-devel cmake unzip python wget python2 \
 && rm -rf /var/cache/pacman/pkg/*

CMD ["cmake", "--version"]
