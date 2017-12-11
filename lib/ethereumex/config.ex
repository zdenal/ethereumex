defmodule Ethereumex.Config do
  @moduledoc false

  @spec rpc_url() :: binary()
  def rpc_url do
    if url = Application.get_env(:ethereumex, :url) do
      url
    else
      "#{scheme()}://#{host()}:#{port()}"
    end
  end

  @spec scheme() :: binary()
  defp scheme do
    env_var!(:scheme)
  end

  @spec host() :: binary()
  defp host do
    env_var!(:host)
  end

  @spec port() :: integer()
  defp port do
    env_var!(:port)
  end

  @spec http_options() :: keyword()
  def http_options do
    Application.get_env(:ethereumex, :http_options, [])
  end

  @spec env_var!(atom()) :: binary() | integer()
  defp env_var!(var) do
    value = Application.fetch_env!(:ethereumex, var)

    if is_nil(value), do: raise ArgumentError, message: "#{var} is not provided!"

    value
  end
end
