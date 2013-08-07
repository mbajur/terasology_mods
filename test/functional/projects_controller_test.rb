require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, project: { description: @project.description, forks_count: @project.forks_count, g_id: @project.g_id, g_updated_at: @project.g_updated_at, homepage: @project.homepage, name: @project.name, open_issues_count: @project.open_issues_count, url: @project.url, watchers_count: @project.watchers_count }
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project" do
    get :show, id: @project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project
    assert_response :success
  end

  test "should update project" do
    put :update, id: @project, project: { description: @project.description, forks_count: @project.forks_count, g_id: @project.g_id, g_updated_at: @project.g_updated_at, homepage: @project.homepage, name: @project.name, open_issues_count: @project.open_issues_count, url: @project.url, watchers_count: @project.watchers_count }
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end
end
