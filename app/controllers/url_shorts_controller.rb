require 'rest-client'
class UrlShortsController < ApplicationController
  class InvalidOriginalUrlExeption < StandardError
  end
  class ShortURLAlreadyTaken < StandardError
  end
  # GET /url_shorts
  # GET /url_shorts.json
  def index
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { @url_shorts = UrlShort.all }
    end
  end
  
  # GET /url_shorts/new
  def new
    @url_short = UrlShort.new
  end
  # POST /url_shorts
  # POST /url_shorts.json
  def create
    @url_short = UrlShort.new(url_short_params)
    # if @url_short.short_url.blank?
    #   url_shorten = UrlShort.find_by_original_url(@url_short.original_url)
    #   render json: {url_short: "#{request.base_url}/#{url_shorten.short_url}", error: false} and return if url_shorten
    # end
    begin
      begin
        resp = RestClient.get(@url_short.original_url)
        raise '' if resp.code != 200
      rescue => e
        raise InvalidOriginalUrlExeption, 'Original URL not available'
      end
      if @url_short.short_url.present?
        raise ShortURLAlreadyTaken, 'Such a short URL is already taken' if UrlShort.find_by_short_url(@url_short.short_url)
      else
        count_item = UrlShort.count
        count_item_dec = count_item
        range = 0..7
        arr_alphabet = ('a'..'z').to_a
        loop do
          @url_short.short_url = arr_alphabet.shuffle[range].join()
          break unless UrlShort.find_by_short_url(@url_short.short_url)
          if count_item_dec > 0
            count_item_dec -= 1
          else
            count_item_dec = count_item
            range = Range.new 0, range.end + 1
          end
        end
      end
    rescue InvalidOriginalUrlExeption => exeption
      render json: {description: exeption.message, whose: 'original_url', error: true} and return
    rescue ShortURLAlreadyTaken => exeption
      render json: {description: exeption.message, whose: 'short_url', error: true} and return
    rescue => exeption
      render json: {description: exeption.message, whose: 'common', error: true}
    end
    if @url_short.save
      render json: {url_short: "#{request.base_url}/#{@url_short.short_url}", error: false}
    else
      render json: {description: 'Save error', whose: 'common', error: true}
    end
  end

  def to_original
    url_short = UrlShort.find_by_short_url(params[:short_url])
    if url_short
      url_short.hits_short_url += 1
      url_short.save
      redirect_to url_short.original_url
    else
      redirect_to root_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.
    def url_short_params
      params.require(:url_short).permit(:original_url, :short_url)
    end
end
