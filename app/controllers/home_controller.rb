require 'open-uri'
class HomeController < ApplicationController

	def index

	end

	def result
		
		if params[:search]
			params[:search].gsub!(" ", "%20")

			amazon_url = "http://www.amazon.in/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords=#{params[:search]}"
			snapdeal_url = "https://www.snapdeal.com/search?keyword=#{params[:search]}&santizedKeyword=&catId=&categoryId=0&suggested=false&vertical=&noOfResults=20&searchState=&clickSrc=go_header&lastKeyword=&prodCatId=&changeBackToAll=false&foundInAll=false&categoryIdSearched=&cityPageUrl=&categoryUrl=&url=&utmContent=&dealDetail=&sort=rlvncy"
			page = Nokogiri::HTML(open(amazon_url))
			@amazon_price = page.css(".s-price")[0].text
			@amazon_title = page.css(".s-access-title")[0].text
			@amazon_link = page.css(".s-access-detail-page")[0]['href']
			@amazon_image = page.css(".s-access-image")[0]['src']
			
			page_snap = Nokogiri::HTML(open(snapdeal_url))
			@snapdeal_price = page_snap.css(".product-price")[0].text
			@snapdeal_link = page_snap.css(".product-desc-rating > a")[0]['href']
			@snapdeal_title = page_snap.css(".product-title")[0].text
		end
	end
end
