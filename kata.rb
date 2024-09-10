class Kata
  def initialize(dictionary_url:, size:, limit:)
    @dictionary_url = dictionary_url
    @size = size
    @limit = limit
    @result = []
  end

  def combined_words
    possible_word_parts.each do |left|
      possible_word_parts.each do |right|
        possible_word = left + right

        add_word_to_result(left, right, possible_word) if matching_word?(possible_word)
      end
    end

    result
  end

  def combined_words
    possible_word_parts.permutation(2).each.with_index do |combination, _index|
      left, right = combination
      possible_word = left + right

      add_word_to_result(left, right, possible_word) if matching_word?(possible_word)
    end

    result
  end

  private

  attr_reader :dictionary_url, :size, :limit, :result

  def add_word_to_result(left, right, possible_word)
    result << "#{left} + #{right} => #{possible_word}"
  end

  def matching_word?(possible_word)
    possible_word.length == size && target_letter_words.include?(possible_word)
  end

  def words_from_dictionary
    @words_from_dictionary ||= File.open(dictionary_url).readlines.map(&:strip).take(limit)
  end

  def target_letter_words
    @target_letter_words ||= words_from_dictionary.select { |w| w.length == size }
  end

  def possible_word_parts
    @possible_word_parts ||= words_from_dictionary.select { |w| w.length < size }
  end
end

puts Kata.new(dictionary_url: '/Users/adamdawkins/dev/sandbox/kata_08_2/dictionary.txt', size: 6,
              limit: 50_000).combined_words
