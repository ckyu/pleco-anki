require 'nokogiri'
require 'optparse'
require './lib/card.rb'

options = {}
options[:limit] = 3

OptionParser.new do |opts|
  opts.banner = "Usage: ruby convert.rb [options]"

  opts.on("-iFILENAME", "--input=FILENAME", "Exported Pleco XML") do |i|
    options[:input] = i
  end

  opts.on("-oFILENAME", "--output=FILENAME", "Anki text file") do |o|
    options[:output] = o
    options[:type] = o[-3..-1]
  end

  # opts.on("-lLIMIT", "--limit=LIMIT", "Max number of definitions included") do |lim|
  #   options[:limit] = lim
  # end

end.parse!

doc = Nokogiri::XML(File.open(options[:input]))

cards = doc.xpath("//card").map do |card_raw| 
   PlecoAnki::Card.new(card_raw.to_s)
end

f = File.open(options[:output], 'w')

cards.shuffle.each do |card|
  hash = {
    simplified: "#{card.word_sc}",
    traditional: "#{card.word_tc}",
    pinyin: "#{card.pron}",
    zhuyin: "#{card.pron_zh}",
    defn: "#{card.defn[0..options[:limit]].join("<br>")}"

  }
  f.write("%{simplified}\t%{traditional}\t%{pinyin}\t%{zhuyin}\t%{defn}\n" % hash)
end

f.close