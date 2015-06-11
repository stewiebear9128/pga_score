require 'open-uri'

class GolfersController < ApplicationController
  def index
    @golfers = Golfer.all
  end

  def show
    @golfer = Golfer.find(params[:id])
  end

  def new
    @golfer = Golfer.new
  end

  def create
    @golfer = Golfer.new
    @golfer.picture = params[:picture]
    @golfer.name = params[:name]
    @golfer.key = params[:key]

    if @golfer.save
      redirect_to "/golfers", :notice => "Golfer created successfully."
    else
      render 'new'
    end
  end

  def edit
    @golfer = Golfer.find(params[:id])
  end

  def update
    @golfer = Golfer.find(params[:id])

    @golfer.picture = params[:picture]
    @golfer.name = params[:name]
    @golfer.key = params[:key]

    if @golfer.save
      redirect_to "/golfers", :notice => "Golfer updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @golfer = Golfer.find(params[:id])

    @golfer.destroy

    redirect_to "/golfers", :notice => "Golfer deleted."
  end
  def update_golfer_table
    #pull in data from API and parse the XML
    doc = Nokogiri::HTML(open("http://api.sportradar.us/golf-t1/profiles/pga/2015/players/profiles.xml?api_key=tetacypru34zx64bb7b98hxs"))
    #doc = Nokogiri::HTML(open(Rails.root.join('lib', 'assets', 'playerresponse.html')))
      k = 0
      y = 0
    #loop through each player to see who to add
     doc.xpath("//player").each do |player|


      #create new golfer
        golfer = Golfer.new

        golfer.name = player.attr('first_name')
        golfer.key = player.attr('id')
        golfer.lastname = player.attr('last_name')
        golfer.height = player.attr('height')
        golfer.weight = player.attr('weight')
        golfer.birthday = player.attr('birthday')
        golfer.country = player.attr('country')
        golfer.college = player.attr('college')
        golfer.birthplace = player.attr('birth_place')
        golfer.turned_pro = player.attr('turned_pro')

        #checks to see if key is unique, if yes, it is saved, if not it is skipped - in the future should put this check up top for performance
        if golfer.try(:save)
          k = k+1
        end

   end

      #loop through table again to see if any golfers had their records updated since the last call.  If so, update the records.
      doc.xpath("//player").each do |player|
          golfer = Golfer.find_by(:key => player.attr('id'))
        if golfer.updated_at <= player.attr('updated')
          golfer.name = player.attr('first_name')
          golfer.key = player.attr('id')
          golfer.lastname = player.attr('last_name')
          golfer.height = player.attr('height')
          golfer.weight = player.attr('weight')
          golfer.birthday = player.attr('birthday')
          golfer.country = player.attr('country')
          golfer.college = player.attr('college')
          golfer.birthplace = player.attr('birth_place')
          golfer.turned_pro = player.attr('turned_pro')
          if golfer.save
          y = y+1
          end
        end
      end

    redirect_to "/golfers", :notice => k.to_s + " Golfers created successfully. " + y.to_s + " Golfers updated successfully."
  end



end
