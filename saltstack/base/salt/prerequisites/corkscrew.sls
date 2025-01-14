{%if pillar['subtype'] != 'Docker' %}

clone_corkscrew:
  git.latest:
    - name: https://github.com/bryanpkc/corkscrew.git
    - rev: v2.0
    - target: /tmp/corkscrew

install_corkscrew:
  cmd.run:
    - name: autoreconf --install && ./configure && make && make install
    - cwd: /tmp/corkscrew

cleanup_corkscrew:
  file.absent:
    - name: /tmp/corkscrew

create_corkscrew_softlink:
  cmd.run:
    - name: ln -s /usr/local/bin/corkscrew /usr/bin/corkscrew

{% else %}

install_corkscrew:
  pkg.installed:
    - sources:
      - corkscrew: http://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/x86_64/RPMS.classic/corkscrew-2.0-alt1.qa1.x86_64.rpm

{% endif %}
