class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorized_user, only: [:edit, :update, :destroy]

  # GET /links
  # GET /links.json
  def index
    @links = Link.all
  end
  

  # GET /links/1
  # GET /links/1.json
  def show
    @link = Link.find(params[:id])
  end


  def new
    @link = current_user.links.build
  end

 
  def edit
  end

 
  def create
    @link = current_user.links.build(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    @link = Link.find(params[:id])
    @link.upvote_by current_user
    redirect_to :back
  end

  def dislike
    @link = Link.find(params[:id])
    @link.downvote_by current_user
    redirect_to :back
  end

  private
   
    def set_link
      @link = Link.find(params[:id])
    end

    def authorized_user
      @link = current_user.links.find_by(id: params[:id])
      redirect_to links_path, notice: "Not authorized to edit this link" if @link.nil?
    end

    
    def link_params
      params.require(:link).permit(:title, :url)
    end
end