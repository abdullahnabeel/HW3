# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController

  def index
    sby = params[:sort_by]
    @slite = "no"
    @drel = "no"
    @all_ratings = ['G','PG','PG-13','R','NC-17']
    if sby == "title"
      @movies = Movie.find(:all,:order => sby)
      @slite = "hilite"
    elsif sby == "release_date"
      @movies = Movie.find(:all,:order => sby)
      @drel = "hilite"
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
