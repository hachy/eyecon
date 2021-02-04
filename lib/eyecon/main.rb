# frozen_string_literal: true

require "nokogiri"
require "open-uri"
require "erb"
require "rbconfig"

module Eyecon
  class << self
    def search(word)
      doc = Nokogiri::HTML(URI.parse("https://play.google.com/store/search?q=#{word}&c=apps").open)
      File.write("./lib/output/cache.html", doc)
      openfile(doc)
    end

    def cache
      doc = Nokogiri::HTML(File.open("./lib/output/cache.html"))
      openfile(doc)
    rescue StandardError => e
      puts e.message
    end

    def scrape(doc)
      res = []
      doc.css("div .Vpfmgd").each do |link|
        a = []
        a << link.css("img")[0]["data-src"]
        a << link.css("a div")[0].text
        a << link.css("a div")[1].text
        res << a
      end
      res
    end

    def render(content)
      template = ERB.new(File.read("./lib/eyecon/template.html"))
      t = template.result_with_hash(content: content)
      File.write("./lib/output/index.html", t)
    end

    def openfile(doc)
      scrape(doc).then { |a| render(a) }
      os = RbConfig::CONFIG["host_os"]
      exec("open", "./lib/output/index.html") if os.include?("darwin")
    end
  end
end
