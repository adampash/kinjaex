defmodule Kinja.WriteTest do
  @moduledoc """
  Test Kinja.Write
  """

  use ExUnit.Case

  setup do
    user = System.get_env("KINJA_USER")
    pass = System.get_env("KINJA_PASS")
    blog_id = System.get_env("BLOG_ID")
    {:ok, %{user: user, pass: pass, blog_id: blog_id}}
  end

  test "can create a post", %{user: user, pass: pass, blog_id: blog_id} do
    post = Kinja.Write.create_post(%{
      user: user,
      pass: pass,
      headline: "Foo",
      body: """
      This is some text.

      Now here is more text.
      """,
      status: "DRAFT",
      replies: false,
      defaultBlogId: blog_id,
    })

    assert post.status_code == 200
  end

end
