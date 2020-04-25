FROM crest/spacemacs

# Has to be secified before `RUN install-deps`
ENV UNAME="spacemacser"
ENV UID="1000"

# Ubuntu Xenial
RUN apt-get update \
    && apt-get install dstat build-essential curl \
    libpng-dev zlib1g-dev libpoppler-glib-dev libpoppler-private-dev imagemagick \
    && rm -rf /var/lib/apt/lists/*

COPY .spacemacs "${UHOME}/.spacemacs"
COPY private "${UHOME}/.emacs.d/private"

RUN cd "${UHOME}/.emacs.d/private/local" && \
    git clone https://github.com/Potpourri/spacemacs-emms.git

# Install layers dependencies and initialize the user
RUN install-deps

