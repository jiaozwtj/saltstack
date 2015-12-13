include:
  - nginx.nginx_install
  - nginx.user

nginx-init:
  file.managed:
    - name: /etc/init.d/nginx
    - source: salt://nginx/files/nginx
    - template: jinja
    - mode: 755
    - user: root
    - group: root
  cmd.run:
    - name: chkconfig --add nginx
    - unless: chkconfig --list | grep nginx
    - require:
      - file: nginx-init

{{ pillar['ngx']['install'] }}/conf/nginx.conf:
  file.managed:
    - source: salt://nginx/files/nginx.conf
    - template: jinja
    - user: www
    - group: www
    - mode: 644

nginx-vhost:
  file.directory:
    - name: {{ pillar['ngx']['install'] }}/conf/vhost
    - require:
      - cmd: nginx-source-install

ngx-log:
  file.directory:
    - name:  {{ pillar['ngx']['log'] }}
    - user: www
    - group: www
    - mode: 644
