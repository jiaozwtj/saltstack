plugin-redis:
  file.managed:
    - name: {{ pillar['op-path']['soft']}}/{{ pillar['php-redis']['pkgs'] }}
    - source: salt://php/files/{{ pillar['php-redis']['pkgs'] }}
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - cwd: {{ pillar['op-path']['soft']}}
    - name: tar zxf {{ pillar['php-redis']['pkgs'] }} && cd {{ pillar['php-redis']['dir'] }} && {{ pillar['php']['install'] }}/bin/phpize && ./configure --with-php-config={{ pillar['php']['install'] }}/bin/php-config && make && make install
    - unless: test -f {{ pillar['php']['install'] }}/lib/php/extensions/no-debug-non-zts-20100525/redis.so
   
