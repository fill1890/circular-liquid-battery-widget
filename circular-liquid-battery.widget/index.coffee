command: "pmset -g batt | grep \"%\" | awk 'BEGINN { FS = \";\" };{ print $3,$2 }' | sed -e 's/-I/I/' -e 's/-0//' -e 's/;//' -e 's/;//'"

refreshFrequency: 20000

render: () ->
  $('head').append('''
      <link rel="stylesheet" href="circular-liquid-battery.widget/cb.css" type="text/css" /><link href="http://fonts.googleapis.com/css?family=Dosis:200,300" rel="stylesheet" type="text/css">
    ''')
  '<div id="batt"></div>'

update: (output) ->
  arr = output.split(' ')
  percent = arr[1].split('%')
  a = arr[0]
  power = ""
  image = ""
  percentage = ""
  percentagebg = ""

  if a is 'discharging'
    power = "Battery"
    image = '<img src="circular-liquid-battery.widget/bat.png" width="30px">'
  else
    power = 'Charging'
    image = '<img src="circular-liquid-battery.widget/charge.png" width="30px">'

  if percent[0] <= 20
    percentage = 'wave20'
    percentagebg = 'waveb20'
  else if 20 < percent[0] < 35
    percentage = "wave35"
    percentagebg = "waveb35"
  else if 20 < percent[0] < 50
    percentage = "wave50"
    percentagebg = "wave50"
  else if 50 < percent[0] < 80
    percentage = "wave80"
    percentagebg = "waveb80"
  else if 90 < percent[0] < 100
    percentage = "wave90"
    percentagebg = "waveb90"
  else if percent[0] == 100
    percentage = "wave100"
    percentagebg = "waveb100"
    power = "Charged"

  $('#batt').html("""
    <div id="circle-battery" class="#{percentage}">
      <p>#{percent[0]}%</p>
      <p class="capt">#{power}</p>
      #{image}
      </div>
    <div id="counter" class="#{percentagebg}"></div>
  """)

style: """
  top: 300px
  left: 200px
"""
