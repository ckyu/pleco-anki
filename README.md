##Pleco to Anki Flashcard Converter

###Usage:

```
ruby pleco-anki.rb -i <xml_file> -o <txt_file>
```

The resulting text file will have the following columns:
`<simplified>[tab]<traditional>[tab]<pinyin>[tab]<zhuyin>[tab]<english>`

Different definitions are separated by a `<br>` tag.

###Issues:
- Sample sentences are automatically trimmed from the definition, for brevity. The way the script does this is that it truncates the string the moment it sees a Chinese character, leading to instances where measure words are also deleted.
- Pinyin to Zhuyin conversion is not 100% tested.