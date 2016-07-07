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
RUN apt-get --yes --force-yes install unzip
chrome_driver_version=$(curl -s http://chromedriver.storage.googleapis.com/LATEST_RELEASE)
chrome_driver_url=http://chromedriver.storage.googleapis.com/${chrome_driver_version}/chromedriver_linux64.zip
RUN rm -rf chromedriver_linux64.zip
RUN wget -q $chrome_driver_url
RUN unzip -o chromedriver_linux64.zip -d /usr/bin
RUN chmod 777 /usr/bin/chromedriver

# chrome driver fix https://github.com/SeleniumHQ/docker-selenium/issues/87
RUN sh -c 'echo "DBUS_SESSION_BUS_ADDRESS=/dev/null" >> /etc/environment'
