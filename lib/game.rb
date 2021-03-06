# encoding: utf-8
class Game
  def initialize(slovo)
    @letters = get_letters(slovo)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  def get_letters(slovo)
    if slovo == nil || slovo == ""
      abort "Загадано пустое слово, нечего отгадывать. Закрываемся"
    end
    return slovo.split("")
  end

  def status
    return @status
  end

  def next_step(bukva)
    # Введенную пользователем букву Мы переводим в нижний регистр
    bukva = UnicodeUtils.downcase(bukva)

    if @status == -1 || @status == 1
      return
    end

    if @good_letters.include?(bukva) || @bad_letters.include?(bukva)
      return
    end
#проверка на е-ё, а также на и-й
    if @letters.include?(bukva) ||
      (bukva == "е" && @letters.include?("ё")) ||
      (bukva == "ё" && @letters.include?("е")) ||
      (bukva == "и" && @letters.include?("й")) ||
      (bukva == "й" && @letters.include?("и"))

      @good_letters << bukva

      @good_letters << "ё" if bukva == "е"
      @good_letters << "е" if bukva == "ё"
      @good_letters << "й" if bukva == "и"
      @good_letters << "и" if bukva == "й"
      if (@letters - @good_letters).empty? then @status = 1 end
    else
      @bad_letters << bukva
      @errors += 1
      if @errors >= 7 then @status = -1 end
    end
  end

  def ask_next_letter
    puts "\nВведите следующую букву"

    letter = ""
    while letter == ""
      letter = STDIN.gets.encode("UTF-8").chomp
    end

    next_step(letter)
  end

  def errors
    @errors
  end

  def letters
    @letters
  end

  def good_letters
    @good_letters
  end

  def bad_letters
    @bad_letters
  end
end
