# UNDER DEVELOPMENT!!: Working on new input format
amap :lang => 'en',
    :context => 'furniture, home',
    :version => '1' do

  concept do
    names 'chair'
    tags 'single, seat, leg, backrest'
    adef 'Single seat with legs and backrest'
    adef 'Furniture that is placed around the table to sit'
    adef type: 'image_url', 'https://www.portobellostreet.es/imagenes_muebles/Muebles-Silla-colonial-Fusta-Bora-Bora.jpg'
  end

  concept do
    names 'couch'
    tags 'furniture, seat, two, threee, people, bench, armrest'
  end

  concept do
    names 'table'
    tags 'furniture, flat, top, leg, surface, work, eat'
  end

  concept do
    names 'bed'
    tags 'furniture, place, sleep, relax'
  end
end
