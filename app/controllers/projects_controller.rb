class ProjectsController < ApplicationController
  before_filter :get_categories
  before_filter :authenticate_user!, :only => [:edit, :import, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    if params[:q]
      @projects = Project.find_with_index params[:q]
    else
      @projects = Project.order('watchers_count DESC')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /recent
  # GET /projects.json
  def recent
    @projects = Project.order('created_at DESC')
    render action: 'index'
  end

  # GET /recent
  # GET /projects.json
  def updated
    @projects = Project.order('g_updated_at DESC')
    render action: 'index'
  end

  def category
    @tag      = ActsAsTaggableOn::Tag.find(params[:category_id])
    @projects = Project.tagged_with(@tag.name, :on => :categories)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new
    @repos = Octokit.repositories current_user.services.first.uname

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # GET /projects/import/:id
  # GET /projects/import/:id.json
  def import
    @project = Project.new
    @repos   = Octokit.repositories current_user.services.first.uname
    @repo    = Octokit.repo params[:username] + '/' + params[:name]

    # Prevent user from adding repos that don't belongs to him.
    if current_user.services.first.uid.to_i != @repo.owner.id
      redirect_to new_project_path, notice: 'You can import only your repos.'
      return
    end

    @project.g_id              = @repo.id
    @project.name              = @repo.name
    @project.full_name         = @repo.full_name
    @project.description       = @repo.description
    @project.url               = @repo.html_url
    @project.homepage          = @repo.homepage
    @project.forks_count       = @repo.forks_count
    @project.watchers_count    = @repo.watchers_count
    @project.open_issues_count = @repo.open_issues_count
    @project.g_updated_at      = @repo.updated_at
    @project.user              = current_user

    respond_to do |format|
      if @project.save
        format.html { redirect_to edit_project_path(@project), notice: 'Project was successfully imported.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private
  def get_categories
    @categories = Project.tag_counts_on(:categories)
  end
end
