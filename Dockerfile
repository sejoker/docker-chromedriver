FROM node:4

RUN apt-get update && apt-get --yes --force-yes install screen
RUN apt-get --yes --force-yes install unzip

# chrome
RUN apt-get update && \
    apt-get -y install libglib2.0 libnss3-dev libxtst6 libxss1 libgconf-2-4 libfontconfig1 libpango1.0-0 libxcursor1 libxcomposite1 libasound2 libxdamage1 libxrandr2 libcups2 libgtk2.0-0 wget unzip libappindicator1 libcurl3 xdg-utils libexif12 xvfb fonts-noto fonts-liberation && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb && \
    apt-get -f -y install && \
    sed -i 's/"$@"/"$@" --no-sandbox/' /opt/google/chrome/google-chrome && \
    rm -rf /var/lib/apt/lists/* google-chrome-stable_current_amd64.deb

# chrome driver
RUN wget -O /tmp/chromedriver-version http://chromedriver.storage.googleapis.com/LATEST_RELEASE && \
    wget http://chromedriver.storage.googleapis.com/`cat /tmp/chromedriver-version`/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip -d /usr/bin && \
    rm /tmp/chromedriver-version chromedriver_linux64.zip && \
    chmod 777 /usr/bin/chromedriver

# chrome driver fix https://github.com/SeleniumHQ/docker-selenium/issues/87
RUN sh -c 'echo "DBUS_SESSION_BUS_ADDRESS=/dev/null" >> /etc/environment'
