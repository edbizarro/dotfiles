if [ -x /usr/bin/google-chrome-stable ]; then
  export BROWSER=/usr/bin/google-chrome-stable
elif [ -x /usr/bin/google-chrome ]; then
  export BROWSER=/usr/bin/google-chrome
elif [ -x /usr/bin/firefox ]; then
  export BROWSER=/usr/bin/firefox
fi
