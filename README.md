# Адаптация Entware-ng для ZyXEL Keenetic

В последних прошивках NDM есть возможность запуска сторонних сервисов. Здесь собраны изменения и пакеты, позволяющие [использовать Entware-ng на кинетиках](http://forums.zyxmon.org/viewtopic.php?f=5&t=5246).

В прошивке нет shell'а и ряда других файлов, привычных в linux-окружении. Изменения в основном сводятся к тому, чтобы "отучить" пакеты от использования файлов в каталогах `/etc`, `/bin` и прочих за пределами папки `/opt`.


## Сборка пакетов

Для сборки модифицированных пакетов [разверните](https://github.com/Entware-ng/Entware-ng/wiki/Compile-packages-from-sources) билдрут Entware-ng:
```
git clone https://github.com/Entware-ng/Entware-ng.git
cd Entware-ng
cp ./configs/mipselsf.config .config
```
Допишите в файл `feeds.conf` строчку
```
src-git keenopt4entware https://github.com/ryzhovau/keenopt4entware.git
```
Обновите подключенный фид и установите из него все пакеты:
```
./scripts/feeds update keenopt4entware
./scripts/feeds install -a -p keenopt4entware
```
Скопируйте патч для uClibc и .config для билдрута:
```
cp feeds/keenopt4entware/toolchain/uClibc/patches/999-keenetic.patch toolchain/uClibc/patches/
cp feeds/keenopt4entware/.config .config
```
Зайдите в menuconfig:
```
make menuconfig
```
Отметьте для сборки следующие пакеты и сохраните изменения при выходом:
```
busybox-zyx
libc
libndm
ndmq
proftpd-zyx
openvpn-zyx
samba36-zyx-server
zyx-opt
```
Соберите тулчейн и пакеты:
```
make
```
Собранные пакеты будут находиться в папке `bin`. Именно в таком виде они перенесены в [отдельный репозиторий](http://ndm.zyxmon.org/binaries/keenetic/) для кинетиков.
