class WordProblem
  attr_reader :question
  def initialize(question)
    @question = question
  end

  def preprocessed_q
    question.sub("What is ", "").sub(/\?$/, "").gsub(" by", "")
  end

  def operators
    {"plus" => "+",
     "minus" => "-",
     "divided" => "/",
     "multiplied" => "*" }
  end

  def tokens
    operators.reduce(preprocessed_q) do |question, (verb, operator)|
      question.gsub(verb, operator)
    end.split
  end

  def valid_tokens
    tokens.map do |t|
      if t.match(/\d/) || operators.invert[t]
        t
      else
        raise ArgumentError.new("lol")
      end
    end
  end

  def answer
    initial_value, *chain = valid_tokens

    chain.each_slice(2).reduce(initial_value.to_i) do |result, (operator, arg)|
      result.send(operator, arg.to_i)
    end
  end
end
