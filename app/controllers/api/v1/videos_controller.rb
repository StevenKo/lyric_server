class Api::V1::VideosController < Api::ApiController
  def index
    videos = Video.select("title, youtube_id")
    render :json => videos.shuffle
  end
end
