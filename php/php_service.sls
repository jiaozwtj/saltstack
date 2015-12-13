php-service:
  file.managed:
    - name: /etc/init.d/php-fpm
    - source: salt://php/files/php-fpm
    - template: jinja
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: chkconfig --add php-fpm
    - unless: chkconfig --list | grep php-fpm
    - require:
      - file: php-service
