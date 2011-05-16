class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :name
      t.text :description
      t.boolean :active, :default => true
      t.decimal :lat, :default => 0, :precision => 20, :scale => 10
      t.decimal :lon, :default => 0, :precision => 20, :scale => 10
      t.decimal :end_lat, :default => 0, :precision => 20, :scale => 10
      t.decimal :end_lon, :default => 0, :precision => 20, :scale => 10
      t.datetime :capture_date

      t.timestamps
    end
    add_column :images, :site_id, :integer

    # make a record for each site -- previously these were just read from the directory
    Site.all.each do |site|
	s = Site.new({ :name => site[0] })
	s.save
    end
    # add a site_id for each image
    i = Image.find :all
    i.each do |image|
	image.site_id = Site.find_by_name(image.sitename).id
	image.save
    end
    # move all thumbnail directories to their new home in /public/thumbnails
    Dir.mkdir('public/thumbnails') unless File.exists?('public/thumbnails')
    `mv public/sites/*_thumb/ public/thumbnails/`
    Dir.glob("public/thumbnails/*_thumb").each do |thumb|
	puts thumb[0..-7]
	system("mv "+thumb+" "+thumb[0..-7])
    end

  end

  def self.down
    drop_table :sites
    remove_column :images, :site_id
  end
end
