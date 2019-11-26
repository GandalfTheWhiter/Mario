require "scr/menu"



math.randomseed(os.time())
--variaveis bolleanas
menuAt=true
config=false
full=false
proximacarta=false
--variaveis bolleanas

--tabelas
bottons = {}
bottonsconfig = {}
carta = {}
centro={}
tdcartas={a=1,dois=2,tres=3,quatro=4,cinco=5,seis=6,sete=7,oito=8,nove=9,dez=10,J=11,Q=12,K=13}
--tabelas

font = nil

function newBotton( text, fns, fn)
	return {
		text = text,
		fn = fn,
		fns=fns,
		now=false,
		last=false

	}	
end
function cartasAleatorias( )
	cartaMao1=math.random(1,13)
	cartaMao2=math.random(1,13)
	cartaMao3=math.random(1,13)

end

function love.load( )

	--if full then
		--love.window.setFullscreen(fullscreen)
	--end
	cartasAleatorias()
	music = love.audio.newSource("song/MusicMenu.mp3", "stream")

	font = love.graphics.newFont(32)
	--toda tabela nova tem q vim para o load
	tdcartas={a=1,dois=2,tres=3,quatro=4,cinco=5,seis=6,sete=7,oito=8,nove=9,dez=10,J=11,Q=12,K=13}
	tabelaMenu( )
	tabelaconfig( )
	tabela_cartas_na_mao( )
	tabela_centro_da_mesa( )

	imagaMenu = love.graphics.newImage("imagens/sol.jpg")


end

function love.update( dt )
	--song( )
	if proximacarta then
		table.insert(carta, newBotton(
				" ".. cartaMao2.. " ",
				function( )
				
				end ,
				function( )
							
				end))
	end

end

function love.draw( )
	imagemDeFundoMenu( )
	menu( )
	if not menuAt and not config then
		posiçaoDasCartasX()
		CentroDaMesa()
	end

end
function song( )
		if menuAt then
			music:play()
			music:setLooping(true)

		elseif not menuAt and config then
			music:play()
			music:setLooping(true)

		--elseif not menuAt then
			--music:stop()
		end
end

function posiçaoDasCartasX()
	local ww = love.graphics.getWidth()
	local wh = love.graphics.getHeight()
	

	--altura do retangulo
	local botton_height = ww *(1/6)
	--largura do retangulo
	local botton_width= ww *(1/6)
	--margem entre os retangulos
	local margin = 16
	--bota quantas carta tiverem na tabela uma do lado da outra
	local total_width = (botton_width + margin) * #carta
	local curso_y = 0


	for i , carta in ipairs (carta) do
		carta.now=carta.last

		local bx = (ww * 0.5) - (total_width*0.5) + curso_y
		local by = wh  - botton_height

		local color = {0.4, 0.4, 0.5, 1.0}

		local mx, my = love.mouse.getPosition()
			--faz com que quando o mouse estive encima dos retangulos ele mude de cor
		local hot = mx > bx and mx < bx + botton_width and
						my > by and my < by + botton_height	
		if hot then
			color={0.8, 0.8, 0.9, 1.0}
		end

		carta.now=love.mouse.isDown(1)
		if carta.now and not carta.last and hot then
			carta.fns()
			carta.fn()
		end

		love.graphics.setColor(color)
			love.graphics.rectangle(
				"fill",
				bx,
				by,
				botton_width,
				botton_height
				)
			local textw = font:getWidth(carta.text)
			local texth = font:getHeight(carta.text)

			--cria a fonte e escreve o que dentro do retangulo o q esta na tabela bottons
			love.graphics.setColor(0, 0, 0, 1) 
			love.graphics.print(
				carta.text, font,
				bx + textw * 0.5,
				(wh) - texth * 0.5 - 40
				)


			love.graphics.setColor(255,255,255,1)


		curso_y = curso_y + (botton_width + margin)
	end
end



function tabela_cartas_na_mao( ) 
	local click = love.audio.newSource("song/TV Off.mp3", "static")

table.insert(carta, newBotton(
			" ".. cartaMao1.. " ",
			function( )
			proximacarta=true
				--if cartaMao1==tdcartas.a then
				--	click:play()
				--end	
			end ,
			function( )
				if cartaMao1==tdcartas.a then
					--imagemDeAs	
				end
			end))
	
		table.insert(carta, newBotton(
				" ".. cartaMao2.. " ",
				function( )
				
				end ,
				function( )
							
				end))
		table.insert(carta, newBotton(
				" ".. cartaMao3.. " ",
				function( )
				
				end ,
				function( )
							
				end))
	
end

function tabela_centro_da_mesa( )

	messa1=math.random(os.time())
	messa2=math.random(os.time())
	messa3=math.random(os.time())	
	messa4=math.random(os.time())


table.insert(centro, newBotton(
			"",
			function( )
			
			end ,
			function( )
						
			end))
table.insert(centro, newBotton(
			"",
			function( )
			
			end ,
			function( )
						
			end))
table.insert(centro, newBotton(
			"",
			function( )
			
			end ,
			function( )
						
			end))
table.insert(centro, newBotton(
			"Carta",
			function( )
			
			end ,
			function( )

			end))	
end

function CentroDaMesa( )
	local ww = love.graphics.getWidth()
	local wh = love.graphics.getHeight()
	
	--altura do retangulo
	local botton_height = ww *(1/6)
	--largura do retangulo
	local botton_width= ww *(1/10)
	--margem entre os retangulos
	local margin = 16
	--bota quantas carta tiverem na tabela uma do lado da outra
	local total_width = (botton_width + margin) * #carta
	local curso_y = 0


	for i , centro in ipairs (centro) do
			local bx = (ww * 0.5) - (total_width * 0.5) - curso_y + 126
			local by = (wh* 0.5)  - botton_height

			local color = {0.4, 0.4, 0.5, 1.0}

		love.graphics.setColor(color)
			love.graphics.rectangle(
				"fill",
				bx,
				by,
				botton_width,
				botton_height
				)


			love.graphics.setColor(255,255,255,1)

		curso_y = curso_y + (botton_width + margin)
	end
end
