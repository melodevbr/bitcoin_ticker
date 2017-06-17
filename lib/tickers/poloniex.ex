defmodule BitcoinTicker.Tickers.Poloniex do
  import BitcoinTicker.Tickers.Common.Validator
  @moduledoc """
      Poloniex Ticker Adapter
  """

  @ticker_url "https://poloniex.com/public?command=returnTicker"

  def tick do
    validate_currency(["USD"], currency)
    response = HTTPotion.get @ticker_url

    with {:ok, result} <- JSON.decode(response.body),
         do: transform(result["USDT_BTC"])
  end

  def provider, do: 'poloniex'

  defp transform(result) do
    {:ok, %{
      "average"    => result["last"],
      "buy"        => result["highestBid"],
      "sell"       => result["lowestAsk"],
      "last"       => result["last"],
      "high"       => result["high24hr"],
      "low"        => result["low24hr"],
      "updated_at" => :os.system_time(:milli_seconds)
    }}
  end
end
