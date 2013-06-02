Web3dPrinterSpooler::Application.routes.draw do
  root :to => 'home#index'
  devise_for :users
end

