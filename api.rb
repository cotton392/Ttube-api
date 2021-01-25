require 'sinatra'
require 'sinatra/reloader'
require 'rack/contrib'
require 'securerandom'
require 'base64'
require 'json'
require 'date'

use Rack::PostBodyContentTypeParser

post '/api/movie_receive' do
  # 受け取りパラメータ
  # mail_address: メールアドレス, string
  # encoded_movie: base64でエンコードされた動画の文字列, string
  # 返却パラメータ
  # status: APIの最終実行ステータス, string(OK or Failure)
  # (statusがFailureの場合のみ)Reason: Failである理由(主にエラー内容)
  mail_address = params[:mail_address]
  movie = params[:encoded_movie][:tempfile].read
  IO.binwrite("movie_tmp/#{SecureRandom.hex(12) + "_" + mail_address.gsub!(".", "__").gsub!("@", "___")}.mp4", movie)
end
