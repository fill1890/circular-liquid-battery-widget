command: "pmset -g batt | grep \"%\""

refreshFrequency: 20000

render: () ->
  '''
  <div id="batt">
    <canvas id="blur"></canvas>
    <div id="circle-battery" class="wave">
      <p class="percent"></p>
      <p class="capt"></p>
      <svg class="icon" viewbox="0 0 1200 1200"></svg>
    </div>
    <div id="counter" class="waveb"></div>
  </div>
  '''

afterRender: (domEl) ->
  uebersicht.makeBgSlice(el) for el in $(domEl).find('#blur')

update: (output, domEl) ->
  outputParts = output.split(';')
  outputParts[0] = outputParts[0].trim().split(' ')[1]
  outputParts = (x.trim() for x in outputParts)
  index0 = parseInt(outputParts[0])

  if 0 <= index0 <= 100
    percent = index0
    source = outputParts[1]
  else
    percent = parseInt(outputParts[1])
    source = outputParts[0]

  domEl = $(domEl)

  if source is 'discharging'
    power = "Battery"
    icon = @batteryImage
  else if source is 'charged'
    power = 'Charged'
    icon = @chargeImage
  else
    power = 'Charging'
    icon = @chargeImage

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
  domEl.find('.icon')[0].innerHTML = icon
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

  #circle-battery .icon
    position absolute
    top 115px
    left 60px
    width 30px
    height 30px
    fill white

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

chargeImage: '<polygon points="808,0 234,699 566,699 393,1200 969,501 636,501 "/>'
batteryImage: '''
<path d="M1013,250c57.1,0,109.1,52.2,109.1,104.5v109.7h67.5c5.2,0,10.4,5.2,10.4,10.4v250.7
	c0,5.2-5.2,10.4-10.4,10.4h-67.5v109.7c0,52.2-51.9,104.5-109.1,104.5H103.9C51.9,950,0,897.8,0,845.5v-491
	C0,302.2,51.9,250,103.9,250H1013z M103.9,302.2c-26,0-51.9,26.1-51.9,52.2v491c0,26.1,26,52.2,51.9,52.2H1013
	c31.2,0,57.1-26.1,57.1-52.2l0-156.7c0-5.2,5.2-10.4,10.4-10.4h62.3V521.6h-62.3c-5.2,0-10.4-5.2-10.4-10.4l0-156.7
	c0-26.1-26-52.2-57.1-52.2H103.9z"/>
<path d="M103.9,814.2c0,47,62.3,47,62.3,0V385.8c0-47-62.3-47-62.3,0V814.2z"/>
<path d="M213,814.2c0,47,62.3,47,62.3,0V385.8c0-47-62.3-47-62.3,0V814.2z"/>
<path d="M316.9,814.2c0,47,62.3,47,62.3,0V385.8c0-47-62.3-47-62.3,0V814.2z"/>
<path d="M426,814.2c0,47,62.3,47,62.3,0V385.8c0-47-62.3-47-62.3,0V814.2z"/>
<path d="M529.2,811.6c0,47,62.3,47,62.3,0V383.2c0-47-62.3-47-62.3,0V811.6z"/>
<path d="M638.3,811.6c0,47,62.3,47,62.3,0V383.2c0-47-62.3-47-62.3,0V811.6z"/>
<path d="M742.9,814.2c0,47,62.3,47,62.3,0V385.8c0-47-62.3-47-62.3,0V814.2z"/>
<path d="M851.9,814.2c0,47,62.3,47,62.3,0V385.8c0-47-62.3-47-62.3,0V814.2z"/>
<path d="M955.8,814.2c0,47,62.3,47,62.3,0V385.8c0-47-62.3-47-62.3,0V814.2z"/>
'''
