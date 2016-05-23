defmodule Kinja.Auth do
  @moduledoc """
  Handles authorization for Kinja client
  """

  use HTTPoison.Base

  @api_root "https://kinja.com/api"
  @login_path "/profile/session/burnerLogin"
  @token_path "/profile/token/create"

  def login(user, pass, extract \\ true) do
    "#{@api_root}#{@login_path}"
    |> Kinja.Auth.post!(
        %{screenName: user, token: pass},
        %{"Content-Type" => "application/json"}
      )
    |> return_user(extract)
  end

  def return_user(data, false), do: data
  def return_user(data, true) do
    data
    |> Map.get(:body, :empty)
    |> Map.get("data", :empty)
  end

  def api_token(user, pass) do
    login(user, pass, false)
    |> session_token
    |> fetch_api_token
  end

  def fetch_api_token(token) do
    "#{@api_root}#{@token_path}"
    |> Kinja.Auth.post!(
        %{},
        [],
        hackney: [cookie: ["KinjaSession=#{token};"]]
       )
    |> Map.get(:body, :empty)
    |> Map.get("data", :empty)
    |> Map.get("token")
  end

  def session_token(%{headers: headers}) do
    re = ~r{KinjaSession=([\w-]+);}i

    "KinjaSession=" <> token =
      headers
      |> Enum.find(fn {k, v} -> k == "Set-Cookie" && String.match?(v, re) end)
      |> elem(1)
      |> String.split(";")
      |> hd

    token
  end


  def process_request_body(body) do
    Poison.encode!(body)
  end

  def process_response_body(body) do
    try do
      body
      |> Poison.decode!
    rescue
      _ -> body
    end
  end

end
