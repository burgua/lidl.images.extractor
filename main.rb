#!/usr/bin/env ruby

# encoding: UTF-8

# names of folders
@folder_pdfs = 'pdfs'
@folder_images = 'images'

# check||create working folders
Dir.mkdir(@folder_pdfs) unless File.exists?(@folder_pdfs)
Dir.mkdir(@folder_images) unless File.exists?(@folder_images)

fetch_date = Time.now.to_s
puts 'Started at: ' + fetch_date

# create web agent with javascript support
require 'selenium-webdriver'
#driver = Selenium::WebDriver.for :firefox
driver = Selenium::WebDriver.for(:remote, :url => "http://localhost:9888")
driver.navigate.to "http://www.lidl.de/de/online-prospekt/s1002"

# prepare agent for saving pdfs
require 'mechanize'
@a = Mechanize.new

# function for saving pdfs and extracting images from them
def extraxt_images_from_pdf(pdf_link, pdf_name)

  # get data from pdf file_name
  resp = @a.get pdf_link

  # write to file_name

  File.open("#{@folder_pdfs}/#{pdf_name}.pdf", 'w') do
  |f| f.write(resp.body)
  end

  # delete and create folder for saving images
  # TODO: backup old
  require 'fileutils'
  FileUtils.rm_rf "#{@folder_images}/#{pdf_name}"
  FileUtils.mkdir_p "#{@folder_images}/#{pdf_name}"

  # extract images
  require 'docsplit'
  Docsplit.extract_images "#{@folder_pdfs}/#{pdf_name}.pdf",
      :size => '500x',
      :format => :png,
      :output => "#{@folder_images}/#{pdf_name}"

end

# get links for pdf
driver.find_elements(:class, 'secondary').each do |pdf|

  pdf_link = pdf.attribute('href')
  pdf_name = pdf.attribute('id')

  # if link is not empty
  if pdf_link != "javascript:void(0);"
    extraxt_images_from_pdf(pdf_link, pdf_name)
    puts "Extracted images from #{pdf_name}"
  end

end

puts 'Finished at: ' + Time.now.to_s
