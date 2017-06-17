defmodule BitcoinTicker do
  @moduledoc false

  alias BitcoinTicker.Tickers, as: T

  def tick(ticker_name) do
    ticker(ticker_name).tick
  end

  defp ticker("liqui"),           do: T.Liqui
  defp ticker("kraken"),          do: T.Kraken
  defp ticker("bitstamp"),        do: T.Bitstamp
  defp ticker("bitfinex"),        do: T.Bitfinex
  defp ticker("gdax"),            do: T.GDAX
  defp ticker("poloniex"),        do: T.Poloniex
  defp ticker("mercado_bitcoin"), do: T.MercadoBitcoin
  defp ticker("foxbit"),          do: T.Foxbit
  defp ticker(_),                 do: T.None
end
