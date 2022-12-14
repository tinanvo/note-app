################ INDEX #################
get '/' do
  notes = all_notes()
  
  erb :'/notes/index', locals: {
    notes: notes
  }
end

################ NOTES #################
get '/notes/new-note' do
  erb :'/notes/new-note'
end

post '/notes/new-note' do
  date = params['date']
  title = params['title']
  note = params['note']
  note_type = "note"
  temp_note = false
  user_id = session['user_id'].to_i
  favourite = params['favourite']
  
  create_note(date, title, note, note_type, temp_note, user_id, favourite)

  redirect '/sessions/session-index'
end

#### LIST ####
get '/notes/new-list' do
  erb :'/notes/new-list'
end

post '/notes/new-list' do
  date = params['date']
  title = params['title']
  note = params['note']
  note_type = "list"
  temp_note = false
  user_id = session['user_id'].to_i
  favourite = params['favourite']

  params['note'].split('\r').each do |item|
    p item
  end
  
  create_note(date, title, note, note_type, temp_note, user_id, favourite)

  redirect '/sessions/session-index'
end

#### EDIT ####
get '/notes/:id/edit' do
  id = params['id']
  note = get_note(id)

  erb :'notes/edit', locals: {
    note: note
  }
end

put '/notes/:id' do
  id = params['id']
  date = params['date']
  title = params['title']
  note = params['note']

  update_note(id, date, title, note)

  erb :'notes/edit', locals: {
    note: note
  }
  redirect '/sessions/session-index'
end

#### DELETE ####
delete '/notes/:id' do
  id = params['id']

  delete_note(id)

  redirect '/sessions/session-index'
end

#### FAVOURITE ####
put '/notes/:id/fav' do
  id = params['id']

  favourite_note('t' ,id)

  redirect '/sessions/session-index'
end

put '/notes/:id/nofav' do
  id = params['id']

  favourite_note('f' ,id)

  redirect '/sessions/session-index'
end

#### SORT BY ####
put '/sort-by-creation' do
  notes = sort_by_creation()

  erb :'/sessions/session-index', locals: {
    notes: notes
  }
end

put  '/sort-by-date' do
  notes = sort_by_date()

  erb :'/sessions/session-index', locals: {
    notes: notes
  }
end

put '/sort-by-favourite' do
  notes = sort_by_favourite()

  erb :'/sessions/session-index', locals: {
    notes: notes
  }
end

put '/sort-by-latest' do
  notes = sort_by_latest()

  erb :'/sessions/session-index', locals: {
    notes: notes
  }
end

put  '/sort-by-title' do
  notes = sort_by_title()

  erb :'/sessions/session-index', locals: {
    notes: notes
  }
end