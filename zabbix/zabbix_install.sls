zabbix_source:
  file.managed:
    - name: {{ pillar['op-path']['soft'] }}/{{ pillar['zbx']['pkgs'] }}
    - unless: test -e {{ pillar['op-path']['soft'] }}/{{ pillar['zbx']['pkgs'] }}
    - source: salt://zabbix/files/{{ pillar['zbx']['pkgs'] }}

extract_zabbix:
  cmd.run:
    - cwd: {{ pillar['op-path']['soft'] }}
    - name: tar xvf {{ pillar['zbx']['pkgs'] }}
    - unless: test -d {{ pillar['op-path']['soft'] }}/{{ pillar['zbx']['dir'] }}
    - require:
      - file: zabbix_source

zabbix_user:
  user.present:
    - name: zabbix
    - uid: 501
    - createhome: False
    - gid_from_name: True
    - shell: /sbin/nologin

zabbix_compile:
    cmd.run:
      - cwd: {{ pillar['op-path']['soft'] }}/{{ pillar['zbx']['dir'] }}
      - name: ./configure --prefix={{ pillar['zbx']['install'] }} --enable-agent && make -j4 && make install
      - require:
        - cmd: extract_zabbix
      - unless: test -d {{ pillar['zbx']['install'] }}
