class RegistrationsController < ApplicationController
  def index
    @registrations = Registration.all
  end

  def show
    @registration = Registration.find(params[:id])
  end

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new
    @registration.tournament_id = params[:tournament_id]
    @registration.golfer_id = params[:golfer_id]

    if @registration.save
      redirect_to "/registrations", :notice => "Registration created successfully."
    else
      render 'new'
    end
  end

  def edit
    @registration = Registration.find(params[:id])
  end

  def update
    @registration = Registration.find(params[:id])

    @registration.tournament_id = params[:tournament_id]
    @registration.golfer_id = params[:golfer_id]

    if @registration.save
      redirect_to "/registrations", :notice => "Registration updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @registration = Registration.find(params[:id])

    @registration.destroy

    redirect_to "/registrations", :notice => "Registration deleted."
  end

  def regtourney
    @tournament = params[:tournament_id]
    tourney_key = Tournament.find(@tournament).key

      #go call the correct result tab for the tourney

       doc = Nokogiri::HTML(open("http://api.sportradar.us/golf-t1/leaderboard/pga/2015/tournaments/" + tourney_key.to_s + "/leaderboard.xml?api_key=tetacypru34zx64bb7b98hxs"))
       #doc = Nokogiri::HTML(open(Rails.root.join('lib', 'assets', 'tournamentlbresponse_masters.html')))
        k = 0

      #loop through all players in tab
        #if tourney ID and player ID are unique, then add
          doc.xpath("//player").each do |player|

              #create new golfer registration
                reg = Registration.new

                reg.tournament_id = @tournament
                reg.golfer_id = Golfer.find_by(:key => player.attr('id')).id

                #checks to see if key is unique, if yes, it is saved, if not it is skipped - in the future should put this check up top for performance
                if reg.try(:save)
                  k = k+1
                end
           end


    redirect_to "/registrations", :notice=> "Tournament was: " + Tournament.find(@tournament).name
  end

  def flightgolfer
    @tournament_id = params[:tournament_id2]

    doc = Nokogiri::HTML(open("http://api.sportradar.us/golf-t1/seasontd/pga/2015/players/statistics.xml?api_key=tetacypru34zx64bb7b98hxs"))
        #doc = Nokogiri::HTML(open(Rails.root.join('lib', 'assets', 'playerstatistics.html')))

         doc.xpath("//player").each do |player|

           golfer = Golfer.find_by(:key => player.attr('id'))
            if Registration.find_by(:golfer_id => golfer.id, :tournament_id => @tournament_id) != nil
               reg = Registration.find_by(golfer_id: golfer.id, tournament_id: @tournament_id)

               player.xpath(".//statistics").each do |stat|
                  reg.wg_ranking = stat.attr('world_rank')
                end
               reg.save
              end
        end

        Registration.where(tournament_id: @tournament_id).each do |regcheck|

          if regcheck.wg_ranking == nil
            regcheck.wg_ranking = 1500
          end
          regcheck.save
        end

        #flight the golfers based on:
          #A top 10
          orderedlist = Registration.where(tournament_id: @tournament_id).order(wg_ranking: :asc)
          k =0
          orderedlist.each do |reg|
            reg_update = Registration.find(reg.id)
            if k <= 10
              reg_update.flight = 1
            elsif k <=25
              reg_update.flight = 2
            elsif k <=50
              reg_update.flight = 3
            else
              reg_update.flight = 4
            end
            reg_update.save
            k = k + 1
          end
          #B 11 - 25
          #C 25-50
          #D 50 - end

        redirect_to "/registrations", :notice=> "Golfers flighted for: " + Tournament.find(@tournament_id).name


  end

end
