defmodule Kinja.Write do
  @moduledoc """
  This module manages the creation and updating of
  posts on Kinja.
  """

  use HTTPoison.Base

  alias Kinja.Auth

  @api_root "https://kinja.com/api"
  @create_post_path "/core/post/add"

  def create_post(%{user: user, pass: pass} = opts) do
    token = Auth.api_token(user, pass)
    params =
      opts
      |> Map.put(:status, opts[:status] || "DRAFT")
      |> Map.put(:replies, opts[:replies] || true)
      |> Map.put(:defaultBlogId, String.to_integer(opts[:defaultBlogId])) # || get_default_blog_id)
      |> Map.put(:original, opts[:body])

    url = @api_root <> @create_post_path

    url
    |> Kinja.Write.post!(
        params,
        %{"Content-Type" => "application/json"},
        [params: [token: token]]
      )
  end

  def process_request_body(body) do
    Poison.encode!(body)
  end

end
