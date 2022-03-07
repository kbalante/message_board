class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    @comment.post = @post
    @comment.user_id = current_user.id
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_url(@comment.post) , notice: "Comment was successfully created." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if permitted_user?(@comment.user) && @comment.update(comment_params)
        format.html { redirect_to post_url(@comment.post) , notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy if permitted_user?(@comment.user)

    respond_to do |format|
      if permitted_user?(@comment.user)
        format.html { redirect_to post_url(@comment.post) , notice: "Comment was successfully destroyed." }
      else
        format.html { redirect_to post_url(@comment.post) , notice: "Comment was not successfully destroyed." }
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:post_id, :body, :user_id)
    end
end
