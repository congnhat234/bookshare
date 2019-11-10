module BooksHelper
  def get_category_size category, type
    case type
    when "selling"
      category.books.selling.size
    when "sharing"
      category.books.sharing.size
    when "exchange"
      category.books.exchange.size
    else
      category.books.size
    end
  end

  def get_size type
    case type
    when "selling"
      Book.selling.size
    when "sharing"
      Book.sharing.size
    when "exchange"
      Book.exchange.size
    else
      Book.all.size
    end
  end
end
