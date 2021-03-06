class ReviewsController < ApplicationController
	before_action :authenticate_user! 
	before_action :set_review, only: [:edit,:update,:destroy]

	def edit
		#  this is needed cos , place id is passing when editing reviews
		@place = @review.place
	end

	def create
		@review = current_user.reviews.new(review_params)
		puts @review

	    respond_to do |format|
	      if @review.save
	        format.html { redirect_to place_path(@review.place), notice: 'Review was successfully created.' }
	        format.json { render :show, status: :created, location: @review }
	      else
	      	format.html { redirect_to place_path(@review.place),notice: "Something went wrong" }
	      end
	    end
	  end

	def update
		respond_to do |format|
	      if @review.update(review_params)
	        format.html { redirect_to place_path(@review.place), notice: 'Review was successfully updated.' }
	        format.json { render :show, status: :ok, location: @review }
	      else
	       	format.html{ redirect_to place_path(@review.place),notice: "Something went wrong" }
	      end
	    end
	end

	def destroy
		@review.destroy
	    respond_to do |format|
	      format.html { redirect_to place_path(@review.place), notice: 'Review was successfully destroyed.' }
	    end
	end

	private

	def set_review
		@review = Review.find(params[:id])
	end

	def review_params
		params.require(:review).permit(:content,:place_id,:score)
	end
end