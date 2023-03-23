defmodule WeatherApi do
  @url "https://api.weather.gov/gridpoints/TOP/31,80/forecast"
  # @url "https://api.weather-bad123.gov/gridpoints/TOP/31,80/forecast"

  def get_data do
    case Req.get(@url) do
      {:ok, response} -> {:ok, decode_response(response)}
      {:error, error} -> {:error, error}
    end

    # Req.get(@url, retry: false)
    # |> parse_response()
  end

  # def parse_response({:ok, response}) do
  #   {:ok, decode_response(response)}
  # end

  # def parse_response({:error, error}) do
  #   {:error, error}
  # end

  defp decode_response(%{body: %{"properties" => %{"periods" => periods}}}) do
    Enum.sort(periods, fn f, s -> f["number"] < s["number"] end)
    |> hd()
    |> Map.get("detailedForecast")
  end
end
