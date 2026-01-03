local select = select
local xpcall = xpcall

---@diagnostic disable-next-line: deprecated
local unpack = table.unpack or unpack

---@diagnostic disable-next-line: redundant-parameter
if select(2, xpcall(function(a) return a end, function() end, 42)) == 42 then
    return xpcall
end

local __xpcall_function

local __xpcall_argument_1, __xpcall_argument_2
local __xpcall_argument_3, __xpcall_argument_4
local __xpcall_argument_5, __xpcall_argument_6
local __xpcall_argument_7, __xpcall_argument_8

local __xpcall_argument_tail_list = {}
local __xpcall_argument_tail_count = 0

local function call_xpcall_function_1()
    return __xpcall_function(
        __xpcall_argument_1)
end

local function call_xpcall_function_2()
    return __xpcall_function(
        __xpcall_argument_1, __xpcall_argument_2)
end

local function call_xpcall_function_3()
    return __xpcall_function(
        __xpcall_argument_1, __xpcall_argument_2,
        __xpcall_argument_3)
end

local function call_xpcall_function_4()
    return __xpcall_function(
        __xpcall_argument_1, __xpcall_argument_2,
        __xpcall_argument_3, __xpcall_argument_4)
end

local function call_xpcall_function_5()
    return __xpcall_function(
        __xpcall_argument_1, __xpcall_argument_2,
        __xpcall_argument_3, __xpcall_argument_4,
        __xpcall_argument_5)
end

local function call_xpcall_function_6()
    return __xpcall_function(
        __xpcall_argument_1, __xpcall_argument_2,
        __xpcall_argument_3, __xpcall_argument_4,
        __xpcall_argument_5, __xpcall_argument_6)
end

local function call_xpcall_function_7()
    return __xpcall_function(
        __xpcall_argument_1, __xpcall_argument_2,
        __xpcall_argument_3, __xpcall_argument_4,
        __xpcall_argument_5, __xpcall_argument_6,
        __xpcall_argument_7)
end

local function call_xpcall_function_8()
    return __xpcall_function(
        __xpcall_argument_1, __xpcall_argument_2,
        __xpcall_argument_3, __xpcall_argument_4,
        __xpcall_argument_5, __xpcall_argument_6,
        __xpcall_argument_7, __xpcall_argument_8)
end

local function call_xpcall_function_N()
    return __xpcall_function(
        __xpcall_argument_1, __xpcall_argument_2,
        __xpcall_argument_3, __xpcall_argument_4,
        __xpcall_argument_5, __xpcall_argument_6,
        __xpcall_argument_7, __xpcall_argument_8,
        unpack(__xpcall_argument_tail_list, 1, __xpcall_argument_tail_count))
end

---@param f function
---@param e function
---@param ... any
---@return boolean success
---@return any ... results
return function(f, e, ...)
    local argument_count = select('#', ...)

    if argument_count == 0 then
        return xpcall(f, e)
    end

    __xpcall_function = f

    if argument_count <= 8 then
        if argument_count <= 4 then
            if argument_count <= 2 then
                if argument_count <= 1 then
                    __xpcall_argument_1 = ...
                    return xpcall(call_xpcall_function_1, e)
                else
                    __xpcall_argument_1, __xpcall_argument_2 = ...
                    return xpcall(call_xpcall_function_2, e)
                end
            else
                if argument_count <= 3 then
                    __xpcall_argument_1, __xpcall_argument_2,
                    __xpcall_argument_3 = ...
                    return xpcall(call_xpcall_function_3, e)
                else
                    __xpcall_argument_1, __xpcall_argument_2,
                    __xpcall_argument_3, __xpcall_argument_4 = ...
                    return xpcall(call_xpcall_function_4, e)
                end
            end
        else
            if argument_count <= 6 then
                if argument_count <= 5 then
                    __xpcall_argument_1, __xpcall_argument_2,
                    __xpcall_argument_3, __xpcall_argument_4,
                    __xpcall_argument_5 = ...
                    return xpcall(call_xpcall_function_5, e)
                else
                    __xpcall_argument_1, __xpcall_argument_2,
                    __xpcall_argument_3, __xpcall_argument_4,
                    __xpcall_argument_5, __xpcall_argument_6 = ...
                    return xpcall(call_xpcall_function_6, e)
                end
            else
                if argument_count <= 7 then
                    __xpcall_argument_1, __xpcall_argument_2,
                    __xpcall_argument_3, __xpcall_argument_4,
                    __xpcall_argument_5, __xpcall_argument_6,
                    __xpcall_argument_7 = ...
                    return xpcall(call_xpcall_function_7, e)
                else
                    __xpcall_argument_1, __xpcall_argument_2,
                    __xpcall_argument_3, __xpcall_argument_4,
                    __xpcall_argument_5, __xpcall_argument_6,
                    __xpcall_argument_7, __xpcall_argument_8 = ...
                    return xpcall(call_xpcall_function_8, e)
                end
            end
        end
    else
        __xpcall_argument_1, __xpcall_argument_2,
        __xpcall_argument_3, __xpcall_argument_4,
        __xpcall_argument_5, __xpcall_argument_6,
        __xpcall_argument_7, __xpcall_argument_8 = ...
    end

    local argument_tail_list = __xpcall_argument_tail_list
    __xpcall_argument_tail_count = argument_count - 8

    for i = 1, argument_count - 8, 8 do
        local argument_remaining = argument_count - 8 - i + 1

        if argument_remaining <= 4 then
            if argument_remaining <= 2 then
                if argument_remaining <= 1 then
                    argument_tail_list[i] = select(i + 8, ...)
                else
                    argument_tail_list[i], argument_tail_list[i + 1] = select(i + 8, ...)
                end
            else
                if argument_remaining <= 3 then
                    argument_tail_list[i], argument_tail_list[i + 1],
                    argument_tail_list[i + 2] = select(i + 8, ...)
                else
                    argument_tail_list[i], argument_tail_list[i + 1],
                    argument_tail_list[i + 2], argument_tail_list[i + 3] = select(i + 8, ...)
                end
            end
        else
            if argument_remaining <= 6 then
                if argument_remaining <= 5 then
                    argument_tail_list[i], argument_tail_list[i + 1],
                    argument_tail_list[i + 2], argument_tail_list[i + 3],
                    argument_tail_list[i + 4] = select(i + 8, ...)
                else
                    argument_tail_list[i], argument_tail_list[i + 1],
                    argument_tail_list[i + 2], argument_tail_list[i + 3],
                    argument_tail_list[i + 4], argument_tail_list[i + 5] = select(i + 8, ...)
                end
            else
                if argument_remaining <= 7 then
                    argument_tail_list[i], argument_tail_list[i + 1],
                    argument_tail_list[i + 2], argument_tail_list[i + 3],
                    argument_tail_list[i + 4], argument_tail_list[i + 5],
                    argument_tail_list[i + 6] = select(i + 8, ...)
                else
                    argument_tail_list[i], argument_tail_list[i + 1],
                    argument_tail_list[i + 2], argument_tail_list[i + 3],
                    argument_tail_list[i + 4], argument_tail_list[i + 5],
                    argument_tail_list[i + 6], argument_tail_list[i + 7] = select(i + 8, ...)
                end
            end
        end
    end

    return xpcall(call_xpcall_function_N, e)
end
