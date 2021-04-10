defmodule Retro.Phoenix.Plug.MinifyHtmlBodyTest do
  use ExUnit.Case, async: true

  alias Retro.Phoenix.Plug.MinifyHtmlBody

  doctest MinifyHtmlBody

  @body """
  <div>
    <b>foo</b>
    <strong>bar</strong>
  </div>
  """

  describe "minify_body" do
    test "minify response body if content type is text/html" do
      expected = "<div><b>foo</b><strong>bar</strong></div>"

      conn = %Plug.Conn{
        resp_headers: [{"content-type", "text/html"}],
        resp_body: @body
      }

      conn = MinifyHtmlBody.minify_html(conn)
      assert conn.resp_body == expected
    end

    test "it doesn't change the body if content type is not text/html" do
      conn = %Plug.Conn{
        resp_headers: [{"content-type", "text/plain"}],
        resp_body: @body
      }

      conn = MinifyHtmlBody.minify_html(conn)
      assert conn.resp_body == @body
    end
  end
end
