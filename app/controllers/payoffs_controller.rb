class PayoffsController < ApplicationController
  def index
    @payoffs = Payoff.all
  end

  def show
    @payoff = Payoff.find(params[:id])
  end

  def new
    @payoff = Payoff.new
  end

  def create
    @payoff = Payoff.new
    @payoff.payout = params[:payout]
    @payoff.place = params[:place]
    @payoff.tournament_id = params[:tournament_id]

    if @payoff.save
      redirect_to "/payoffs", :notice => "Payoff created successfully."
    else
      render 'new'
    end
  end

  def edit
    @payoff = Payoff.find(params[:id])
  end

  def update
    @payoff = Payoff.find(params[:id])

    @payoff.payout = params[:payout]
    @payoff.place = params[:place]
    @payoff.tournament_id = params[:tournament_id]

    if @payoff.save
      redirect_to "/payoffs", :notice => "Payoff updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @payoff = Payoff.find(params[:id])

    @payoff.destroy

    redirect_to "/payoffs", :notice => "Payoff deleted."
  end
end
