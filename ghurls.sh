grep -r -ohP '(http.)?://(cdn.jsdelivr.net)\b([-a-zA-Z0-9@:%_\+.~#?&\/=]*)' $1 | sort | uniq 

grep -r -ohP '(http.)?://(raw.githubusercontent.com)\b([-a-zA-Z0-9@:%_\+.~#?&\/=]*)' $1 | sort | uniq

grep -r -ohP '(http.)?://(raw.github.com)\b([-a-zA-Z0-9@:%_\+.~#?&\/=]*)' $1 | sort | uniq

grep -r -ohP '(http.)?://(codecov.io)\b([-a-zA-Z0-9@:%_\+.~#?&\/=]*)' $1 | sort | uniq

grep -r -ohP '(http.)?://(media.githubusercontent.com)\b([-a-zA-Z0-9@:%_\+.~#?&\/=]*)' $1 | sort | uniq

