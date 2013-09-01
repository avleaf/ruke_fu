Feature.new do |feature|
  feature.description = "In order to test RukeFu, the application must sort scenarios, into features"
  feature.tags        = %w[ @feature @level @tags ]
  feature.short_name  = "testing_sample"
end

Scenario.new do |scenario|
  scenario.name    = "Testing RukeFu file processing"
  scenario.options = { }
  scenario.tags    = %w[ ]
  scenario.steps   = %w[
  Given goto home_page 
  Then on home_page
  ]
end


Scenario.new do |s|
  s.name    = "Testing two rufu scenarios"
  s.options = { :option => 1 }
  s.tags    = %w[ @this @will @automatically @become @an @array ]
  s.steps   = %w[
  Given goto home_page 
  Then on home_page
  ]
end
