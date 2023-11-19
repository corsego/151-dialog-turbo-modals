class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :ensure_frame_response, only: %i[ new edit show ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        # format.html { redirect_to comment_url(@comment), notice: "Comment was successfully created." }
        # format.html { redirect_to comments_url, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
        format.turbo_stream do
          # render turbo_stream: turbo_stream.prepend(
          #   'comments',
          #   partial: "comments/comment",
          #   locals: { comment: @comment }
          # )
          # render turbo_stream: helpers.autoredirect(comments_path)
          # render turbo_stream: helpers.autoredirect(comment_path(@comment))
          # render turbo_stream: turbo_stream.action(:redirect, comments_path)
          # render turbo_stream: turbo_stream.advanced_redirect(comment_path(@comment))
          render turbo_stream: turbo_stream.advanced_redirect(comments_path)
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(
          @comment
        )
      end
    end
  end

  private

    def ensure_frame_response
      redirect_to root_path unless turbo_frame_request?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
