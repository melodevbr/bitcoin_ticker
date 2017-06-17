# BitcoinTicker

Hi everyone, this lib is in progress yet, but the main goal is help programmers and traders to ticker the bitcoin value in a bunch of currencies. If you have interest in this project, follow it. I'll update here every weekend and publish it as soon as it ready.

## Currencies
Bellow has a table with all sources to check trade rates with BTC
| Currency | Source |
|----------|--------|
|USD| Bitfinex, Bitstamp, GDAX, Kraken, Liqui, Poloniex |
|EUR| Bitstamp, GDAX, Kraken |
|GBP| GDAX, Kraken |
|BRL| MercadoBitcoin, BlinkTrade |
|JPY| Kraken, GDAX |
|CAD| Kraken |
|VEF| BlinkTrade |
|VND| BlinkTrade |
|PKR| BlinkTrade |
|CLP| BlinkTrade |

## How to Use

```elixir
iex> BitcoinTicker.tick(:kraken, "USD")
```

