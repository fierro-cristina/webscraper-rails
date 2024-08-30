# frozen_string_literal: true

Rails.application.routes.draw do
  get '/scraper', to: 'scraper#scraper'
end
