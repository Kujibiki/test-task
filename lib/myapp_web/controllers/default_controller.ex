defmodule MyappWeb.DefaultController do
  use MyappWeb, :controller

  def index(conn,_params) do
    text conn, "I`m alive - #{Mix.env()}"
  end
end
