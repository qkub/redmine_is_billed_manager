# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
match 'isbilledmanager/', to: 'isbilledmanager#index', :via => [:get, :post]
match 'isbilledmanager/index/:project_id', to: 'isbilledmanager#index', :via => [:get, :post]
match 'isbilledmanager/:action', to: 'isbilledmanager#execute', :via => [:get, :post]