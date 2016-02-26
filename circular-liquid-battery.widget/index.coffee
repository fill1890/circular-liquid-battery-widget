command: "pmset -g batt | grep \"%\" | awk 'BEGINN { FS = \";\" };{ print $3,$2 }' | sed -e 's/-I/I/' -e 's/-0//' -e 's/;//' -e 's/;//'"

refreshFrequency: 20000

render: () ->
  '<div id="batt"></div>'

update: (output) ->
  outputParts = output.split(' ')
  percent = parseInt(outputParts[1].split('%')[0])
  source = outputParts[0]

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
    <div id="circle-battery" class="wave wave#{wave}">
      <p>#{percent}%</p>
      <p class="capt">#{power}</p>
      <img src="circular-liquid-battery.widget/#{icon}.png" width="30" />
      </div>
    <div id="counter" class="waveb waveb#{wave}"></div>
  """)

style: """
  base = 'circular-liquid-battery.widget/'

  #batt
    top 300px
    left 200px
    position relative

  #counter
    position absolute
    top 100px
    left 100px
    width 154px
    height 154px
    border-radius 50%
    z-index 1

  #circle-battery
    position absolute
    left 100px
    right 100px
    width 150px
    height 150px
    border 4px solid white
    border-radius 50%
    box-shadow 0 0 5px 3px rgba(0, 0, 0, 0.3)
    font-family 'Dosis', sans-serif
    color white
    font-weight 200
    font-size 46px
    text-align center
    z-index 2

  #circle-battery img
    position absolute
    top 115px
    left 60px

  #circle-battery .capt
    margin-top -50px
    font-size 10px

  .wave
  .waveb
    opacity 1
    background-repeat repeat-x

  .wave
    animation wave-animation 1s infinite linear

  .waveb
    animation wave-animation 2s infinite linear

  .wave20
      background-image url(base + "r1.png")
      background-size 200px 35px

  .waveb20
      background-image url(base + "r2.png")
      background-size 200px 39px

  .wave35
      background-image url(base + "g1.png")
      background-size 200px 65px

  .waveb35
      background-image url(base + "g2.png")
      background-size 200px 69px

  .wave50
      background-image url(base + "g1.png")
      background-size 200px 105px

  .waveb50
      background-image url(base + "g2.png")
      background-size 200px 109px

  .wave80
      background-image url(base + "g1.png")
      background-size 200px 165px

  .waveb80
      background-image url(base + "g2.png")
      background-size 200px 169px

  .wave90
      background-image url(base + "g1.png")
      background-size 200px 195px

  .waveb90
      background-image url(base + "g2.png")
      background-size 200px 199px

  .wave100
      background-image url(base + "g1.png")
      background-size 200px 235px

  .waveb100
      background-image url(base + "g2.png")
      background-size 200px 235px

  @-webkit-keyframes wave-animation
      from
          background-position: 0 bottom;
      to
          background-position: 200px bottom;

"""
