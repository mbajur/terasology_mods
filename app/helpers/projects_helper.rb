module ProjectsHelper

	def repository_page_url(project, page)
    "#{project.url}/#{page}"
  end

end
