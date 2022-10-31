# frozen_string_literal: true

module DosTitulos
  # Métodos principales para definir el título a publicar.
  class DosTitulos
    # Toma un feed y un tópico y modifica al título
    # obtenido del feed con dicho tópico.
    def replace(params)
      title = params[:feed].title
      old_categories = categories_on_title(params[:feed])
      puts old_categories
      cat = old_categories[Random.new.rand(0..old_categories.count - 1)]
      topic = params[:topic]

      # case-insensitive
      title.sub(/#{cat}/i, topic)
    end

    # Dado un par (titulo, topicos) verifica si el titulo
    # contiene algún tópico en su definición.
    def categories_on_title(pair)
      pair.categories.select { |c| pair.title.split.map(&:capitalize).join(' ').include?(c) }
    end

    # Filtra los pares (titulo, topicos) que cumplan con categories_on_title.
    def titles_with_categories(feed)
      pairs = feed.pairs
      pairs.select { |p| categories_on_title(p).count.positive? }
    end
  end
end
