module RandomData

  def self.random_paragraph
    sentences = []
    rand(4..6).times do
      sentences << random_sentence
    end
    sentences.join(" ")
  end

  def self.random_sentence
    words = []
    rand(3..8).times do
      words << random_word
    end
    sentences = words.join(" ")
    sentences.capitalize << "."
  end

  def self.random_word
    letters = ('a'..'z').to_a
    letters.shuffle!
    letters[0,rand(3..8)].join
  end

end
