class QuestionsController < ApplicationController
  def create
    @question = Question.new(question_params)

    if @question.save!
      QuestionMailer.question_email(@question).deliver_later
      render json: {status: 201, question: @question}
    else
      render json: {status: 422}
    end
  end

  private

    def question_params
      params.require(:question).permit(:subject, :text, :phone, :email, :name)
    end
end
