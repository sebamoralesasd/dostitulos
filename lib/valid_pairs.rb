# frozen_string_literal: true

# ValidPairs representa a los pares de titulos y categorias
# en donde un titulo contenga un topico en su definición.
# Esto es, [(t, c) : c es substring de t].
class ValidPairs
  def initialize(params)
    @pairs = params
  end

  def get
    @pairs[Random.new.rand(0...@pairs.count)]
  end
end
