zabbix_log_dir:
  cmd.run:
    - names:
      - mkdir {{ pillar['zbx']['log'] }}
    - require:
      - cmd: zabbix_compile
    - unless: test -d {{ pillar['zbx']['log'] }}

zabbix_conf:
  file.managed:
    - name: {{ pillar['zbx']['conf'] }}
    - source: salt://zabbix/files/zabbix_agentd.conf
    - template: jinja

zabbix_service:
  file.managed:
    - name: /etc/init.d/zabbix_agentd
    - user: root
    - mode: 755
    - source: salt://zabbix/files/zabbix_agentd
    - template: jinja
  cmd.run:
    - names:
      - /sbin/chkconfig zabbix_agentd on
    - unless: /sbin/chkconfig --list zabbix_agentd
  service.running:
    - name: zabbix_agentd
    - enable: True
    - watch:
      - file: {{ pillar['zbx']['conf'] }} 
