# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController

  def index
    session[:ratings] = [ 'G', 'R', 'PG-13' , 'PG', 'NC-17'];
    sby = params[:sort_by]
    @slite = "no"
    @drel = "no"
    @all_ratings = ['G','PG','PG-13','R','NC-17']
    disrat = params[:ratings]

    if session[:sort_by]!=sby
      session[:sort_by] = sby
    end
    if session[:ratings]!=disrat
      session[:ratings]=disrat
    end
    if sby == nil && disrat == nil && session[:sort_by] != nil
      sby = session[:sort_by]
    end
     if sby == nil && disrat != nil && session[:ratings] != nil
      disrat = session[:ratings]
    end

    if sby == "title" && disrat == nil
      if session[:ratings] != nil
      @movies = Movie.find(:all,:conditions => {:rating => session[:ratings].keys},:order => "title")
      else 
      @movies = Movie.find(:all,:order => "release_date")
      end
      @slite = "hilite"
      session[:sort_by] = "title"
    elsif sby == "release_date" && disrat == nil
      if session[:ratings] != nil
      @movies = Movie.find(:all,:conditions => {:rating => session[:ratings].keys},:order => "release_date")
      else 
      @movies = Movie.find(:all,:order => "release_date")
      end
      session[:sort_by] = "release_date"
      @drel = "hilite"
    elsif sby == nil && disrat != nil
      if session[:sort_by] != nil
      @movies = Movie.find(:all, :conditions => {:rating => disrat.keys},:order => session[:sort_by])
      else 
      @movies = Movie.find(:all, :conditions => {:rating => disrat.keys})
      end
      session[:ratings] = disrat
    elsif sby == "title" && disrat != nil
      @movies = Movie.find(:all, :conditions => {:rating => disrat.keys},:order => "title")
      @slite = "hilite"
      session[:sort_by] = "title"
      session[:ratings] = disrat
    elsif sby == "release_date" && disrat != nil
      @movies = Movie.find(:all, :conditions => {:rating => disrat.keys},:order => "release_date")
      @drel = "hilite"
      session[:sort_by] = "release_date"
      session[:ratings] = disrat
    else 
      @movies = Movie.all
    end
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # Look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
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

end
