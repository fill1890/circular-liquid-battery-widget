command: "pmset -g batt | grep \"%\" | awk 'BEGINN { FS = \";\" };{ print $3,$2 }' | sed -e 's/-I/I/' -e 's/-0//' -e 's/;//' -e 's/;//'"

refreshFrequency: 20000

render: () ->
  '''
  <div id="batt">
    <canvas id="blur"></canvas>
    <div id="circle-battery" class="wave">
      <p class="percent"></p>
      <p class="capt"></p>
      <img src="" width="30" />
    </div>
    <div id="counter" class="waveb"></div>
  </div>
  '''

afterRender: (domEl) ->
  uebersicht.makeBgSlice(el) for el in $(domEl).find('#blur')

update: (output, domEl) ->
  outputParts = output.split(' ')
  percent = parseInt(outputParts[1].split('%')[0])
  source = outputParts[0]
  domEl = $(domEl)

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

  $(domEl.find('#circle-battery')[0]).addClass("wave#{wave}")
  $(domEl.find('.percent')[0]).text("#{percent}%")
  $(domEl.find('.capt')[0]).text(power)
  $(domEl.find('img')[0]).attr('src', "circular-liquid-battery.widget/#{icon}.png")
  $(domEl.find('#counter')[0]).addClass("waveb#{wave}")

style: """
  @font-face
    font-family 'Dosis'
    font-style normal
    font-weight 200
    src local('Dosis ExtraLight'), local('Dosis-ExtraLight'), url(http://fonts.gstatic.com/s/dosis/v4/zuuDDmIlQfJeEM3Uf6kkpnYhjbSpvc47ee6xR_80Hnw.woff) format('woff')

  base = 'circular-liquid-battery.widget/'
  bg-blur = 10px

  #batt
    top 300px
    left 200px
    position relative
    width 158px
    height 158px
    border-radius 50%
    overflow hidden
    box-shadow 0 0 5px 3px rgba(0, 0, 0, 0.3)


  #blur
    position absolute
    left -(bg-blur) + 4px
    top -(bg-blur) + 4px
    width 150px + 2*(bg-blur)
    height 150px + 2*(bg-blur)
    border-radius 50%
    filter blur(10px)
    z-index -1

  #counter
    position absolute
    top 2px
    left 2px
    width 154px
    height 154px
    border-radius 50%
    z-index 1

  #circle-battery
    position absolute
    left 0
    right 0
    width 150px
    height 150px
    border 4px solid white
    border-radius 50%
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
