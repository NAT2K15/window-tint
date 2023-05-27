config = {
    command = "tint",
    windowsTints = {
        [-1] = "None",
        [0] = "None",
        [1] = "Pure Black",
        [2] = "Dark Smoke",
        [3] = "Light Smoke",
        [4] = "Stock",
        [5] = "Limo",
        [6] = "Green"
    },
    useFramework = {
        enabled = true,
        checkPerm = function(id)
            local Framework = exports["framework"]:getClientFunctions()
            local player = Framework.getPlayer(Framework.serverId)
            if(player.level ~= 'civ_level' or player.admin) then
                return true
            end
            return false
        end
    }
}