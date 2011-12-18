# -*- coding: utf-8 -*-
# YahooApiにリクエストするためopenメソッドを使います
require "open-uri"
# YahooApiからXML形式でレスポンスをもらうので解析します
require "rexml/document"  

# 実はRubyでmodule作るの初めてだったりします
module YahooApi
  # http://developer.yahoo.co.jp/ からYahooApiを利用するためのAPPID取得して下さい
  # moduleに設定ファイルを置いてしまうのは本当はあまり良くないかもしれません...
  APPID = "BEhzvxqxg66d5mJOJs01piXLVCLFZBFjF.D.RPahjYl35GT0ILsK83rrQJf94Y_b.bIGfg--"

  # キーフレーズ抽出API
  # http://developer.yahoo.co.jp/webapi/jlp/keyphrase/v1/extract.html
  # 基本的に YahooApi::Keyphrase.new.get(text) という感じの利用を想定しています
  class Keyphrase
    
    # このメソッドがリクエストとパースを呼び出します.
    def get(text)
      xml_text = request(text)
      return parse(xml_text)
    end

    # YahooAPIにリクエスト、XMLを取得して文字列で返します
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

    # xmlを解析して配列を返します
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
end
