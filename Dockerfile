FROM ruby:2.3.1

RUN curl -sS http://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -


RUN apt-get update && apt-get install -y qt4-dev-tools libqt4-dev libqtcore4 libqtgui4 libqtwebkit-dev \
            libpq-dev git curl yarn

RUN mkdir /home/swips_pdfs_printer
WORKDIR /home/swips_pdfs_printer

ENV BUNDLE_PATH /swips_pdfs_printer_box

RUN gem update --system
RUN gem install bundler

COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock

RUN bundle install -j 20
