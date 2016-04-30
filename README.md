# Extracting images from Lidl Online "Angebote"

First of all install ruby.

Then install additional software (OSX)

    brew install graphicsmagick ghostscript poppler phantomjs

For Ubuntu you need to install this:

    sudo apt-get install build-essential libxslt1-dev libxml2-dev libffi-dev poppler-utils poppler-data graphicsmagick

## Installing gems

    sudo gem install bundler
    bundle install --path vendor/bundle

## Starting phantoms-js server

    phantomjs --webdriver=9888

## Extract images

    bundle exec ruby main.rb
