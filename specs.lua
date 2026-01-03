local xpcall = require 'xpcall'

local N = 1000

local MIN_BENCH_SECS = 0.1
local MIN_WARMUP_SECS = 0.1

local MIN_BENCH_ITERS = 100
local MIN_WARMUP_ITERS = 100

local __table_pack = (function()
    ---@diagnostic disable-next-line: deprecated
    return table.pack or function(...)
        return { n = select('#', ...), ... }
    end
end)()

local __table_unpack = (function()
    ---@diagnostic disable-next-line: deprecated
    return table.unpack or unpack
end)()

local function E()
end

local function FV(...)
    return ...
end

local function GEN(n)
    if n == 0 then
        return
    end

    return n, GEN(n - 1)
end

local function SUM(...)
    local s = 0
    for i = 1, select('#', ...) do
        s = s + select(i, ...)
    end
    return s
end

do
    local s, r1, r2 = xpcall(function() end, function() end)
    assert(s == true and r1 == nil and r2 == nil)
end

do
    local s, r1, r2 = xpcall(function() return 42 end, function() end)
    assert(s == true and r1 == 42 and r2 == nil)
end

do
    local s, r1, r2 = xpcall(function() return 42, 'hello' end, function() end)
    assert(s == true and r1 == 42 and r2 == 'hello')
end

do
    local s, r1, r2 = xpcall(function(a) return a * 2 end, function() end, 42)
    assert(s == true and r1 == 84 and r2 == nil)
end

do
    local s, r1, r2 = xpcall(function(a, b) return a .. b end, function() end, 'hello, ', 'world!')
    assert(s == true and r1 == 'hello, world!' and r2 == nil)
end

do
    local s, r1, r2 = xpcall(function(a, b) return b, a end, function() end, 'first', 'second')
    assert(s == true and r1 == 'second' and r2 == 'first')
end

do
    for i = 0, 50 do
        assert(SUM(select(2, xpcall(FV, E, GEN(i)))) == (i * (i + 1)) / 2)
    end
end

local function describe_bench(name, loop, init, fini)
    print(string.format('| %s ... |', name))

    local state = init and __table_pack(init()) or {}

    do
        local iters = 0

        local warmup_s = os.clock()

        local success, result = pcall(function()
            repeat
                iters = iters + 1
                loop(__table_unpack(state))
            until iters >= MIN_WARMUP_ITERS and os.clock() - warmup_s > MIN_WARMUP_SECS
        end)

        if not success then
            print('|-- WARMUP FAIL: ' .. result)
            return
        end
    end

    collectgarbage('collect')
    collectgarbage('stop')

    do
        local iters = 0

        local start_s = os.clock()
        local start_kb = collectgarbage('count')

        local success, result = pcall(function()
            repeat
                iters = iters + 1
                loop(__table_unpack(state))
            until iters >= MIN_BENCH_ITERS and os.clock() - start_s > MIN_BENCH_SECS
        end)

        local finish_s = os.clock()
        local finish_kb = collectgarbage('count')

        if success then
            print(string.format('|-- PASS | us: %.2f | op/s: %.2f | kb/i: %.2f | iters: %d',
                (finish_s - start_s) * 1e6 / iters,
                iters / (finish_s - start_s),
                (finish_kb - start_kb) / iters,
                iters))
        else
            print('|-- LOOP FAIL: ' .. result)
        end
    end

    if fini then
        local success, result = pcall(function()
            fini(__table_unpack(state))
        end)

        if not success then
            print('|-- FINI FAIL: ' .. result)
        end
    end

    collectgarbage('restart')
    collectgarbage('collect')
end

for AC = 0, 16 do
    local ARGS = __table_pack(GEN(AC))

    describe_bench(string.format('xpcall | %d times with %d argument(s)', N, AC), function()
        local f, e, arg_list, arg_count = FV, E, ARGS, AC
        for _ = 1, N do
            xpcall(f, e, __table_unpack(arg_list, 1, arg_count))
        end
    end)
end
