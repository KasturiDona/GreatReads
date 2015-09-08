  Goodreads.configure(
    :api_key => ENV['GOODREADS_API'],
    :api_secret => ENV['GOODREADS_SECRET']
  )

  $good_reads_client = Goodreads.new