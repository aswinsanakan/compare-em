class HomeController < ApplicationController
	def index

	end

	def result
		if params[:search]
			
			@product_title = params[:search]
		end
	end
end
