require 'nokogiri'
require './lib/py2zy.rb'

module PlecoAnki
  class Card
    attr_accessor :word_sc
    attr_accessor :word_tc
    attr_accessor :pron
    attr_accessor :pron_zh
    attr_accessor :pron_can
    attr_accessor :defn

    @@pinyinConverter = Pinyin2Zhuyin.new

    def initialize(card_node)
      card_node     = Nokogiri::XML(card_node)
      self.word_sc  = card_node.xpath("//headword[@charset='sc']").text
      self.word_tc  = card_node.xpath("//headword[@charset='tc']").text
      self.pron     = card_node.xpath("//pron").text
      self.pron_zh  = @@pinyinConverter.convert(self.pron)

      defn_regexp = /\d\s/
      example_sentence_regexp = /[^[[:lower:]][[:upper:]][[:space:]]()-;!\']/

      self.defn = card_node.xpath("//defn").text
        .gsub("\n","; ")
        .split(defn_regexp)
        .map    { |rar| index = rar.index(example_sentence_regexp) ? rar[0...rar.index(example_sentence_regexp)].chomp(' ') : rar }
        .reject { |d| d == "" }

    end

    def to_s
      "#{self.word_sc}\t(#{self.word_tc})\n\t#{self.pron}\n\t#{self.defn}\n"
    end
  end
end