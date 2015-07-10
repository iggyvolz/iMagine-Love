local command=""
local response="Welcome to iMagine development!\nFor help and credits, type help then press enter."
love.filesystem.write("response",response)
local utf8 = require("utf8")
local smallfont=love.graphics.newFont(16)
local bigfont=love.graphics.newFont(30)
local http = require("socket.http")
local json = require("json")
love.math.setRandomSeed(os.time())
love.math.random()
local uid
if love.filesystem.read("uid") then
  uid=love.filesystem.read("uid")
else
  uid = love.math.random(10000000)
  love.filesystem.write("uid",uid)
end
function love.load()
  love.keyboard.setKeyRepeat(true)
end

function love.textinput(t)
  command = command .. t
end

function love.keypressed(key)
  if key == "backspace" then
    local byteoffset = utf8.offset(command, -1)
    if byteoffset then
      command = string.sub(command, 1, byteoffset - 1)
    end
  end
  if key == "return" then
    if command=="help" then
      love.system.openURL("http://iggyvolz.github.io/iMagine/help.html")
      return
    end
    if command=="reset" then
      response="Welcome to iMagine development!\nFor help and credits, type help then press enter."
      love.filesystem.write("response",response)
      uid = love.math.random(10000000)
      love.filesystem.write("uid",uid)
      return
    end
    response=response.."\n>"..command
    local a,b=http.request("http://i.magine.tk/head.php?command="..command.."&uid="..uid)
    if a then
      local f=json:decode(a)
      response=response.."\n"..f.response
      love.filesystem.write("response",response)
    else
      print(b)
    end
    command=""
  end
end

function love.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.rectangle("fill",0,love.graphics.getHeight()*0.9,love.graphics.getWidth(),love.graphics.getHeight()*0.1)
  love.graphics.setFont(smallfont)
  love.graphics.printf(response, 0, 0, love.graphics.getWidth())
  love.graphics.setColor(0,0,0)
  love.graphics.setFont(bigfont)
  love.graphics.printf(command, 0, love.graphics.getHeight()*0.92, love.graphics.getWidth())
end
