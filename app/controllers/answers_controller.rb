class AnswersController < ApplicationController
  def index
    @answers = question.answers.all
  end

  def show; end

  def new; end

  def create
    @answer = question.answers.new(answer_params)
    if @answer.save
      redirect_to question_answer_path(question_id: @answer.question, id: @answer)
    else
      render :new
    end
  end

  private

  helper_method :question, :answer

  def answer_params
    params.require(:answer).permit(:body)
  end

  def answer
    @answer ||= params[:id] ? Answer.find(params[:id]) : question.answers.new(answer_params)
  end

  def question
    @question ||= Question.find(params[:question_id])
  end
end
