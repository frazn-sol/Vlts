class PlazasController < ApplicationController
  # GET /plazas
  # GET /plazas.json
  def index
    @plazas = Plaza.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plazas }
    end
  end

  # GET /plazas/1
  # GET /plazas/1.json
  def show
    @plaza = Plaza.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plaza }
    end
  end

  # GET /plazas/new
  # GET /plazas/new.json
  def new
    @plaza = Plaza.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plaza }
    end
  end

  # GET /plazas/1/edit
  def edit
    @plaza = Plaza.find(params[:id])
  end

  # POST /plazas
  # POST /plazas.json
  def create
    @plaza = Plaza.new(params[:plaza])

    respond_to do |format|
      if @plaza.save
        format.html { redirect_to @plaza, notice: 'Plaza was successfully created.' }
        format.json { render json: @plaza, status: :created, location: @plaza }
      else
        format.html { render action: "new" }
        format.json { render json: @plaza.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /plazas/1
  # PUT /plazas/1.json
  def update
    @plaza = Plaza.find(params[:id])

    respond_to do |format|
      if @plaza.update_attributes(params[:plaza])
        format.html { redirect_to @plaza, notice: 'Plaza was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @plaza.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plazas/1
  # DELETE /plazas/1.json
  def destroy
    @plaza = Plaza.find(params[:id])
    @plaza.destroy

    respond_to do |format|
      format.html { redirect_to plazas_url }
      format.json { head :no_content }
    end
  end

  def management
    @plazas = Plaza.all
  end
end
