# frozen_string_literal: true

require "nokogiri"
require "open-uri"
require "erb"
require "rbconfig"

module Eyecon
  class << self
    CACHE_FILE = File.expand_path("../output/cache.html", __dir__)
    INDEX_FILE = File.expand_path("../output/index.html", __dir__)
    TEMPLATE_FILE = File.expand_path("template.html", __dir__)

    def search(word)
      doc = Nokogiri::HTML(URI.parse("https://play.google.com/store/search?q=#{word}&c=apps").open)
      File.write(CACHE_FILE, doc)
      openfile(doc)
    end

    def cache
      doc = Nokogiri::HTML(File.open(CACHE_FILE))
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
      template = ERB.new(File.read(TEMPLATE_FILE))
      t = template.result_with_hash(content: content)
      File.write(INDEX_FILE, t)
    end

    def openfile(doc)
      scrape(doc).then { |a| render(a) }
      os = RbConfig::CONFIG["host_os"]
      exec("open", INDEX_FILE) if os.include?("darwin")
    end
  end
end
