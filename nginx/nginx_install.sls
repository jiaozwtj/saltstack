include:
  - nginx.pcre_install
  - nginx.pkg
  - nginx.user

nginx-source-install:
  file.managed:
    - name: {{ pillar['op-path']['soft'] }}/{{ pillar['ngx']['pkgs'] }}
    - source: salt://nginx/files/{{ pillar['ngx']['pkgs'] }}
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - cwd: {{ pillar['op-path']['soft'] }}
    - name: tar zxf {{ pillar['ngx']['pkgs'] }} && cd {{ pillar['ngx']['dir'] }} && ./configure --prefix={{ pillar['ngx']['install'] }} --user=www --group=www --with-http_ssl_module --with-http_stub_status_module --with-pcre={{ pillar['op-path']['soft'] }}/{{ pillar['pcre']['dir'] }} && make && make install && chown -R www:www {{ pillar['ngx']['install'] }}
    - unless: test -d {{ pillar['ngx']['install'] }}
    - require:
      - user: www-user-group
      - cmd: pcre-source-install
