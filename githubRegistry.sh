## grep -roP "(docker.pkg.github.com)/[-a-zA-Z0-9_\.\/]+"

grep -roP "(ghcr.io)/[-a-zA-Z0-9_\.\/]+" $1
grep -roP "(docker.pkg.github.com)/[-a-zA-Z0-9_\.\/]+" $1
grep -roP "(rubygems.pkg.github.com)/[-a-zA-Z0-9_\.\/]+" $1
grep -roP "(npm.pkg.github.com)/[-a-zA-Z0-9_\.\/]+" $1
grep -roP "(maven.pkg.github.com)/[-a-zA-Z0-9_\.\/]+" $1
grep -roP "(nuget.pkg.github.com)/[-a-zA-Z0-9_\.\/]+" $1
