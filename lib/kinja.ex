defmodule Kinja do
  @moduledoc """
  The Kinja module fetches information about Kinja posts,
  posts to Kinja (limited to Burner accounts), and does
  various other Kinja-related work.

  Functionality is partially implemented as needed.
  """

  use HTTPoison.Base

  @api_root "https://kinja.com/api"
  @create_post_path "/core/post/add"
  @post_path "core/post"
  @blog_path "core/blog"
  @blog_members_path "profile/blogmembership/views/manageBlogMembers?blogId="
  @tag_path "core/tag"
  @blog_profile_path "profile/blog/byhost"
  @author_path "profile/user/views/asAuthor"
  @author_name_path "profile/user/views/byName?name="
  @author_posts_path "core/author"

  @expected_fields ~w(
  author id headline defaultBlogId permalink
  )

  def get_post(id) do
    Kinja.get!("/#{@post_path}/#{id}")
  end

  def process_url(url) do
    @api_root <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Map.get("data")
    |> Map.take(@expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end

end
