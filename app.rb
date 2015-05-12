require 'sinatra'
require 'sinatra/reloader'
require("sinatra/activerecord")
also_reload 'lib/**/*.rb'
require './lib/survey'
require './lib/question'
require 'pg'
require 'pry'


get('/') do
  @surveys = Survey.all
  erb(:index)
end

post('/') do
  new_survey = params.fetch('survey')
  new_survey = Survey.create({:name => new_survey})
  @surveys = Survey.all()
  erb(:index)
end

get('/survey/:id') do
  @id = params.fetch('id').to_i
  @questions = Question.survey_questions(@id)
  erb(:survey)
end

post('/survey/:id') do
  @id = params.fetch('id').to_i
  question1 = params.fetch('question1')
  Question.create({:name => question1, :survey_id => @id})
  question2 = params.fetch('question2')
  Question.create({:name => question2, :survey_id => @id})
  question3 = params.fetch('question3')
  Question.create({:name => question3, :survey_id => @id})
  question4 = params.fetch('question4')
  Question.create({:name => question4, :survey_id => @id})
  question5 = params.fetch('question5')
  Question.create({:name => question5, :survey_id => @id})
  @questions = Question.survey_questions(@id)
  erb(:survey)
end

patch('/survey/:id') do
  @id = params.fetch('id').to_i
  question6_words = params.fetch('question6')
  question6 = Question.create({:name => question6_words, :survey_id => @id})
  @questions = Question.survey_questions(@id)
  erb(:survey)
end

delete('/survey/:id') do
  @id = params.fetch('id').to_i
  @checkbox_ids = params.fetch("checkbox_ids")
  @checkbox_ids.each() do |quest|
    question = Question.find(quest)
    question.delete()
  end
  # to_delete2 = params.fetch("checkbox_ids")
  # Question.to_delete(to_delete2)
  @questions = Question.survey_questions(@id)
  erb(:survey)
end
