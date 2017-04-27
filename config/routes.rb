Rails.application.routes.draw do
  get '/' => 'pages#home'

  post '/' => 'intends#process'
end
