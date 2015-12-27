require './app/controllers/application_controller'

class BlocksController < ApplicationController
  def index
    render partial: './app/views/blocks/index.html.erb'
  end

  def show
  end

  def edit
    @block_id = params['id']
    @block = 'Some block'
    @features = ['feature 1','feature 2', 'feature 3']
  end
end


