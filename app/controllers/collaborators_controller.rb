class CollaboratorsController < ApplicationController

 def create
   @wiki = Wiki.find(params[:id])
   @wiki.title = params[:wiki][:title]
   @wiki.body = params[:wiki][:body]
   @wiki.private = params[:wiki][:private]
   @wiki.user = @wiki.user

   if @wiki.save
     flash[:notice] = "Your wiki was updated"
     redirect_to @wiki
   else
     flash.now[:alert] = "There was an error saving your wiki. Please try again #{params[:wiki][:user_id]}"
     render :edit
   end
 end

 def destroy
 end

end
