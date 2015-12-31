module PlecoAnki
  class Pinyin2Zhuyin

    # https://gist.github.com/ttempe/4010474
    # early replacements
    @@replacements = {
      yu:"u:",
      ü:"u:",
      v:"u:",
      yi:"i",
      you:"ㄧㄡ",
      y:"i",
      wu:"u",
      wong:"ㄨㄥ",
      w:"u",
    }

    @@table = {
      # special cases
      ju:  "ㄐㄩ",
      qu:  "ㄑㄩ",
      # xu: "ㄒㄩ",
      # xue: "ㄒㄩㄝ",
      zhi: "ㄓ",
      chi: "ㄔ",
      shi:"ㄕ",
      ri:  "ㄖ",
      zi:  "ㄗ",
      ci:  "ㄘ",
      si: "ㄙ",
      r:  "ㄦ",


      # initials
      b:   "ㄅ",
      p:   "ㄆ",
      m:  "ㄇ",
      f:   "ㄈ",
      d:   "ㄉ",
      t:   "ㄊ",
      n:  "ㄋ",
      l:   "ㄌ",
      g:   "ㄍ",
      k:   "ㄎ",
      h:  "ㄏ",
      j:   "ㄐ",
      q:   "ㄑ",
      x:  "ㄒ",
      zh:  "ㄓ",
      ch:  "ㄔ",
      sh: "ㄕ",
      r:   "ㄖ",
      z:   "ㄗ",
      c:   "ㄘ",
      s:  "ㄙ",

      # finals
      i:   "ㄧ",
      u:   "ㄨ",
      "u:"=> "ㄩ",
      a:   "ㄚ",
      o:   "ㄛ",
      e:  "ㄜ",
      ê:   "ㄝ",
      ai:  "ㄞ",
      ei:  "ㄟ",
      ao: "ㄠ",
      ou:  "ㄡ",
      an:  "ㄢ",
      en:  "ㄣ",
      ang:"ㄤ",
      eng: "ㄥ",
      er:  "ㄦ",
      ia:  "ㄧㄚ",
      io:  "ㄧㄛ",
      ie: "ㄧㄝ",
      iai: "ㄧㄞ",
      iao: "ㄧㄠ",
      iu:  "ㄧㄡ",
      ian:"ㄧㄢ",
      in:  "ㄧㄣ",
      iang:"ㄧㄤ",
      ing:"ㄧㄥ",
      ua:  "ㄨㄚ",
      uo:  "ㄨㄛ",
      uai:"ㄨㄞ",
      ui:  "ㄨㄟ",
      uan: "ㄨㄢ",
      un: "ㄨㄣ",
      uang:"ㄨㄤ",
      ong: "ㄨㄥ",
      "ue" => "ㄩㄝ",
      "uan" => "ㄩㄢ",
      "un"=> "ㄩㄣ",
      iong:"ㄩㄥ",
    }

    @@tones = {
      "1"=> " ",
      "2"=> "ˊ",
      "3"=> "ˇ",
      "4"=> "ˋ",
      "5"=> "˙",
    }

    def initialize
      @@table = @@table.sort_by { |key, val| key.length }.reverse
    end

    def convert(pinyin)
      zhuyin = pinyin.dup
      @@replacements.each { |key, val| zhuyin.gsub!(key.to_s, val) }
      @@table.each { |key, val| zhuyin.gsub!(key.to_s, val) }
      @@tones.each { |key, val| zhuyin.gsub!(key.to_s, "#{val} ")}
      return zhuyin
    end

  end
end