/usr/local/bin/asennus:
  file.managed:
  - source: salt://asennus/asennus
  - mode: "0755"
