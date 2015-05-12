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
  # @checkbox_ids = params.fetch("checkbox_ids")
  # @checkbox_ids.each() do |quest|
  #   question = Question.find(quest)
  #   question.delete()
  # end
  @questions = Question.survey_questions(@id)
  erb(:survey)
end

post('/thank_you') do
  @question_ids = params.fetch('question_ids')
  @questions = ""
  @answers = params.fetch('answers')
  counter = 0
  @question_ids.each() do |id|
    Answer.create({:questions_id => id, :words => @answers[counter]})
    if @answers[counter] != ""
      @questions = @questions + " " + @question_ids[counter].to_s + ","
      # if counter == (@question_ids.length - 1)
      #   @questions -= ","
      # end
    end
    counter += 1
  end
  erb(:thank_you)
end




# <div class="checkbox">
#   <label>
#     <input type="checkbox" name="checkbox_ids[]" value="<%= question.id %>"><li><%= question.name %></li>
#     <form action="/thank_you" method="post">
#       <input type="hidden" name="question_ids[]" value="<%= question.id %>">
#       <input id="answer<%= question.id %>" name="answers[]" placeholder="Answer" value="">
#     </form>
#   </label>
# </div>
