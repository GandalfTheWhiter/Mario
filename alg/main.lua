botton_height = 64
menuAt=true



function newBotton( text, fns, fn)
	return {
		text = text,
		fn = fn,
		fns=fns,
		now=false,
		last=false

	}	
end
local font = nil
local bottons = {}

function love.load( )


music = love.audio.newSource("song/pirata.mp3", "stream")



font = love.graphics.newFont(32)

tabelaMenu( )


imagaMenu = love.graphics.newImage("imagens/sol.jpg")


end

function love.update( dt )
	song( )
	--apertaBotton( )
end

function love.draw( )

menu( )
 if not menuAt then
 	  love.graphics.circle("fill", 300, 300, 50, 100) 
    love.graphics.circle("fill", 300, 300, 50, 5)
	end

end
--[[
function apertaBotton( )
	

		local ww = love.graphics.getWidth()
		local wh = love.graphics.getHeight()
		local margin = 16
		local total_height = (botton_height + margin) * #bottons
		local curso_y = 0
		local botton_width= ww *(1/3)
		local ww = love.graphics.getWidth()
		local wh = love.graphics.getHeight()


			bottons.last = bottons.now
					
			local bx = (ww * 0.5) - (botton_width*0.5)
			local by = (wh * 0.5)  - (total_height * 0.5) + curso_y

			local mx, my = love.mouse.getPosition()

			local hot = mx > bx and mx < bx + botton_width and
						my > by and my < by + botton_height	

			bottons.now = love.mouse.isDown(1)
			if bottons.now and not bottons.last and hot then
						bottons.fns()
						bottons.fn()
			end
end
--]]
function song( )
		if menuAt then
				music:play()
				music:setLooping(true)
		end
		if not menuAt then
			music:stop()
		end
end

function menu(  )
	love.graphics.draw(imagaMenu,0,0)
	--dentro do menu
	if menuAt then
		love.graphics.draw(imagaMenu,0,0)

		local ww = love.graphics.getWidth()
		local wh = love.graphics.getHeight()
		

		local botton_width= ww *(1/3)
		local margin = 16

		local total_height = (botton_height + margin) * #bottons
		local curso_y = 0

		

		for i, bottons in ipairs(bottons) do

			bottons.last = bottons.now
			
			local bx = (ww * 0.5) - (botton_width*0.5)
			local by = (wh * 0.5)  - (total_height * 0.5) + curso_y

			local color = {0.4, 0.4, 0.5, 1.0}

			local mx, my = love.mouse.getPosition()
			--faz com que quando o mouse estive encima dos retangulos ele mude de cor
			local hot = mx > bx and mx < bx + botton_width and
						my > by and my < by + botton_height	
			if hot then
				color={0.8, 0.8, 0.9, 1.0}
			end

			--faz com quer quando clico com o botao direito a funçao q esta na funçao newBotton execute de acordado com a tabela bottons
			bottons.now = love.mouse.isDown(1)
			if bottons.now and not bottons.last and hot then
						bottons.fns()
						bottons.fn()
			end
			
			love.graphics.setColor(unpack(color))
			--cria os retangulos e bota eles centralizados
			love.graphics.rectangle(
				"fill",
				bx,
				by,
				botton_width,
				botton_height
				)
			local textw = font:getWidth(bottons.text)
			local texth = font:getHeight(bottons.text)

			--cria a fonte e escreve o que dentro do retangulo o q esta na tabela bottons
			love.graphics.setColor(0, 0, 0, 1) 
			love.graphics.print(
				bottons.text, font,
				(ww * 0.5) - textw * 0.5,
				by + texth * 0.5
				)

			curso_y = curso_y + (botton_height + margin)
		end
		--no game
	else
			  love.graphics.circle("fill", 300, 300, 50, 100) -- Draw white circle with 100 segments.

    love.graphics.circle("fill", 300, 300, 50, 5)
	end
end

function tabelaMenu( )

local click = love.audio.newSource("song/Slice.mp3", "static")

table.insert(bottons, newBotton(
			"Start Game",
			function( )
			click:play() 
			end,
			function( )
				menuAt = false		
			end))

table.insert(bottons, newBotton(
			"Settings",
			function( )
			click:play() 			
			end,
			function( )
						
			end))

table.insert(bottons, newBotton(
			"Exit",
			function( )
			love.event.quit(0)
			end ,
			function( )
						
			end ))
end