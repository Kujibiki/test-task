defmodule MyappWeb.GradeController do
  use MyappWeb, :controller

  alias Myapp.Grades
  alias Myapp.Grades.Grade

  action_fallback MyappWeb.FallbackController

  def index(conn, _params) do
    grades = Grades.list_grades()
    render(conn, :index, grades: grades)
  end

  def create(conn, %{"grade" => grade_params}) do
    with {:ok, %Grade{} = grade} <- Grades.create_grade(grade_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/grades/#{grade}")
      |> render(:show, grade: grade)
    end
  end

  def show(conn, %{"id" => id}) do
    grade = Grades.get_grade!(id)
    render(conn, :show, grade: grade)
  end

  def update(conn, %{"id" => id, "grade" => grade_params}) do
    grade = Grades.get_grade!(id)

    with {:ok, %Grade{} = grade} <- Grades.update_grade(grade, grade_params) do
      render(conn, :show, grade: grade)
    end
  end

  def delete(conn, %{"id" => id}) do
    grade = Grades.get_grade!(id)

    with {:ok, %Grade{}} <- Grades.delete_grade(grade) do
      send_resp(conn, :no_content, "")
    end
  end
end
