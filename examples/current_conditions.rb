require 'owmo'

OWMO::weather :current, city_name: "London,uk", mode: 'json', units: imperial, lang: 'en-US' do |weather|

  OWMO::pretty_json weather

end
