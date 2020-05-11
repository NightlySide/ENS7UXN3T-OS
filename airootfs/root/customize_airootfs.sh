#!/bin/bash

set -e -u

# Locales et clavier en francais
#sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
sed -i 's/#\(fr_FR\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

# Fuseau horaire sur la france
#ln -sf /usr/share/zoneinfo/UTC /etc/localtime
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime

# Création de l'utilisateur root
usermod -s /usr/bin/zsh root
# Création de l'utilisateur en live
useradd -m -p "" -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /bin/zsh liveuser
cp -aT /etc/skel/ /root/
#chmod 700 /root
chown -R liveuser:users /home/liveuser

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

systemctl enable pacman-init.service choose-mirror.service
systemctl set-default multi-user.target
