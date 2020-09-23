class AnswersController < ApplicationController
  before_action :find_question, only: %i[index new edit create update destroy]
  before_action :find_answer, only: %i[show edit update destroy]

  def index
    @answers = question.answers
  end

  def show; end

  def new; end

  def edit; end

  def create
    @answer = question.answers.new(answer_params)
    if answer.save
      redirect_to question_answer_path(question_id: answer.question, id: answer)
    else
      render :new
    end
  end

  def update
    if answer.update(answer_params)
      redirect_to question_answer_path(question_id: answer.question, id: answer)
    else
      render :edit
    end
  end

  def destroy
    answer.destroy
    redirect_to question_answers_path(question_id: question)
  end

  private

  helper_method :question, :answer

  def answer_params
    params.require(:answer).permit(:body)
  end

  def answer
    @answer ||= params[:id] ? Answer.find(params[:id]) : question.answers.new
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end
end