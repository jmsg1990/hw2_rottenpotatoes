class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.get_all_ratings
    @movies = Movie
    if params[:sort_by]
        @movies = @movies.order(params[:sort_by] + " ASC")
          session[:sort_by] = params[:sort_by]
    end
    if params[:ratings]
        @movies = @movies.where(:rating => params[:ratings].keys)
        session[:ratings] = params[:ratings]
    else
        @movies = @movies.all
    end
    flash.keep
    redirect_to  movies_path({ :sort_by => session[:sort_by], :ratings => session[:ratings] }) unless [session[:ratings], session[:sort_by]] == [params[:ratings], params[:sort_by]]
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
