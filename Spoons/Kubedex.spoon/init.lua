--- === Kubedex ===
---
--- Monitors pods
---
--- Download: ---

local obj={}
obj.__index = obj

-- Metadata
obj.name = "Kubedex"
obj.version = "1.0"
obj.author = "yonash janosmolnar1001@gmail.com"
obj.homepage = "https://github.com/Hammerspoon/Spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Internal function used to find our location, so we know where to load files from
local function script_path()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end

obj.spoonPath = script_path()



--command_handler = io.popen("/usr/local/bin/kubectl get pods")
--output = command_handler:read('*a')
--command_handler:close()

function obj:init()
    logger.df("Kubedex started")
    self:get_kube_pods()

    if obj.timer == nil then
        obj.timer = hs.timer.doEvery(60, function() self:get_kube_pods() end)
    else
        obj.timer:start()
    end
end

function obj:update_menu(pods)
    if menubar == nil then
        menubar = hs.menubar.new()
        local icon = hs.image.imageFromPath(obj.spoonPath .. "/k8s.png")
        icon = icon:copy():size({w=16, h=16}, false)
        menubar:setIcon(icon)
        menubar:setClickCallback(function () obj:toggle() end)
    end
    menubar:setMenu(
        {
            { title = "Start pods", fn = function () obj:start_dependency_pods() end },
            { title = "Kill pods", fn = function () obj:stop_pods() end },
            { title = "Dependency - " .. #pods - 1, menu = pods },
        }
    )
end

function obj:toggle()
    logger.df('toggled')
end

function obj:get_kube_pods()
    local function parse_output(output, error)
        if error then
            logger.df(error)
        end

        local pods = {}
        for line in output:gmatch("([^\n]*)\n?") do
            local match = line:match("(%w+)-")
            table.insert(pods, {title = match})
        end
        self:update_menu(pods)
    end

    local task = hs.task.new(self.spoonPath .. '/get_kube_pods.sh',
        function(ec, o, e) end,
        function(t, o, e)
            parse_output(o, e)
            return true
        end, {})

    local environment = task:environment()
    environment['PATH'] = environment['PATH'] .. ':/usr/local/bin/'
    task:setEnvironment(environment)
    task:start()
end

function obj:start_dependency_pods()
    local task = hs.task.new(self.spoonPath .. '/start_dep_pods.sh',
        function(c, o, e) logger.df(o) logger.df(e) end,
        function(t, o, e) logger.df(o) logger.df(e) return true end, {})

    local environment = task:environment()
    environment['PATH'] = environment['PATH'] .. ':/usr/local/bin/'
    task:setEnvironment(environment)
    task:start()
end

function obj:stop_pods()
    local task = hs.task.new(self.spoonPath .. '/stop_pods.sh',
        function(c, o, e) logger.df(o) logger.df(e) end,
        function(t, o, e) return false end, {})

    local environment = task:environment()
    environment['PATH'] = environment['PATH'] .. ':/usr/local/bin/'
    task:setEnvironment(environment)
    task:start()
end

return obj