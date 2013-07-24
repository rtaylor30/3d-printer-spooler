Web3dPrinterSpooler::Application.routes.draw do
  root to: 'home#root'
  match '/poll_jobs' => 'home#poll_jobs'
  devise_for :users

  resources :print_job
  resources :print_request
  match '/print_request/next_state/:id' => 'print_request#next_state'
  match '/home' => 'home#index' 
  match '/update_print_request' => 'api#update_print_request'
  match '/poll_new_requests' => 'api#poll_new_requests'

  if ENV['ADMIN_PRODUCTION']
    match '/admin' => 'admin#index'
  end
end

