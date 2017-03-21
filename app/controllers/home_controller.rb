require 'open-uri'
class HomeController < ApplicationController

	def index

	end

	def result

		if params[:search]
			params[:search].gsub!(" ", "%20")

			amazon_url = "http://www.amazon.in/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords=#{params[:search]}"
			snapdeal_url = "https://www.snapdeal.com/search?keyword=#{params[:search]}&santizedKeyword=&catId=&categoryId=0&suggested=false&vertical=&noOfResults=20&searchState=&clickSrc=go_header&lastKeyword=&prodCatId=&changeBackToAll=false&foundInAll=false&categoryIdSearched=&cityPageUrl=&categoryUrl=&url=&utmContent=&dealDetail=&sort=rlvncy"
			flipkart_url = "https://www.flipkart.com/search?q=#{params[:search]}"

			begin
				page = Nokogiri::HTML(open(amazon_url))
				@amazon_price = page.css(".s-price")[0].text
				@amazon_title = page.css(".s-access-title")[0].text
				@amazon_link = page.css(".s-access-detail-page")[0]['href']
				@amazon_image = page.css(".s-access-image")[0]['src']
			rescue Exception => e
				puts e.message
			end

			begin
				page_snap = Nokogiri::HTML(open(snapdeal_url))
				@snapdeal_price = page_snap.css(".product-price")[0].text
				@snapdeal_link = page_snap.css(".product-desc-rating > a")[0]['href']
				@snapdeal_title = page_snap.css(".product-title")[0].text
			rescue Exception => e
				puts e.message
			end

			begin
				browser = Watir::Browser.new :phantomjs
				browser.goto flipkart_url
				html_doc = Nokogiri::HTML browser.html
				@flipkart_title = (html_doc.css('div._3wU53n') + html_doc.css('a._2cLu-l')).first.text
				@flipkart_link = "https://flipkart.com" + (html_doc.css('a._2cLu-l').empty? ? html_doc.css('a._1UoZlX') : html_doc.css('a._2cLu-l')).attribute('href')
				@flipkart_price = html_doc.css('div._1vC4OE').first.text.slice(1..-1)
				browser.close
			rescue Exception => e
				puts e.message
			end
		end
	end
end
