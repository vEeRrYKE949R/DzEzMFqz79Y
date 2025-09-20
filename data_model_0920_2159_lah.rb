# 代码生成时间: 2025-09-20 21:59:23
# data_model.rb
# This file contains the data model definitions for a Hanami application.

require 'hanami/model'
require 'hanami/model/mapping'

# Define your data models here.

module Bookstore
  # Entity
  class Author
    include Hanami::Entity
    include Hanami::Model::Mapping

    # Define the attributes of the Author entity
    attribute :id, Integer
    attribute :first_name, String
    attribute :last_name, String
  end

  # Entity
  class Book
    include Hanami::Entity
    include Hanami::Model::Mapping

    # Define the attributes of the Book entity
    attribute :id, Integer
    attribute :title, String
    attribute :author_id, Integer
  end

  # Repository
  class AuthorsRepository < Hanami::Repository
    associations do
      has_many :books
    end
  end

  # Repository
  class BooksRepository < Hanami::Repository
    associations do
      belongs_to :author
    end
  end
end
