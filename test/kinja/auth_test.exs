defmodule Kinja.AuthTest do
  @moduledoc """
  Kinja tests
  """

  use ExUnit.Case
  doctest Kinja

  setup do
    user = System.get_env("KINJA_USER")
    pass = System.get_env("KINJA_PASS")
    {:ok, %{user: user, pass: pass}}
  end

  test "logs in with Burner", %{user: user, pass: pass} do
    user = Kinja.Auth.login(user, pass)
    assert user["screenName"] == "gemtest"
  end

  test "fetches an API token", %{user: user, pass: pass} do
    token = Kinja.Auth.api_token(user, pass)
    assert is_binary(token)
  end


end
