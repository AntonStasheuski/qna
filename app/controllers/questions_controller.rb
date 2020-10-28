class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[show edit update destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
    @answer.links.new # .build
  end

  def new
    @question = current_user.questions.new
    @question.links.new # .build
    @question.build_reward
  end

  def edit; end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    end
  end

  def update
    if current_user&.author?(@question) && @question.update(question_params)
      redirect_to @question
    end
  end

  def destroy
    if current_user&.author? @question
      @question.destroy
      redirect_to questions_path, notice: 'Your question successfully deleted.'
    else
      redirect_to questions_path, alert: 'Only the author can delete a question.'
    end
  end

  private

  def find_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, files: [], links_attributes: [:name, :url, :done, :_destroy], reward_attributes: [:title, :file])
  end
end
