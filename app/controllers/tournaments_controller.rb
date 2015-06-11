class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.find(params[:id])
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new
    @tournament.start_time = params[:start_time]
    @tournament.key = params[:key]
    @tournament.name = params[:name]

    if @tournament.save
      redirect_to "/tournaments", :notice => "Tournament created successfully."
    else
      render 'new'
    end
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  def update
    @tournament = Tournament.find(params[:id])

    @tournament.start_time = params[:start_time]
    @tournament.key = params[:key]
    @tournament.name = params[:name]

    if @tournament.save
      redirect_to "/tournaments", :notice => "Tournament updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])

    @tournament.destroy

    redirect_to "/tournaments", :notice => "Tournament deleted."
  end

  def update_tournament_table
      #pull in data from API and parse the XML
    doc = Nokogiri::HTML(open("http://api.sportradar.us/golf-t1/schedule/pga/2015/tournaments/schedule.xml?api_key=tetacypru34zx64bb7b98hxs"))
    #doc = Nokogiri::HTML(open(Rails.root.join('lib', 'assets', 'scheduleresponse.html')))
      k = 0
      y = 0
    #loop through each tournament to see whhat to add
     doc.xpath("//tournament").each do |tournament|


      #create new tournaments
        t = Tournament.new

        t.name = tournament.attr('name')
        t.key = tournament.attr('id')
        t.start_time = tournament.attr('start_date')
        t.end_date = tournament.attr('end_date')
        t.winning_share = tournament.attr('winning_share')
        t.purse = tournament.attr('purse')
        t.venue_name = tournament.attr('venue_name')
        t.venue_city = tournament.attr('venue_city')
        t.venue_state = tournament.attr('venue_state')

        #checks to see if key is unique, if yes, it is saved, if not it is skipped - in the future should put this check up top for performance
        if t.try(:save)
          k = k+1
        end
   end

      #loop through table again to see if any golfers had their records updated since the last call.  If so, update the records.
     doc.xpath("//tournament").each do |tournament|
        t = Tournament.find_by(:key => tournament.attr('id'))
       # if t.updated_at <= tournament.attr('updated')
             t.name = tournament.attr('name')
              t.key = tournament.attr('id')
              t.start_time = tournament.attr('start_date')
              t.end_date = tournament.attr('end_date')
              t.winning_share = tournament.attr('winning_share')
              t.purse = tournament.attr('purse')
              t.venue_name = tournament.attr('venue_name')
              t.venue_city = tournament.attr('venue_city')
              t.venue_state = tournament.attr('venue_state')
          if t.save
          y = y+1
        end
        #end
      end


    redirect_to "/tournaments", :notice => k.to_s + " Tournaments created successfully. " + y.to_s + " Tournaments updated successfully."
  end

end
#
