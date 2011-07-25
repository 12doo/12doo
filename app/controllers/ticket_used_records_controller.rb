class TicketUsedRecordsController < ApplicationController
  # GET /ticket_used_records
  # GET /ticket_used_records.xml
  def index
    @ticket_used_records = TicketUsedRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ticket_used_records }
    end
  end

  # GET /ticket_used_records/1
  # GET /ticket_used_records/1.xml
  def show
    @ticket_used_record = TicketUsedRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ticket_used_record }
    end
  end

  # GET /ticket_used_records/new
  # GET /ticket_used_records/new.xml
  def new
    @ticket_used_record = TicketUsedRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticket_used_record }
    end
  end

  # GET /ticket_used_records/1/edit
  def edit
    @ticket_used_record = TicketUsedRecord.find(params[:id])
  end

  # POST /ticket_used_records
  # POST /ticket_used_records.xml
  def create
    @ticket_used_record = TicketUsedRecord.new(params[:ticket_used_record])

    respond_to do |format|
      if @ticket_used_record.save
        format.html { redirect_to(@ticket_used_record, :notice => 'Ticket used record was successfully created.') }
        format.xml  { render :xml => @ticket_used_record, :status => :created, :location => @ticket_used_record }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ticket_used_record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ticket_used_records/1
  # PUT /ticket_used_records/1.xml
  def update
    @ticket_used_record = TicketUsedRecord.find(params[:id])

    respond_to do |format|
      if @ticket_used_record.update_attributes(params[:ticket_used_record])
        format.html { redirect_to(@ticket_used_record, :notice => 'Ticket used record was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ticket_used_record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_used_records/1
  # DELETE /ticket_used_records/1.xml
  def destroy
    @ticket_used_record = TicketUsedRecord.find(params[:id])
    @ticket_used_record.destroy

    respond_to do |format|
      format.html { redirect_to(ticket_used_records_url) }
      format.xml  { head :ok }
    end
  end
end
