Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #root 'pools#index'
  # Routes for the Pool resource:
  # CREATE
  get "/pools/new", :controller => "pools", :action => "new"
  post "/create_pool", :controller => "pools", :action => "create"

  # READ
  get "/pools", :controller => "pools", :action => "index"
  get "/pools/:id", :controller => "pools", :action => "show"
  get "/update_pool_results/:id", :controller => "pools", :action => "updatepoolresults"

  # UPDATE
  get "/pools/:id/edit", :controller => "pools", :action => "edit"
  post "/update_pool/:id", :controller => "pools", :action => "update"

  # DELETE
  get "/delete_pool/:id", :controller => "pools", :action => "destroy"
  #------------------------------

  # Routes for the Entry resource:
  # CREATE
  get "/entries/new/:pool_id", :controller => "entries", :action => "new"
  post "/create_entry/:pool_id", :controller => "entries", :action => "create"

  # READ
  get "/entries", :controller => "entries", :action => "index"
  get "/entries/:id", :controller => "entries", :action => "show"

  # UPDATE
  get "/entries/:id/edit", :controller => "entries", :action => "edit"
  post "/update_entry/:id", :controller => "entries", :action => "update"

  # DELETE
  get "/delete_entry/:id", :controller => "entries", :action => "destroy"
  #------------------------------

  # Routes for the Golfer_result resource:
  # CREATE
  get "/golfer_results/new", :controller => "golfer_results", :action => "new"
  post "/create_golfer_result", :controller => "golfer_results", :action => "create"
  post "/update_leaderboard/", :controller => "golfer_results", :action => "updateleaderboard"

  # READ
  get "/golfer_results", :controller => "golfer_results", :action => "index"
  get "/golfer_results/:id", :controller => "golfer_results", :action => "show"

  # UPDATE
  get "/golfer_results/:id/edit", :controller => "golfer_results", :action => "edit"
  post "/update_golfer_result/:id", :controller => "golfer_results", :action => "update"

  # DELETE
  get "/delete_golfer_result/:id", :controller => "golfer_results", :action => "destroy"
  #------------------------------

  # Routes for the Tournament resource:
  # CREATE
  get "/tournaments/new", :controller => "tournaments", :action => "new"
  post "/create_tournament", :controller => "tournaments", :action => "create"

  # READ
  get "/tournaments", :controller => "tournaments", :action => "index"
  get "/tournaments/:id", :controller => "tournaments", :action => "show"

  #UPDATE from API
  get "/update_tournament_table", :controller => "tournaments", :action => "update_tournament_table"


  # UPDATE
  get "/tournaments/:id/edit", :controller => "tournaments", :action => "edit"
  post "/update_tournament/:id", :controller => "tournaments", :action => "update"

  # DELETE
  get "/delete_tournament/:id", :controller => "tournaments", :action => "destroy"
  #------------------------------

  # Routes for the Golfer resource:
  # CREATE
  get "/golfers/new", :controller => "golfers", :action => "new"
  post "/create_golfer", :controller => "golfers", :action => "create"

  #UPDATE from API
  get "/update_golfer_table", :controller => "golfers", :action => "update_golfer_table"

  # READ
  get "/golfers", :controller => "golfers", :action => "index"
  get "/golfers/:id", :controller => "golfers", :action => "show"

  # UPDATE
  get "/golfers/:id/edit", :controller => "golfers", :action => "edit"
  post "/update_golfer/:id", :controller => "golfers", :action => "update"

  # DELETE
  get "/delete_golfer/:id", :controller => "golfers", :action => "destroy"
  #------------------------------

  # Routes for the Payoff resource:
  # CREATE
  get "/payoffs/new", :controller => "payoffs", :action => "new"
  post "/create_payoff", :controller => "payoffs", :action => "create"

  # READ
  get "/payoffs", :controller => "payoffs", :action => "index"
  get "/payoffs/:id", :controller => "payoffs", :action => "show"

  # UPDATE
  get "/payoffs/:id/edit", :controller => "payoffs", :action => "edit"
  post "/update_payoff/:id", :controller => "payoffs", :action => "update"

  # DELETE
  get "/delete_payoff/:id", :controller => "payoffs", :action => "destroy"
  #------------------------------

  # Routes for the Registration resource:
  # CREATE
  get "/registrations/new", :controller => "registrations", :action => "new"
  post "/create_registration", :controller => "registrations", :action => "create"
  post "/registertourney/", :controller => "registrations", :action => "regtourney"
  post "/flight_golfer/", :controller => "registrations", :action => "flightgolfer"



  # READ
  get "/registrations", :controller => "registrations", :action => "index"
  get "/registrations/:id", :controller => "registrations", :action => "show"

  # UPDATE
  get "/registrations/:id/edit", :controller => "registrations", :action => "edit"
  post "/update_registration/:id", :controller => "registrations", :action => "update"

  # DELETE
  get "/delete_registration/:id", :controller => "registrations", :action => "destroy"
  #------------------------------

  devise_for :users
   root to: "pools#index"


end
