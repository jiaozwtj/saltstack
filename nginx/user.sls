www-user-group:
    user.present:
    - name: www
    - uid: 1000
    - createhome: False
    - gid_from_name: True
    - shell: /sbin/nologin
