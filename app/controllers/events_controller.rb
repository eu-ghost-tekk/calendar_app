class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(title: event_params[:title],
                       description: event_params[:description],
                       start_date: make_start_date(event_params),
                       end_date: make_end_date(event_params))

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: '予定を登録しました．' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(title: event_params[:title],
                      description: event_params[:description],
                      start_date: make_start_date(event_params),
                      end_date: make_end_date(event_params))
        format.html { redirect_to @event, notice: '予定を更新しました．' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: '予定を削除しました．' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :start_date, :s1)
    end

    def make_start_date(ep)
      DateTime.parse("#{ep["start_date(1i)"]}/#{ep["start_date(2i)"]}/#{ep["start_date(3i)"]} #{ep[:s1]}")
    end

    def make_end_date(event_params)
      start_date = make_start_date(event_params)
      if event_params[:s1].in?(["12:00", "21:10"])
        start_date + 1.hours
      else
        start_date + 1.hour + 30.minute
      end
    end
end
