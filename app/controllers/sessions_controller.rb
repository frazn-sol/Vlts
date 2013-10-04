class SessionsController < Devise::SessionsController

  def new
    binding.pry
    super
  end

  def create
    binding.pry
    super
  end

  def edit
    super
  end

  def update
  end

  def destroy
    binding.pry
   super
  end

end