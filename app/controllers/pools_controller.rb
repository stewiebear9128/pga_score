class PoolsController < ApplicationController
  def index
    @pools = Pool.all
  end

  def show
    @pool = Pool.find(params[:id])
  end

  def new
    @pool = Pool.new
  end

  def create
    @pool = Pool.new
    @pool.tournament_id = params[:tournament_id]
    @pool.owner_id = params[:owner_id]
    @pool.name = params[:name]

    if @pool.save
      redirect_to "/pools", :notice => "Pool created successfully."
    else
      render 'new'
    end
  end

  def edit
    @pool = Pool.find(params[:id])
  end

  def update
    @pool = Pool.find(params[:id])

    @pool.tournament_id = params[:tournament_id]
    @pool.owner_id = params[:owner_id]
    @pool.name = params[:name]

    if @pool.save
      redirect_to "/pools", :notice => "Pool updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @pool = Pool.find(params[:id])

    @pool.destroy

    redirect_to "/pools", :notice => "Pool deleted."
  end

  def updatepoolresults
      @pool = Pool.find(params[:id])
      @tournament = @pool.tournament_id

      #loop through each entry in pool
      Entry.where(pool_id: @pool.id).each do |submission|
        #sum the current_payout for the five entries
        payout = 0
        payout = payout + GolferResult.find_by(:reg_id => Registration.find_by(:golfer_id => submission.golfer_a, :tournament_id=> @tournament).id).current_payout
        payout = payout + GolferResult.find_by(:reg_id => Registration.find_by(:golfer_id => submission.golfer_b, :tournament_id=> @tournament).id).current_payout
        payout = payout + GolferResult.find_by(:reg_id => Registration.find_by(:golfer_id => submission.golfer_c, :tournament_id=> @tournament).id).current_payout
        payout = payout + GolferResult.find_by(:reg_id => Registration.find_by(:golfer_id => submission.golfer_d, :tournament_id=> @tournament).id).current_payout
        payout = payout + GolferResult.find_by(:reg_id => Registration.find_by(:golfer_id => submission.golfer_flex, :tournament_id=> @tournament).id).current_payout
         entry_to_update = Entry.find(submission.id)
         entry_to_update.current_payoff = payout

        entry_to_update.save
      end

      #loop through entries in the pool again, this time set current place based on highest payoff
      @seeds = Entry.where(pool_id: @pool.id).order(current_payoff:  :desc)
      i = 1
      last_payout = 0
      @seeds.each do |seed|
        entry_to_update = Entry.find(seed.id)
        if seed.current_payoff == last_payout
          entry_to_update.current_place = i-1
        else
          entry_to_update.current_place = i
        end
        i = i +1
        last_payout = seed.current_payoff
        entry_to_update.save

      end

      @seeds = Entry.where(pool_id: 1).order(current_payoff:  :asc)
      redirect_to "/pools/" +@pool.id.to_s

  end


end
