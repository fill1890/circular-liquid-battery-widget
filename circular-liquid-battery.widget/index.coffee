command: "pmset -g batt | grep \"%\" | awk 'BEGINN { FS = \";\" };{ print $3,$2 }' | sed -e 's/-I/I/' -e 's/-0//' -e 's/;//' -e 's/;//'"

refreshFrequency: 20000

render: () ->
  $('head').append('''
      <link rel="stylesheet" href="circular-liquid-battery.widget/cb.css" type="text/css" /><link href="http://fonts.googleapis.com/css?family=Dosis:200,300" rel="stylesheet" type="text/css">
    ''')
  '<div id="batt"></div>'

update: (output) ->
  outputParts = output.split(' ')
  percent = parseInt(outputParts[1].split('%')[0])
  source = outputParts[0]

  console.log(percent)
  console.log(source)

  if source is 'discharging'
    power = "Battery"
    icon = 'bat'
  else if source is 'charged'
    power = 'Charged'
    icon = 'charge'
  else
    power = 'Charging'
    icon = 'charge'

  wave = switch
    when percent <= 20 then '20'
    when 20 < percent <= 35 then '35'
    when 35 < percent <= 50 then '50'
    when 50 < percent <= 90 then '80'
    when 90 < percent < 100 then '90'
    when percent == 100 then '100'

  $('#batt').html("""
    <div id="circle-battery" class="wave#{wave}">
      <p>#{percent}%</p>
      <p class="capt">#{power}</p>
      <img src="circular-liquid-battery.widget/#{icon}.png" width="30" />
      </div>
    <div id="counter" class="waveb#{wave}"></div>
  """)

style: """
  top: 300px
  left: 200px
"""
