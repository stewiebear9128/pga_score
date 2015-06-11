class EntriesController < ApplicationController
  def index
    @entries = Entry.all
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def new
    @entry = Entry.new
    @pool_id = Pool.find_by({ :id => params["pool_id"]})
    @regs = Registration.where(tournament_id: @pool_id.tournament.id)
    @options = []
    @optionsA = []
    @optionsB = []
    @optionsC = []
    @optionsD = []
    @optionsF = []
    @regs.each { |option| @options.push([option.golfer.name + " " + option.golfer.lastname, option.golfer_id]) }
    @regs.where(:flight => "1").each { |option| @optionsA.push([option.golfer.name + " " + option.golfer.lastname, option.golfer_id]) }
    @regs.where(:flight => "2").each { |option| @optionsB.push([option.golfer.name + " " + option.golfer.lastname, option.golfer_id]) }
    @regs.where(:flight => "3").each { |option| @optionsC.push([option.golfer.name + " " + option.golfer.lastname, option.golfer_id]) }
    @regs.where(:flight => "4").each { |option| @optionsD.push([option.golfer.name + " " + option.golfer.lastname, option.golfer_id]) }

  end

  def create
    @entry = Entry.new
    @entry.pool_owner = current_user.id
    @entry.pool_id = params[:pool_id]
    @entry.current_payoff = params[:current_payoff]
    @entry.current_place = params[:current_place]
    @entry.golfer_flex = params[:golfer_flex]
    @entry.golfer_d = params[:golfer_d]
    @entry.golfer_c = params[:golfer_c]
    @entry.golfer_b = params[:golfer_b]
    @entry.golfer_a = params[:golfer_a]

    if @entry.try(:save)
      redirect_to "/pools/"+@entry.pool_id.to_s, :notice => "Entry created successfully."
    else
      redirect_to '/entries/new/'+@entry.pool_id.to_s, :alert => "flex golfer must be unique"
    end
  end

  def edit
    @entry = Entry.find(params[:id])
    @regs = Registration.where(tournament_id: @entry.pool.tournament.id)
    @options = []
    @optionsA = []
    @optionsB = []
    @optionsC = []
    @optionsD = []
    @regs.each { |option| @options.push([option.golfer.name + " " + option.golfer.lastname, option.golfer_id]) }
    @regs.where(:flight => "1").each { |option| @optionsA.push([option.golfer.name + " " + option.golfer.lastname, option.golfer_id]) }
    @regs.where(:flight => "2").each { |option| @optionsB.push([option.golfer.name + " " + option.golfer.lastname, option.golfer_id]) }
    @regs.where(:flight => "3").each { |option| @optionsC.push([option.golfer.name + " " + option.golfer.lastname, option.golfer_id]) }
    @regs.where(:flight => "4").each { |option| @optionsD.push([option.golfer.name + " " + option.golfer.lastname, option.golfer_id]) }

  end

  def update
    @entry = Entry.find(params[:id])

    @entry.current_payoff = params[:current_payoff]
    @entry.current_place = params[:current_place]
    @entry.golfer_flex = params[:golfer_flex]
    @entry.golfer_d = params[:golfer_d]
    @entry.golfer_c = params[:golfer_c]
    @entry.golfer_b = params[:golfer_b]
    @entry.golfer_a = params[:golfer_a]

    if @entry.save
      redirect_to "/entries", :notice => "Entry updated successfully."
    else
      redirect_to '/entries/'+@entry.id.to_s+'/edit', :alert => "flex golfer must be unique"
    end
  end

  def destroy
    @entry = Entry.find(params[:id])

    @entry.destroy

    redirect_to "/entries", :notice => "Entry deleted."
  end
end
