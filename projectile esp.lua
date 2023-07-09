local Proj_name = true
local Proj_dist = true
local Proj_box = true
local Proj_color = { 255, 92, 92, 255 }

--======================================================================================================================--
local font = draw.CreateFont( "Tahoma", 12, 800, FONTFLAG_OUTLINE  )
local function proj_esp()

    if entities.GetLocalPlayer() ~= nil then

        draw.SetFont( font )
             
        local function draw_esp(entity_name)
            local esp_name
            if entity_name == "CTFStunBall" then 
                esp_name = "Ball"
            elseif entity_name == "CTFBall_Ornament" then 
                esp_name = "Ornament"
            elseif entity_name == "CTFProjectile_Cleaver" then
                esp_name = "Cleaver"
            elseif entity_name == "CTFProjectile_JarMilk" then
                esp_name = "Milk"
            elseif entity_name == "CTFProjectile_Rocket" then
                esp_name = "Rocket"
            elseif entity_name == "CTFProjectile_SentryRocket" then 
                esp_name = "Rocket"
            elseif entity_name == "CTFProjectile_EnergyBall" then
                esp_name = "Energy Ball"
            elseif entity_name == "CTFProjectile_EnergyRing" then
                esp_name = "Energy Ring"
            elseif entity_name == "CTFFlameManager" then
                esp_name = "Flames"
            elseif entity_name == "CTFProjectile_BallOfFire" then
                esp_name = "Fire"
            elseif entity_name == "CTFProjectile_Flare" then
                esp_name = "Flare"
            elseif entity_name == "CTFGrenadePipebombProjectile" then
                esp_name = "Sticky"
            elseif entity_name == "CTFProjectile_Arrow" then
                esp_name = "Arrow"
            elseif entity_name == "CTFProjectile_MechanicalArmOrb" then
                esp_name = "Orb"
            elseif entity_name == "CTFProjectile_HealingBolt" then
                esp_name = "Healing Arrow"
            elseif entity_name == "CTFProjectile_Jar" then
                esp_name = "Jarate"
            elseif entity_name == "CTFProjectile_JarGas" then
                esp_name = "Gas Passer"
            end

            local entity = entities.FindByClass( entity_name )
            for i, projectile in pairs(entity) do 
                local projectile_screen = client.WorldToScreen( projectile:GetAbsOrigin() )
                if projectile_screen ~= nil and projectile:IsDormant() == false and projectile:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() then  -- and projectile:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber()
                    draw.Color(table.unpack(Proj_color))
                    if Proj_box == true then -- pasted 3d box B)
                        local hitboxes = projectile:HitboxSurroundingBox()
                        local min = hitboxes[1]
                        local max = hitboxes[2]
                        -- Define the eight vertices of the box
                        local vertices = {
                            Vector3(min.x, min.y, min.z),
                            Vector3(min.x, max.y, min.z),
                            Vector3(max.x, max.y, min.z),
                            Vector3(max.x, min.y, min.z),
                            Vector3(min.x, min.y, max.z),
                            Vector3(min.x, max.y, max.z),
                            Vector3(max.x, max.y, max.z),
                            Vector3(max.x, min.y, max.z)
                        }
                        -- Convert vertices to screen space
                        local screenVertices = {}
                        for j, vertex in ipairs(vertices) do
                            local screenPos = client.WorldToScreen(vertex)
                            if screenPos ~= nil then
                                screenVertices[j] = {x = screenPos[1], y = screenPos[2]}
                            end
                        end
                        -- Draw the 3D box
                        draw.Color(table.unpack(Proj_color))
                        for j = 1, 4 do
                            local vertex1 = screenVertices[j]
                            local vertex2 = screenVertices[j % 4 + 1]
                            local vertex3 = screenVertices[j + 4]
                            local vertex4 = screenVertices[(j + 4) % 4 + 5]
                            if vertex1 ~= nil and vertex2 ~= nil and vertex3 ~= nil and vertex4 ~= nil then
                                draw.Line(vertex1.x, vertex1.y, vertex2.x, vertex2.y)
                                draw.Line(vertex3.x, vertex3.y, vertex4.x, vertex4.y)
                            end
                        end
                        for j = 1, 4 do
                            local vertex1 = screenVertices[j]
                            local vertex2 = screenVertices[j + 4]
                            if vertex1 ~= nil and vertex2 ~= nil then
                                draw.Line(vertex1.x, vertex1.y, vertex2.x, vertex2.y)
                            end
                        end                 
                    end
                    if Proj_name == true then
                        local projectile_length, projectile_height = draw.GetTextSize(esp_name)
                        draw.Text( projectile_screen[1] - math.floor(projectile_length / 2), projectile_screen[2] - 20, esp_name )
                    end
                    if Proj_dist == true then
                        local projectile_dist = vector.Distance( entities.GetLocalPlayer():GetAbsOrigin(), projectile:GetAbsOrigin() )
                        projectile_dist = math.floor(projectile_dist)
                        local projectile_dist_length, projectile_dist_height = draw.GetTextSize("[".. projectile_dist.. "Hu]")
                        draw.Text( projectile_screen[1] - math.floor(projectile_dist_length / 2), projectile_screen[2] + 7, "[".. projectile_dist.. "Hu]" )
                    end
                end
            end
        end

        --[[ script for getting all of the entities
        for i = 1, 8192 do
            local entity = entities.GetByIndex( i )
            if entity then
                print("Index: ".. i.. " | Entity name: ".. entity:GetClass() )
            end
        end
        ]]

        -- all projectiles that i found

        draw_esp("CTFStunBall") -- sandman
        draw_esp("CTFBall_Ornament") -- wrap assasin
        draw_esp("CTFProjectile_Cleaver") -- cleaver
        draw_esp("CTFProjectile_JarMilk") -- milk
        draw_esp("CTFProjectile_Rocket") -- rocket
        draw_esp("CTFProjectile_EnergyBall") -- cow mangler
        draw_esp("CTFProjectile_EnergyRing") -- bison, pomson
        -- draw_esp("CTFFlameManager") -- flamethrower
        draw_esp("CTFProjectile_BallOfFire") -- dragons fury
        draw_esp("CTFProjectile_Flare") -- all flareguns
        draw_esp("CTFGrenadePipebombProjectile") -- stickyies and pipes
        draw_esp("CTFProjectile_Arrow") -- bows, rescue ranger
        draw_esp("CTFProjectile_MechanicalArmOrb") -- short circuit
        draw_esp("CTFProjectile_HealingBolt") -- crusaders crossbow
        draw_esp("CTFProjectile_Jar") -- jarate
        draw_esp("CTFProjectile_JarGas") -- gas passer
        draw_esp("CTFProjectile_SentryRocket") -- sentry rocket
     
    end
end
callbacks.Register( "Draw", "proj_esp", proj_esp )