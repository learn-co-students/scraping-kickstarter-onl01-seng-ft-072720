require 'nokogiri'
require "pry"

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i


def create_project_hash #  can be called on with no errors /returns a hash /includes at least five projects
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

 # Iterate through the projects
  kickstarter.css("li.project.grid_4").each do |project| #we're converting the title into a symbol using the to_sym method.
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  #  ^^^ project titles point to a hash of info
  # each project has an image link hosted on AmazonAWS
  # each project has a description which is a string
  # each project has a location which is a string
  # each project has percentage funded listed which is an integer


   # return the projects hash
  projects

end
