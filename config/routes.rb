Rails.application.routes.draw do
  root to: 'ui#directory'
  get 'ui', to: 'ui#directory'
  get 'ui(/:action)', controller: 'ui'
end
