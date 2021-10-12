{% if grains['os_family'] == 'RedHat' %}
install_openssl_devel:
  pkg.installed:
    - pkgs:
      - openssl-devel
{% endif %}

{% if grains['os'] | upper == 'SUSE' %}
update_python_pip2:
  cmd.run:
    - name: pip2 install --upgrade --index=https://pypi.python.org/simple/ pip==9.0.3
    - onlyif: pip2 -V

update_python_pip3:
  cmd.run:
    - name: pip3 install --upgrade --index=https://pypi.python.org/simple/ pip==9.0.3
    - onlyif: pip3 -V

{% elif grains['os'] != 'Amazon' %}
update_python_pip2:
  cmd.run:
    - name: pip2 install --upgrade --index=https://pypi.python.org/simple/ pip==8.1.2
    - onlyif: pip2 -V

update_python_pip3:
  cmd.run:
    - name: pip3 install --upgrade --index=https://pypi.python.org/simple/ pip==8.1.2
    - onlyif: pip3 -V

{% endif %}

install_pyyaml:
  cmd.run:
    - name: python3 -m pip install PyYAML --ignore-installed
    - unless: python3 -m pip list | grep -E 'PyYAML'

install_jq:
  file.managed:
    - name: /usr/bin/jq
    - source: https://stedolan.github.io/jq/download/linux64/jq
    - source_hash: md5=89c7bb6138fa6a5c989aca6b71586acc
    - skip_verify: True
    - mode: 755
