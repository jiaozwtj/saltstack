pkg-source-install:
  file.managed:
    - name: {{ pillar['op-path']['soft'] }}/{{ pillar['php']['pkgs'] }}
    - source: salt://php/files/{{ pillar['php']['pkgs'] }}
    - user: www
    - group: www
    - mode: 755
  cmd.run:
    - cwd: {{ pillar['op-path']['soft'] }}
    - name: tar zxf {{ pillar['php']['pkgs'] }} && cd {{ pillar['php']['dir'] }} && ./configure --prefix={{ pillar['php']['install'] }} --with-config-file-path={{ pillar['php']['conf'] }} --with-pdo-mysql=mysqlnd --with-mysqli=mysqlnd --with-mysql=mysqlnd --with-jpeg-dir --with-png-dir --with-zlib --enable-xml --with-libxml-dir --with-curl --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --enable-mbregex --with-openssl --enable-mbstring --with-gd --enable-gd-native-ttf --with-freetype-dir=/usr/lib64 --with-gettext=/usr/lib64 --enable-sockets --with-xmlrpc --enable-zip --enable-soap --disable-debug --enable-zip --enable-fpm --with-fpm-user=www --with-fpm-group=www && make && make install
    - unless: test -d {{ pillar['php']['install'] }}
php-ini:
  file.managed:
    - name: {{ pillar['php']['conf'] }}/php.ini
    - source: salt://php/files/php.ini
    - template: jinja
    - user: www
    - group: www
    - mode: 644

php-fpm:
  file.managed:
    - name: {{ pillar['php']['conf'] }}/php-fpm.conf
    - source: salt://php/files/php-fpm.conf
    - template: jinja
    - user: www
    - group: www
    - mode: 644

php-log:
  file.directory:
    - name:  {{ pillar['php']['log'] }}
    - user: www
    - group: www
    - mode: 644
