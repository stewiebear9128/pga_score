class GolferResultsController < ApplicationController
  def index
    @golfer_results = GolferResult.all
  end

  def show
    @golfer_result = GolferResult.find(params[:id])
  end

  def new
    @golfer_result = GolferResult.new
  end

  def create
    @golfer_result = GolferResult.new
    @golfer_result.current_payout = params[:current_payout]
    @golfer_result.total_score = params[:total_score]
    @golfer_result.current_place = params[:current_place]
    @golfer_result.tournament_id = params[:tournament_id]
    @golfer_result.golfer_id = params[:golfer_id]

    if @golfer_result.save
      redirect_to "/golfer_results", :notice => "Golfer result created successfully."
    else
      render 'new'
    end
  end

  def edit
    @golfer_result = GolferResult.find(params[:id])
  end

  def update
    @golfer_result = GolferResult.find(params[:id])

    @golfer_result.current_payout = params[:current_payout]
    @golfer_result.total_score = params[:total_score]
    @golfer_result.current_place = params[:current_place]
    @golfer_result.tournament_id = params[:tournament_id]
    @golfer_result.golfer_id = params[:golfer_id]

    if @golfer_result.save
      redirect_to "/golfer_results", :notice => "Golfer result updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @golfer_result = GolferResult.find(params[:id])

    @golfer_result.destroy

    redirect_to "/golfer_results", :notice => "Golfer result deleted."
  end

  def updateleaderboard
    @tournament = params[:tournament_id]
    tourney_key = Tournament.find(@tournament).key

    #go call the correct result tab for the tourney
        #doc = Nokogiri::HTML(open("http://api.sportradar.us/golf-t1/leaderboard/pga/2015/tournaments/" + tourney_key.to_s + "/leaderboard.xml?api_key=tetacypru34zx64bb7b98hxs"))
        doc = Nokogiri::HTML(open(Rails.root.join('lib', 'assets', 'tournamentlbresponse_open.html')))

          doc.xpath("//player").each do |player|

            #if golfer result does not exist on the table, then add a new record, else update existing

            if GolferResult.exists?(Registration.find_by(:golfer_id => Golfer.find_by(:key => player.attr('id')).id, :tournament_id => @tournament))
                  result = GolferResult.find(Registration.find_by(:golfer_id => Golfer.find_by(:key => player.attr('id')).id, :tournament_id => @tournament))
                  result.total_score = player.attr('score')
                  result.current_place = player.attr('position')
                  result.status = player.attr('status')
                  result.tournament_id = @tournament
                  result.save
            else
                  result = GolferResult.new
                  result.total_score = player.attr('score')
                  result.current_place = player.attr('position')
                  result.reg_id = Registration.find_by(:golfer_id => Golfer.find_by(:key => player.attr('id')).id, :tournament_id => @tournament).id
                  result.status = player.attr('status')
                  result.tournament_id = @tournament

                  result.save
            end
          end #added

            #update payoffs
            #create an array of all registrations for a tournament [reg_id, current place, payoff]
            @result_tourn = GolferResult.where(tournament_id: @tournament).order(current_place:  :asc)
            #create an array of all payoffs for this tournament []
            #determines if tourney is special payout or standard, if special (id=22 and is masters, otherwise ID=1)
            if @tournament == 22
              @payoff_tourn = Payoff.where(tournament_id: @tournament)
            else
              @payoff_tourn = Payoff.where(tournament_id: 1)
            end



            #k = 1 #occurrance counter
            j = 0 #current place
            tiepayout = 0.0
            sumofpayout = 0.0

            #loop through all results_tourn.
            @result_tourn.each do |place|

              if  place.current_place+2 <= @result_tourn.length
              duplicate = (place.current_place == @result_tourn.find(place.id + 1).current_place)
              else
              duplicate = false
              end

            #if player is cut or WD, then make their payout 0
             if place.status != nil
                @up = GolferResult.find(place.id)
                @up.current_payout = 0.0
                @up.save
            #
              elsif duplicate
                #idenfity how many times it duplicates
                times = @result_tourn.group(:current_place).where(:current_place => place.current_place).count
                #loop through number of times, add the payoffs from the table, divide by number of times
                for i in 0..(times[place.current_place].to_i-1) do
                    sumofpayout = sumofpayout + @payoff_tourn.find_by(:place => place.current_place+i).payout
                end
                tiepayout = sumofpayout/times[place.current_place].to_i

                #update the j counter to place + occurences+1
                for k in 0..(times[place.current_place].to_i-1) do
                  @up = GolferResult.find(place.id+k)
                  @up.current_payout = tiepayout
                  @up.save
                  j = j + 1
                end
                sumofpayout = 0.0

                #there is a bug here, the conditional below will evaluate to false after the first duplicate
              elsif place.current_place >= j
                @up = GolferResult.find(place.id)
                @up.current_payout = @payoff_tourn.find_by(:place => place.current_place).payout
                @up.save
                j = place.current_place + 1
              end

            end


        #removed here

    redirect_to "/golfer_results", :notice=> "Tournament leaderboard updated for: " + Tournament.find(@tournament).name
  end


end
