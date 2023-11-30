module OneTimePadController

using GenieFramework, Genie.Renderer.Html, Genie.Requests, Genie.Responses
@genietools

plaintxt = nothing
hex = nothing
text = nothing
key = nothing
ciphertxt = nothing

function ui()
    html(:onetimepad, :index)
end

function ui_post_showhex()
    newtext = params(:alphabet, nothing)
    global hex = bytes2hex(Vector{UInt8}(newtext))
    Responses.setheaders(Dict("HX-Trigger" => "onetimepadShowhex"))
end

function ui_showhex()
    hex == "" ? "..." : hex
end

function ui_post_showtext()
    newhex = params(:alphabet, nothing)
    global text = String(hex2bytes(newhex))
    Responses.setheaders(Dict("HX-Trigger" => "onetimepadShowtext"))
end

function ui_showtext()
    text == "" ? "..." : text
end

function ui_post_key()
    newkey = params(:key, nothing)
    global key = hex2bytes(newkey)
    Responses.setheaders(Dict("HX-Trigger" => "onetimepadKey"))
end

function ui_key()
    tmp = bytes2hex(key)
    isempty(tmp) ? "..." : tmp
end

function ui_post_randkey()
    newlen = parse(Int, params(:randkey, 0))
    if newlen > 0
        global key = rand(UInt8, newlen)
    end
    Responses.setheaders(Dict("HX-Trigger" => "onetimepadRandKey"))
end

function ui_randkey()
    bytes2hex(key)
end

function ui_post_enc()
    global plaintxt = hex2bytes(params(:plaintxt, nothing))
    Responses.setheaders(Dict("HX-Trigger" => "onetimepadEncrypt"))
end

function ui_enc()
    encrypt(key, plaintxt) |> bytes2hex
end

function ui_post_dec()
    global ciphertxt = hex2bytes(params(:ciphertxt, nothing))
    Responses.setheaders(Dict("HX-Trigger" => "onetimepadDecrypt"))
end

function ui_dec()
    decrypt(key, ciphertxt) |> bytes2hex
end

function encrypt(key::Vector{UInt8}, message::Vector{UInt8})
    map((p,k) -> xor(p, k) , message, key)
end

function decrypt(key::Vector{UInt8}, ciphertext::Vector{UInt8})
    map((c,k) -> xor(c, k) , ciphertext, key)
end

end
