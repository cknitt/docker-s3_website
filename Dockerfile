FROM ruby:2.5-slim
MAINTAINER Christoph Knittel <christoph@knittel.cc>

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-8-jre-headless wget \
  && rm -rf /var/lib/apt/lists/*

# Install s3_website
RUN gem install s3_website -v 3.4.0

# Pre-load Java package
RUN s3_website install

# Symlink to /usr/local/bin
RUN ln -s /usr/local/bundle/bin/s3_website /usr/local/bin

# Use /website as the work directory.
# (No need to create a volume, just mount your local work directory at this path.)
WORKDIR /website

ENTRYPOINT ["s3_website"]
CMD ["--help"]
