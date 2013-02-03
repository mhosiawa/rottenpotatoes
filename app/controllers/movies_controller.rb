class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings=Movie.ratings
    save_params_in_session
    session_redirect
    if params[:ratings]
      if params[:order_by]=='title'
        @order_by=:title
        @movies=Movie.all(:order=>:title, :conditions=>{:rating=> params[:ratings].keys})
      elsif params[:order_by]=='release_date'
        @order_by=:release_date
        @movies=Movie.all(:order=>:release_date, :conditions=>{:rating=> params[:ratings].keys})
      else
        @movies = Movie.all(:conditions=>{:rating=> params[:ratings].keys})
      end
    else
      if params[:order_by]=='title'
        @order_by=:title
        @movies=Movie.all(:order=>:title)
      elsif params[:order_by]=='release_date'
        @order_by=:release_date
        @movies=Movie.all(:order=>:release_date)
      else
        @movies = Movie.all
      end
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private

  def save_params_in_session
    if params[:order_by]
      session[:order_by]=params[:order_by]
    end
    if params[:ratings]
      session[:ratings]=params[:ratings]
    end
  end

  def session_redirect
     if session[:order_by] or session[:ratings]
      if params[:order_by].nil? or params[:ratings].nil?
        redirect_to movies_path(:order_by => session[:order_by], :ratings => session[:ratings])
      end
    end
  end

end
