class DentistsController < ApplicationController
  #require current user to be admin
  before_action :authenticate, except: [:show]
  
  # require current user id to match id on request
  before_action :authorize, except: [:create]

  def create

  end

  def show
    # return dentist info, current orders
  end
end
