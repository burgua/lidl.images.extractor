# Extracting images from Lidl Online "Angebote"

First fo all install rbenv with ruby 1.9.3

##  Installing software

    brew install graphicsmagick ghostscript poppler phantomjs

For Ubuntu you need to install this:

    sudo apt-get install ruby1.9.3 build-essential libxslt1-dev libxml2-dev libffi-dev poppler-utils poppler-data graphicsmagick

## Installing gems

    sudo gem install bundler
    bundle install --path vendor/bundle

## Starting phantoms-js server

    phantomjs --webdriver=9888

Or using Ubuntu

    ./phantomjs --webdriver=9888


## Extract images

    bundle exec ruby main.rb
