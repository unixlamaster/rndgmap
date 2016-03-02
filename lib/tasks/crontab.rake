# -*- encoding : utf-8 -*-

def get_line(addr)
  res = Geocoder.search(addr, :bounds => [[50.25,44.35], [45.94,38.24]])
  sleep 3
  if !res.empty?
    f = res[0].data["geometry"]["viewport"]["northeast"]
    l = res[0].data["geometry"]["viewport"]["southwest"]
    "#{f["lat"]}, #{f["lng"]} | #{l["lat"]}, #{l["lng"]}" 
  else
    nil
  end
end

task :update_mapobj => :environment do

    db = SQLite3::Database.new "/home/ror/upload3.sqlite"
#   0         1        2      3      4       5       6      7     8     9
# area_id, type_id, address, name, result, amount, years2, year, cost, url

    db.execute( "select area_id, type_id, address, name, result, amount, years2, year, cost, url FROM objects" ) do |row|
      mm = Mapobj.where(address: row[2], type_id: row[1], area_id: row[0])
      if !mm.empty?
        mm[0].cost = row[8]
        img = case mm[0].type_id 
              when 1
                "/images/voda#{mm[0].id%2}.jpg"
              when 2
                "/images/voda#{mm[0].id%2}.jpg"
              when 3
                "/images/canal#{mm[0].id%2}.jpg"
              when 4
                "/images/canal#{mm[0].id%2}.jpg"
              when 5
                "/images/teplo.jpg"
              when 6
                "/images/tower.jpg"
              when 7 
                "/images/hole.jpg"
              when 8
                "/images/tech.jpg"
              when 9
                "/images/tbo.jpg"
              when 10
                "/images/dom.jpg"
              when 11
                "/images/poh.jpg"
              when 12
                "/images/park.jpg"
              end
        mm[0].url = img
        mm[0].save
        puts "id = #{mm[0].id}"
#        sleep 5
      end
    end
end

task :insert_mapobj => :environment do

  db = SQLite3::Database.new "/home/ror/upload3.sqlite"
#   0         1        2      3      4       5       6      7     8     9
# area_id, type_id, address, name, result, amount, years2, year, cost, url

  db.execute( "select area_id, type_id, address, name, result, amount, years2, year, cost, url FROM objects" ) do |row|
    0.upto(9) {|i| row[i].gsub!(/\n/,'') if row[i].class == String }
    mapobj = Mapobj.new(area_id: row[0],type_id: row[1],address: row[2],name: row[3],result: row[4],amount: row[5], years2: row[6], year: row[7], cost: row[8], url: row[9])

#    mapobj.address = "Ростовская область, " + Area.find(row[0]).name if mapobj.address.nil?

#    mapobj.line = get_line(row[2].split(/,/)[0]) if row[1]== "1" || row[1]== "3" || row[1]== "5"

    mm = Mapobj.where(address: row[2])

    if !mm.empty?
        mapobj.latitude = mm[-1].latitude.to_f + 0.003
        mapobj.longitude = mm[-1].longitude.to_f + 0.003
    end

    mapobj.save
    p row
    sleep 3

  end
end

task :check_coords => :environment do
  Mapobj.all.each do |mo|
    ar = Mapobj.where("ABS(latitude-?)<0.001 AND ABS(longitude-?)<0.001", mo.latitude, mo.longitude)
    f=0.003
    ar.each do |ne|
      ne.latitude = ne.latitude.to_f + f
      ne.longitude = ne.longitude.to_f + f
      ne.save
      f+= 0.003
    end
  end
end

task :show_out => :environment do
  Mapobj.all.each do |mo|
    if (mo.latitude.to_f > 50.25 || mo.latitude.to_f < 45.94 || mo.longitude.to_f > 44.35 || mo.longitude.to_f < 38.24 ) && (mo.type_id == 1 || mo.type_id == 3 || mo.type_id == 5)
#      mo.address.gsub!(/[\r\n]/,'')
#      mo.address = "Ростовская область, " + mo.address 
#      puts mo.address + " coord: #{mo.latitude},#{mo.longitude}"
#      mo.save
#      sleep 5
      puts mo.address
    end
  end
end

def gsearch(mo)
  res = []
  ar =  mo.address.split(/,|\sдо\s|\sот\s|\sпо\s|\sи\s|\n/)
  ar.unshift("г. Ростове-на-Дону") if ar[0]=~/^ул/
  ar[0] = "Ростовская Область, " + ar[0] unless ar[0]=~/Ростовская /
  if ar.length > 1
    ar[1..-1].each {|ul| res.push(ar[0] + ", " + ul) if ul.length>10}
  else
    res.push ar[0]
  end
  res
end
task :search => :environment do
  Mapobj.where(type_id: [1,3,5]).each do |mo|
    ar = gsearch(mo).map do |addr|
           res = Geocoder.search(addr)[0]
           sleep 5
           if !res.nil?
             res = res.data["geometry"]["viewport"] 
             puts "dist = " + Geocoder::Calculations.distance_between([res["northeast"]["lat"],res["northeast"]["lng"]],[res["southwest"]["lat"],res["southwest"]["lng"]]).to_s
             "#{res["northeast"]["lat"]}, #{res["northeast"]["lng"]} | #{res["southwest"]["lat"]}, #{res["southwest"]["lng"]}"
           else
             nil
           end
         end
    mo.line = ar.compact.join(';')
    puts mo.address+" - "+mo.line
    mo.save
    puts "-------------------------"
  end
end
