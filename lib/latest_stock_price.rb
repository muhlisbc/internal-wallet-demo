class LatestStockPrice
  def initialize(rapid_api_key:)
    @rapid_api_key = rapid_api_key
  end

  def price(indices:, identifier: nil)
    query = { "Indices" => indices }

    if identifier.present?
      query["Identifier"] = identifier
    end

    HTTParty.get("https://latest-stock-price.p.rapidapi.com/price", query: query, headers: headers)
  end

  def prices(indices:, identifier: nil) # same as price?
    price(indices: indices, identifier: identifier)
  end

  def price_all(identifier: nil)
    query = {}

    if identifier.present?
      query["Identifier"] = identifier
    end    

    HTTParty.get("https://latest-stock-price.p.rapidapi.com/any", query: query, headers: headers)
  end

  private

  def headers
    {
      "X-RapidAPI-Key" => @rapid_api_key,
      "X-RapidAPI-Host" => "latest-stock-price.p.rapidapi.com"
    }
  end
end