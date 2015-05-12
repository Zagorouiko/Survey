class Answer < ActiveRecord::Base
  belongs_to(:question)
  validates(:words, {:presence => true, :length => {:maximum => 50}})
end
