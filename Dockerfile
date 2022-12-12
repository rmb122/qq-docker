FROM archlinux:latest

RUN echo 'Server = https://mirrors.bfsu.edu.cn/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist

RUN pacman --noconfirm -Sy archlinux-keyring && \
    pacman-key --init && \
    pacman-key --populate archlinux && \
    pacman -Su --noconfirm && \
    pacman -S --noconfirm vim xorg adobe-source-han-sans-cn-fonts git fakeroot binutils nss libxss gtk3 alsa-lib pulseaudio gjs libappindicator-gtk3 fcitx5-gtk xdg-utils && \
    pacman -Scc --noconfirm

ARG USER_ID
ARG TIMEZONE

RUN env && useradd -m user -u ${USER_ID}
RUN ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

USER user
RUN cd && \
    git clone https://aur.archlinux.org/linuxqq-new.git && \
    cd linuxqq-new && \
    makepkg

USER root
RUN pacman --noconfirm -U /home/user/linuxqq-new/linuxqq-new-*.pkg.tar.zst

USER user
RUN rm -rf ~/linuxqq-new && mkdir -p ~/.config/QQ
