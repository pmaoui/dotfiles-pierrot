local function setup()
    ps.sub("ind-sort", function(opt)
        local cwd = cx.active.current.cwd
        
        if cwd:ends_with("english-tutor") then
            -- Set to modification time, reverse (newest first), directories first
            opt.by, opt.reverse, opt.dir_first = "mtime", true, true
        else
            -- Default for all other directories
            opt.by, opt.reverse, opt.dir_first = "alphabetical", false, true
        end
        
        return opt
    end)
end

return { setup = setup }
