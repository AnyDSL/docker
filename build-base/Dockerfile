FROM base/archlinux:latest

LABEL website="https://anydsl.github.io"

WORKDIR /opt

RUN pacman -Syu --noconfirm \
 && pacman -S --noconfirm base-devel cmake unzip python wget python2

CMD ["cmake", "--version"]
