
class BlastsController < ApplicationController
  # GET /blasts/1
  def show
    @blast = Blast.find_by_marketing_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def wantmore2
  	@blast = Blast.find_by_marketing_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def wantmore3
  	@blast = Blast.find_by_marketing_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def wantmore4
  	@blast = Blast.find_by_marketing_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def wantmore5
    @blast = Blast.find_by_marketing_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def wantmore6
    @blast = Blast.find_by_marketing_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def wantmore7
    @blast = Blast.find_by_marketing_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def wantmore8
    @blast = Blast.find_by_marketing_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def wantmore9
    @blast = Blast.find_by_marketing_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def follow_up
    @blast = Blast.find_by_marketing_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  
end