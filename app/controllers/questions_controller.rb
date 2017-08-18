class QuestionsController < ApplicationController
  require 'sendgrid-ruby'
  sendgrid = SendGrid::Client.new do |c|
    c.api_key = ENV['SENDGRID_APIKEY']
  end


  def create
    @question = Question.new(question_params)

    if @question.save!
      # using SendGrid's Ruby Library
      # https://github.com/sendgrid/sendgrid-ruby

      email = SendGrid::Mail.new do |m|
        m.to      = 'properguideimplant@gmail.com'
        m.from    = params[:email]
        m.subject = 'Question from ProperGuide contact page'
        m.html    = "<!DOCTYPE html>
                <html>
                <head>
                  <meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
                  <meta http-equiv='Content-Style-Type' content='text/css'>
                  <style type='text/css'>
                    p.p1, p.p2 {
                      margin: 0.0px 0.0px 0.0px 0.0px;
                      line-height: 43.0px;
                      font: 24.0px Arial;
                      color: #555555;
                      -webkit-text-stroke: #555555
                    }
                    p.p2 {
                      line-height: 21.0px;
                      font: 18.0px Arial;
                    }
                    span.s1 {
                      font-kerning: none;
                      background-color: #ffffff
                    }
                    span.s2 {
                      font: 12.0px Arial;
                      font-kerning: none
                    }
                    table.t1 {
                      border-collapse: collapse
                    }
                    td.td1 {
                      width: 500.0px;
                      min-width: 320.0px;
                      max-width: 500.0px
                    }
                  </style>
                </head>
                <body>
                <table cellspacing='0' cellpadding='0' class='t1'>
                  <tbody>
                    <tr>
                      <td valign='top' class='td1'>
                        <p class='p1'><span class='s1'><b>﻿New Question about ProperGuide</b></span><span class='s2'><br><br>
                </span></p>
                        <p class='p2'><span class='s1'>Question from: #{params[:name]}</span></p>
                        <p class='p2'><span class='s1'>Call Back Number: #{params[:phone]}</span></p>
                        <p class='p2'><span class='s1'>Contact Email: #{params[:email]}</span></p>
                        <p class='p2'><span class='s1'>Subject: #{params[:subject]}</span></p>
                        <p class='p2'><span class='s1'>Patient Phone Number: #{params[:text]}</span></p>
                      </td>
                    </tr>
                  </tbody>
                </table>
                </body>
                </html>
              "
      end
      sendgrid.send(email)
    else
      render json: {status: 422}
    end
  end

  private

    def question_params
      params.require(:question).permit(:subject, :text, :phone, :email, :name)
    end
end
