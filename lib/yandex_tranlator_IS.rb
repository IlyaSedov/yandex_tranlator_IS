require "yandex_tranlator_IS/version"
require 'net/http'
require 'json'
require 'uri'

module YandexTranlatorIS
  class YandexTr
    class << self 
      def start
        @api_key
      end

      def apikey(api_key)
        @api_key = api_key
      end

      def default_lang(lang)
        @default_lang = lang
      end

      def default_languages
        @default_lang
      end

      def translate(text, packet = {})
        lang = packet[:lang] || @default_lang || 'ru'
        uri = URI.parse("https://translate.yandex.net/api/v1.5/tr.json/translate?key=#{@api_key}&text=#{URI.encode(text)}&lang=#{lang}")
        result = Net::HTTP.get(uri) 
        JSON.parse(result)['text'] 
      end

      def languages 
        uri = URI.parse("https://translate.yandex.net/api/v1.5/tr.json/getLangs?key=#{@api_key}&ui=en") 
        result = Net::HTTP.get(uri) 
        JSON.parse(result)['langs'] 
      end 
    end
  end
end
