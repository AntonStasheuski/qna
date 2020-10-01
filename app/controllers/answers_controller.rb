class AnswersController < ApplicationController
  before_action :find_question, only: %i[index new edit create update destroy]
  before_action :find_answer, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @answers = @question.answers
  end

  def show; end

  def new; end

  def edit; end

  def create
    @answer = @question.answers.new(answer_params.merge(user: current_user))
    if @answer.save
      redirect_to question_answer_path(question_id: @question, id: @answer), notice: 'Your answer successfully created.'
    else
      render 'questions/show'
    end
  end

  def update
    if current_user.author?(@answer) && @answer.update(answer_params)
      redirect_to question_answer_path(question_id: @question, id: @answer)
    else
      render :edit
    end
  end

  def destroy
    if current_user.author? @answer
      @answer.destroy
      redirect_to question_answers_path(question_id: @answer.question), notice: 'Your answer successfully deleted.'
    else
      redirect_to question_answers_path(question_id: @answer.question), alert: 'Only the author can delete a answer.'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end
end
