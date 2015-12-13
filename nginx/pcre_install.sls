pcre-source-install:
  file.managed:
    - name: {{ pillar['op-path']['soft'] }}/{{ pillar['pcre']['pkgs'] }}
    - source: salt://nginx/files/{{ pillar['pcre']['pkgs'] }}
    - user: root
    - group: root
    - mod: 755
  cmd.run:
    - cwd: {{ pillar['op-path']['soft'] }}
    - name: tar zxf {{ pillar['pcre']['pkgs'] }} && cd {{ pillar['pcre']['dir'] }} && ./configure --prefix={{ pillar['pcre']['install'] }} && make && make install
    - unless: test -d {{ pillar['pcre']['pkgs'] }}
    - require:
      - file: pcre-source-install
