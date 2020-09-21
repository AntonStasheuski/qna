class AnswersController < ApplicationController

  def index
    @answers = question.answers.all
  end

  private

  helper_method :question

  def question
    @question ||= Question.find(params[:question_id])
  end
end
