class QuestionMailer < ApplicationMailer
  def question_email(question)
    @question = question
    mail(
      to: 'properguideimplant@gmail.com',
      subject: @question.subject
      )
  end
end
