require 'sinatra'
require 'icodi'

if development?
  require "sinatra/reloader"
  also_reload 'lib/icodi.rb'
end

set :bind, '0.0.0.0'
set :port, 3000

get '/sandbox' do
  erb :sandbox
end

get '/*' do
  cache_control :no_cache, :no_store, :must_revalidate

  seed = params[:splat].first  
  seed = nil if seed.empty?

  color, background = params[:color], params[:background]
  color = "##{color}" if color and !color.start_with? '#'
  background = "##{background}" if background and !background.start_with? '#'

  options = {}
  options[:pixels]     = params[:pixels].to_i if params[:pixels]
  options[:stroke]     = params[:stroke].to_f if params[:stroke]
  options[:density]    = params[:density].to_f if params[:density]
  options[:mirror]     = params[:mirror].to_sym if params[:mirror]
  options[:jitter]     = params[:jitter].to_f if params[:jitter]
  options[:background] = background if background
  options[:color]      = color if color

  content_type 'image/svg+xml'
  Icodi.new(seed, options).render
end