class PostsController < ApplicationController


	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)

		@post.user_id = current_user.id
		respond_to do |f|
			if (@post.save)
				f.html {redirect_to request.referrer , notice: "Post Created"}
			else
				f.html {redirect_to "", notice: "Error"}
			end
		end

	end


	def destroy
			@post_to_delete = Post.find_by_id(params[:id])
		 	if current_user.id == @post_to_delete.user_id
		 		@post_to_delete.destroy
		 		redirect_to request.referrer, notice: "Post deleted"
		 	else
		 		redirect_to "", notice: "Error: Cant Delete Other's posts"
		 	end	
	end

	def edit
  		@post_to_edit = Post.find(params[:id])
	end

	def update


		  @post_to_edit = Post.find_by_id(params[:id])

		  if current_user.id == @post_to_edit.user_id
  		  	@post_to_edit.assign_attributes(post_params)
  		  	@post_to_edit.save
  		  	redirect_to "", notice: "Post Edited"
  		  else
  		  	redirect_to "", notice: "Cant Edit Other's post"
  		  end 


	end


	 private
	 def post_params
	 	params.require(:post).permit(:user_id,:content)
	 end


end