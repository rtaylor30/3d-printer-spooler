Web3dPrinterSpooler::Application.routes.draw do
  root to: 'home#root'
  devise_for :users

  resources :print_job
  resources :print_request
  match '/home' => 'home#index' 

  if ENV['ADMIN_PRODUCTION']
    match '/admin' => 'admin#index'
  end
end

