defmodule KinjaTest do
  @moduledoc """
  Kinja tests
  """

  use ExUnit.Case
  doctest Kinja

  test "fetching a blog post" do
    # http://gawker.com/san-francisco-nimbys-may-be-sacrificed-so-that-housing-1778151300
    %{body: post} = Kinja.get_post("1778151300") #.body[:public_repos]
    assert post[:headline] == "San Francisco NIMBYs May Be Sacrificed So That Housing Can Live"
    assert post[:defaultBlogId] == 7
    assert post[:author]["displayName"] == "Hamilton Nolan"
    assert post[:permalink] == "http://gawker.com/san-francisco-nimbys-may-be-sacrificed-so-that-housing-1778151300"
  end

end
