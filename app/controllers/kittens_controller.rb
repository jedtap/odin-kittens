class KittensController < ApplicationController

  def index
    @kittens = Kitten.all
    
    respond_to do |f|
      f.html
      f.json { render :json => @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])
  
    respond_to do |f|
      f.html
      f.json { render :json => @kitten }
    end
  end
  
  def new
    @kitten = Kitten.new
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      flash[:notice] = "New cat saved!"
      redirect_to @kitten
    else
      flash[:alert] = "Meow meow, thats not correct"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      flash[:notice] = "New cat updatedated!"
      redirect_to @kitten
    else
      flash[:alert] = "Meow meow, no updates for you"
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy

    flash[:notice] = "Cat goes bye bye"
    redirect_to root_path, status: :see_other
  end

  private

  def kitten_params
    params.required(:kitten).permit(:name, :age, :cuteness, :softness)
  end

end
