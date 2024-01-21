grep -roh '(http.)?://(cdn.jsdelivr.net)\b([-a-zA-Z0-9@:%_\+.~#?&\/=]*)' $1 | sort | uniq 

grep -roh '(http.)?://(raw.githubusercontent.com)\b([-a-zA-Z0-9@:%_\+.~#?&\/=]*)' $1 | sort | uniq

grep -roh '(http.)?://(raw.github.com)\b([-a-zA-Z0-9@:%_\+.~#?&\/=]*)' $1 | sort | uniq

grep -roh '(http.)?://(codecov.io)\b([-a-zA-Z0-9@:%_\+.~#?&\/=]*)' $1 | sort | uniq

grep -roh '(http.)?://(media.githubusercontent.com)\b([-a-zA-Z0-9@:%_\+.~#?&\/=]*)' $1 | sort | uniq

