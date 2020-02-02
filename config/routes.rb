# frozen_string_literal: true

Rails.application.routes.draw do
  get 'welcome/index'

  resources :companies do
    resources :employees
  end

  root 'welcome#index'

  get 'companies/new'
end
