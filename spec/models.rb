  require "database_builder"

  class Reader < ActiveRecord::Base
  end

  class Library < ActiveRecord::Base
  end

  module AModule
    class Book < ActiveRecord::Base
      has_many_to_many :readers
      has_many_to_many :alias_readers, class_name: :Reader
      has_many_to_many :books, class_name: "AModule::Book"
      has_many_to_many :libraries
      validates_presence_of :name
    end
  end

  class Reader < ActiveRecord::Base
    has_many_to_many :books, class_name: AModule::Book
    has_many_to_many :readers
    has_many_to_many :libraries
    validates_presence_of :name
  end

  class Library < ActiveRecord::Base
    has_many_to_many :books, class_name: AModule::Book
    has_many_to_many :readers
    validates_presence_of :name
  end

  class Floor < ActiveRecord::Base
    has_many_to_one :rooms
  end

  class Room < ActiveRecord::Base
    has_one_to_many :floors
  end
