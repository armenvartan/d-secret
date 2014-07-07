get '/' do
  get_session_id
  @secrets = Secret.order_by_votes
  @votes = Vote.all
  @votes.each{ |vote| vote.degrade_votes }
  @secrets.each{ |secret| secret.destroy if secret.sum_of_votes <= 0 }
  erb :index
end

get '/:secret_id' do
  @secret_id = params[:secret_id]
  secret = Secret.find(params[:secret_id])
  secret.votes.create(key: session[:id], number: 1) if vote_is_unique?(secret)
  @comments = secret.comments
  erb :comments, :layout => false
end

post '/new' do
	Secret.create(content: params[:content])
end

post '/new_comment' do
  p "hi"
  p params[:id]
  @secret = Secret.find(params[:id])
  @secret.comments.create(secret_id: params[:id], content: params[:comment])
  content_type :json
  Comment.last.to_json
end
