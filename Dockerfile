FROM node:4

RUN apt-get update && apt-get --yes --force-yes install screen


# chrome dependencies
RUN apt-get --yes --force-yes install libxss1
RUN apt-get --yes --force-yes install libappindicator1
RUN apt-get --yes --force-yes install libindicator7
RUN apt-get --yes --force-yes install fonts-liberation

# chrome
RUN rm -rf google-chrome*.deb
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome*.deb

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
