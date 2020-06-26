FROM crest/spacemacs

# Has to be secified before `RUN install-deps`
ENV UNAME="spacemacser"
ENV UID="1000"

# Ubuntu Xenial
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install openjdk-8-jdk openjdk-8-jre \
    && apt-get install dstat build-essential curl x11-xserver-utils libpng-dev zlib1g-dev libpoppler-glib-dev libpoppler-private-dev imagemagick texlive-latex-extra dvipng \
    && rm -rf /var/lib/apt/lists/*

# Install anaconda
RUN wget --no-check-certificate https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-2020.02-Linux-x86_64.sh \
    && bash Anaconda3-2020.02-Linux-x86_64.sh -b -u -p /home/work/anaconda3

COPY .spacemacs "${UHOME}/.spacemacs"
COPY private "${UHOME}/.emacs.d/private"

RUN cd "${UHOME}/.emacs.d/private/local" && \
    git clone https://github.com/Potpourri/spacemacs-emms.git

VOLUME ${UHOME}

# Install layers dependencies and initialize the user
RUN install-deps

