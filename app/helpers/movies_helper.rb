module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def link_to_movies_title
  	link_to "Movie Title", movies_path(:order_by=>:title), :id=>:title_header
  end

  def link_to_movies_release_date
  	link_to "Release Date", movies_path(:order_by=>:release_date), :id=>:release_date_header
  end

end
