module SharingBooksHelper
  def load_books
    @sharing_books.map(&:book)
  end
end
