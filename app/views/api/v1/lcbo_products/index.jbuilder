json.lcbo_products(@products) do |product|
	json.partial! 'api/v1/lcbo_products/lcbo_product', lcbo_product: product
end
