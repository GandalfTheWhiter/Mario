botton_height = 64
menuAt=true
config=false


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
bottons = {}
bottonsconfig = {}

function love.load( )

music = love.audio.newSource("song/MusicMenu.mp3", "stream")

font = love.graphics.newFont(32)
--toda tabela nova tem q vim para o load
tabelaMenu( )
tabelaconfig( )

imagaMenu = love.graphics.newImage("imagens/sol.jpg")

end

function love.update( dt )
	song( )
end

function love.draw( )

	menu( )

 if not menuAt then
 	--  love.graphics.circle("fill", 300, 300, 50, 100) 
    --love.graphics.circle("fill", 300, 300, 50, 5)
	end

end
function song( )
		if menuAt then
			music:play()
			music:setLooping(true)

		elseif not menuAt and config then
			music:play()
			music:setLooping(true)

		elseif not menuAt then
			music:stop()
		end
end

function menu(  )
	
	--dentro do menu
	if menuAt then
		
		local ww = love.graphics.getWidth()
		local wh = love.graphics.getHeight()
		

		love.graphics.draw(imagaMenu,ww,wh)
		local imagH = imagaMenu:getHeight()
		local imagW = imagaMenu:getWidth()

		--faz aparece a imagem de fundo
		for i=0,ww/imagW do
			for j=0, wh/imagH do
				love.graphics.draw(imagaMenu,i* imagW,j* imagH)
			end
		end



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
		
			--cria os retangulos e bota eles centralizados
			love.graphics.setColor(color)
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

			love.graphics.setColor(255,255,255,1) --Faz voltar para branco o preto na linha 160, fazendo aparece a imagem de fundo



			curso_y = curso_y + (botton_height + margin)	
		end-- end do for
	end
	if config and not menuAt then
		menuConfig( )

	end
end
--so quer aparece 1 retangulo
function menuConfig( )

	if config then
			local ww = love.graphics.getWidth()
			local wh = love.graphics.getHeight()

			love.graphics.draw(imagaMenu,ww,wh)
			local imagH = imagaMenu:getHeight()
			local imagW = imagaMenu:getWidth()

			--faz aparece a imagem de fundo
			for i=0,ww/imagW do
				for j=0, wh/imagH do
					love.graphics.draw(imagaMenu,i* imagW,j* imagH)
				end
			end


			local botton_width= ww *(1/3)
			local margin = 16

			local total_height = (botton_height + margin) * #bottonsconfig
			local curso_y = 0



			for i, bottonsconfig in ipairs(bottonsconfig) do

				bottonsconfig.last = bottonsconfig.now
				
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
				bottonsconfig.now = love.mouse.isDown(1)
				if bottonsconfig.now and not bottonsconfig.last and hot then
						bottonsconfig.fns()
						bottonsconfig.fn()
				end
			
				--cria os retangulos e bota eles centralizados
				love.graphics.setColor(color)
				love.graphics.rectangle(
					"fill",
					bx,
					by,
					botton_width,
					botton_height
					)

				local textw = font:getWidth(bottonsconfig.text)
				local texth = font:getHeight(bottonsconfig.text)

				--cria a fonte e escreve o que dentro do retangulo o q esta na tabela bottons
				love.graphics.setColor(0, 0, 0, 1) 
				love.graphics.print(
					bottonsconfig.text, font,
					(ww * 0.5) - textw * 0.5,
					by + texth * 0.5
					)

				love.graphics.setColor(255,255,255,1)
			end --end do for
	end
end


function tabelaconfig(  )
	local click = love.audio.newSource("song/TV Off.mp3", "static")

	table.insert(bottonsconfig, newBotton(
				"Fullscreen", 
				function ( )
				
				end,
				function ( )
				
				end))
	table.insert(bottonsconfig, newBotton(
				"lua", 
				function ( )
				
				end,
				function ( )
				
				end))
	table.insert(bottonsconfig, newBotton(
				"Voltar", 
				function ( )
				click:play()
				end,
				function ( )
				menuAt=true
				config=false
				end))
end

function tabelaMenu( )

	local click = love.audio.newSource("song/TV Off.mp3", "static")

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
				menuAt=false
				config=true			
				end))

	table.insert(bottons, newBotton(
				"Exit",
				function( )
				love.event.quit(0)
				end ,
				function( )
							
				end ))
end