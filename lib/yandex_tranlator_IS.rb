require "yandex_tranlator_IS/version"
require 'net/http'
require 'json'
require 'uri'

module YandexTranlatorIS
  class Error < StandardError; end

  class YandexTr
    attr_accessor :api_key,:default_lang

    def self.start
      @api_key
    end

    def self.apikey(api_key)
      @api_key = api_key
    end

    def self.default_lang(lang)
      @default_lang = lang
    end

    def self.translate(packet={})
      text = packet[:text]||' '
      lang = packet[:lang]||@default_lang||'ru'
      uri=URI.parse("https://translate.yandex.net/api/v1.5/tr.json/translate?key=#{@api_key}&text=#{URI.encode(text)}&lang=#{lang}")
      result = Net::HTTP.get(uri) 
      JSON.parse(result)['text'] 
    end

    def self.languages 
      uri = URI.parse("https://translate.yandex.net/api/v1.5/tr.json/getLangs?key=#{@api_key}&ui=en") 
      result = Net::HTTP.get(uri) 
      JSON.parse(result)['langs'] 
    end 
  end
end
