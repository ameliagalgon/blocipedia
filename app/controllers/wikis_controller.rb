#require 'redcarpet'
class WikisController < ApplicationController
  helper RedcarpetMethods
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    #renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
  end

  def new
    @wiki = Wiki.new
    @users = User.all
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Your wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving your wiki. Please try again"
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
    @markdown = Redcarpet::Markdown.new(renderer)

    #for collaborators
    @users = User.all
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    if params[:wiki][:private] == nil
      @wiki.private = @wiki.private
    else
      @wiki.private = params[:wiki][:private]
    end
    @wiki.user = @wiki.user
    #binding.pry
    if !params[:wiki][:collaborators].nil?
      params[:wiki][:collaborators].each do |id|
        c = Collaborator.new(user_id: id, wiki_id: @wiki.id)
        c.save
      end
    else
      Collaborator.all.each do |c|
        if c.wiki_id == @wiki.id
          c.destroy
        end
      end
    end

    if @wiki.save
      flash[:notice] = "Your wiki was updated"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving your wiki. Please try again #{params[:wiki][:user_id]}"
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted sucessfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting your wiki. Please try again."
      render :show
    end
  end
end
