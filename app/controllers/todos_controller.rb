require 'icalendar'

class TodosController < ApplicationController
  # GET /todos
  # GET /todos.xml
  def index
    @todos = Todo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @todos }
    end
  end

  # GET /todos/1
  # GET /todos/1.xml
  def show
    @todo = Todo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.xml
  def new
    @todo = Todo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = Todo.find(params[:id])
  end

  # POST /todos
  # POST /todos.xml
  def create
    @todo = Todo.new(params[:todo])

    respond_to do |format|
      if @todo.save
        format.html { redirect_to(@todo, :notice => 'Todo was successfully created.') }
        format.xml  { render :xml => @todo, :status => :created, :location => @todo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.xml
  def update
    @todo = Todo.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to(@todo, :notice => 'Todo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.xml
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to(todos_url) }
      format.xml  { head :ok }
    end
  end
  
  def feed
    respond_to do |format|
      format.ics { render :text => self.generate_ical }
    end
  end
  
  def generate_ical
    @todos = Todo.all
    
    cal = Icalendar::Calendar.new
    cal.custom_property("METHOD","PUBLISH")
    @todos.each do |todo|
       event = Icalendar::Event.new 
       event.dtstart = todo.due.strftime("%Y%m%dT%H%M%S")
       event.dtend = todo.due.strftime("%Y%m%dT%H%M%S")
       event.summary = todo.summary     
       event.description = todo.description
       event.klass = "PUBLIC"       
       #event.transp = "TRANSPARENT"
       #event.location = "Manhattan Office"   
       #event.priority = 5       
       cal.add_event(event)
    end
    headers['Content-Type'] = "text/calendar; charset=UTF-8"
    cal.publish
    cal.to_ical
    
  end
end
