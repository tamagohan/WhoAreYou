require "open-uri"
require "rexml/document"  

module YahooApi
  # TODO APPID should be written in yml file
  APPID = "BEhzvxqxg66d5mJOJs01piXLVCLFZBFjF.D.RPahjYl35GT0ILsK83rrQJf94Y_b.bIGfg--"

  class Keyphrase
    def get(text)
      xml_text = request(text)
      return parse(xml_text)
    end

    def request(text)
      result  = ""
      text    = URI.encode text
      url     = "http://jlp.yahooapis.jp/KeyphraseService/V1/extract?appid=#{APPID}&sentence=#{text}"

      open(url) do |fp|
        fp.each do |line|
          result += line
        end
      end
      return result
    end

    def parse(xml_text)
      keyphrases = []
      xml = REXML::Document.new xml_text
      xml.elements.each("ResultSet/Result") do |result|
        keyphrases << {
          :text  => result.elements["Keyphrase"].text,
          :score => result.elements["Score"].text.to_i
        }
      end
      return keyphrases
    end
  end

  # get related word
  class Webunit
    def get(text)
      xml_text = request(text)
      return parse(xml_text)
    end

    def request(text)
      result  = ""
      text    = URI.encode text
      url     = "http://search.yahooapis.jp/AssistSearchService/V1/webunitSearch?appid=#{APPID}&query=#{text}"

      open(url) do |fp|
        fp.each do |line|
          result += line
        end
      end
      return result
    end

    def parse(xml_text)
      xml = REXML::Document.new xml_text
      xml.elements["/ResultSet/Result"].text unless xml.elements["/ResultSet/Result"].nil?
    end
  end
end
