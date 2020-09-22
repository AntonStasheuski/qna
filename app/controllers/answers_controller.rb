class AnswersController < ApplicationController

  def index
    @answers = question.answers.all
  end

  def show

  end

  def create
    @answer = question.answers.new(answer_params)
    if @answer.save
      # redirect_to @question
    else
      # render :new
    end
  end

  private

  helper_method :question

  def answer_params
    params.require(:answer).permit(:body)
  end

  def question
    @question ||= Question.find(params[:question_id])
  end
end
