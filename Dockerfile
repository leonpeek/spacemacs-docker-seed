FROM crest/spacemacs

# Has to be secified before `RUN install-deps`
ENV UNAME="spacemacser"
ENV UID="1000"

# Ubuntu Xenial
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y  software-properties-common \
    && add-apt-repository ppa:webupd8team/java -y \
    && apt-get update \
    && echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && apt-get install -y oracle-java8-installer \
    && apt-get install dstat build-essential curl x11-xserver-utils libpng-dev zlib1g-dev libpoppler-glib-dev libpoppler-private-dev imagemagick \
    && rm -rf /var/lib/apt/lists/*

COPY .spacemacs "${UHOME}/.spacemacs"
COPY private "${UHOME}/.emacs.d/private"

VOLUME ${UHOME}

# Install layers dependencies and initialize the user
RUN install-deps

