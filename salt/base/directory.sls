op-soft:
  cmd.run:
    - name: mkdir -p {{ pillar['op-path']['soft'] }}
op-script:
  cmd.run:
    - name: mkdir -p {{ pillar['op-path']['script'] }}
op-logs:
  cmd.run:
    - name: mkdir -p {{ pillar['op-path']['logs'] }}
