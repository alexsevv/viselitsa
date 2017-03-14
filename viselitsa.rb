# encoding: utf-8
#
# Популярная детская игра
# https://ru.wikipedia.org/wiki/Виселица_(игра)
#
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

# Подключаем библиотеку unicode_utils. Предварительно её надо установить, набрав:
# gem install unicode_utils . Для нормальной работы в Windows нужно подкючать unicode_utils/downcase
require "unicode_utils/downcase"

require_relative "lib/game"
require_relative "lib/result_printer"
require_relative "lib/word_reader"

puts "Игра виселица.\n\n"
sleep 1

printer = ResultPrinter.new

word_reader = WordReader.new

words_file_name = File.dirname(__FILE__) + "/lib/data/words.txt"

# Все изменения логики будут у нас в классе Game.  В одном месте нам нужно
# преобразовать полученные данные в нижний регистр, используя метод downcase
# подключенного модуля UnicodeUtils: получении новой буквы от пользователя.
game = Game.new(word_reader.read_from_file(words_file_name))

while game.status == 0
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)
