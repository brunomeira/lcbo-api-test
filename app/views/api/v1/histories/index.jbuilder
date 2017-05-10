json.histories(@histories) do |history|
	history.data.each do |k, v|
		json.set! k, v
	end
end
