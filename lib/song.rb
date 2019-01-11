class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    song = self.new
    song.save
    song
  end

  def self.new_by_name(name)
    song = self.new
    song.name = name
    song
  end

  def self.create_by_name(name)
    song = new_by_name(name)
    song.save
    song
  end

  def self.find_by_name(name)
    if !self.all.include?(name)
      self.all.select {|song| song.name == name}[0]
    else
      false
    end
  end

  def self.find_or_create_by_name(name)
    self.create_by_name(name)
    self.find_by_name(name)
  end

  def self.alphabetical
    self.all.sort_by do |instance|
      instance.name
    end
  end

  def self.new_from_filename(filename)
    names = []
    removemp3 = filename.chomp(".mp3")
    names = removemp3.split(" - ")
    song = new_by_name(names[1])
    song.artist_name = names[0]
    song
  end

  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    song.save
  end

  def self.destroy_all
    @@all.clear
  end
end
