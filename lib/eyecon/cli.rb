# frozen_string_literal: true

require "thor"
require "eyecon"

module Eyecon
  class CLI < Thor
    desc "open SEARCH_WORD", "open search results"
    def open(word)
      Eyecon.search(word)
    end

    desc "cache", "open cached page"
    def cache
      Eyecon.cache
    end
  end
end
