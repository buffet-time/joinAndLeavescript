if SERVER then
	util.AddNetworkString("jl_join")
	util.AddNetworkString("jl_leave")
	hook.Add("PlayerInitialSpawn", "jl_initial", function(ply)
		local first = ply:GetPData("jl_firsttime", false)
		net.Start("jl_join")
		
		if not first then
			ply:SetPData("jl_firsttime", true)
			net.WriteString(ply:Nick() .. " has joined this server for the first time!")
			net.Broadcast()
			return
		end
		
		net.WriteString(ply:Nick() .. " has joined the game!")
		net.Broadcast()
	end)
	
	hook.Add("PlayerDisconnected", "jl_discon", function(ply)
		net.Start("jl_leave")
		net.WriteString(ply:Nick() .. " has left the game.")
		net.Broadcast()
	end)
else
	net.Receive("jl_join", function()
		chat.AddText(Color(191, 255, 0), net.ReadString())
	end)
	
	net.Receive("jl_leave", function()
		chat.AddText(Color(255, 0, 0), net.ReadString())
	end)
end
