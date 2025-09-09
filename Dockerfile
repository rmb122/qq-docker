FROM archlinux:latest

RUN echo 'Server = https://mirrors.bfsu.edu.cn/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist

RUN pacman --noconfirm -Sy archlinux-keyring && \
    pacman-key --init && \
    pacman-key --populate archlinux && \
    pacman -Su --noconfirm && \
    pacman -S --noconfirm debugedit vim xorg adobe-source-han-sans-cn-fonts noto-fonts-emoji git fakeroot binutils nss libxss gtk3 alsa-lib pulseaudio gjs libappindicator-gtk3 fcitx5-gtk xdg-utils libvips openjpeg2 openslide && \
    pacman -Scc --noconfirm

ARG TIMEZONE
ARG USER_ID

RUN useradd -m user -u ${USER_ID}
RUN ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

USER user
RUN mkdir /home/user/.config/
COPY makepkg.conf /home/user/.config/pacman/makepkg.conf

RUN cd && \
    git clone https://aur.archlinux.org/linuxqq.git && \
    cd linuxqq && \
    makepkg && \
    mv ~/linuxqq/linuxqq-*.pkg.tar ~/linuxqq.pkg.tar && \
    rm -r ~/linuxqq/

USER root
RUN pacman --noconfirm -U /home/user/linuxqq.pkg.tar

USER user
RUN mkdir -p ~/.config/QQ && mkdir -p ~/.config/shared/

