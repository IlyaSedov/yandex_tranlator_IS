require "yandex_tranlator_IS/version"

module YandexTranlatorIS
  class Error < StandardError; end
  class YandexTr
    attr_accessor :api_key

    def self.start
      @api_key
    end

    def self.apikey(api_key)
      @api_key=api_key
    end

    def self.translate(packet={})
      text = packet[:text]||' '
      lang = packet[:lang]||'ru'
      # url=@api_url<<"key=#{@api_key}&text=#{text}&lang=#{lang}"
      uri=URI("https://translate.yandex.net/api/v1.5/tr.json/translate?key=#{@api_key}&text=#{URI.encode(text)}&lang=#{lang}")
      result = Net::HTTP.get(uri) 
      JSON.parse(result)['text'] 
    end

    def languages 
      uri = URI('https://translate.yandex.net/api/v1.5/tr.json/getLangs?' \ 
      "key=#{@api_key}&ui=en") 
      result = Net::HTTP.get(uri) 
      JSON.parse(result)['langs'] 
      end 
  end
end
