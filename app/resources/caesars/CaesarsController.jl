module CaesarsController

using GenieFramework, Genie.Renderer.Html, Genie.Requests, Genie.Responses
@genietools

function ui()
    html(:caesars, :index)
    # html(Renderer.filepath("app/resources/caesars/views/index.jl.html"))    
end

plaintxt = nothing
keynum = nothing
key = nothing
keyinv = nothing
ciphertxt = nothing
alphabet = "ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩ "

function ui_post()
    global plaintxt = params(:plaintxt, nothing)
    global ciphertxt = params(:ciphertxt, nothing)
    if isnothing(plaintxt)
        Responses.setheaders(Dict("HX-Trigger" => "caesarDecrypt"))
    else
        Responses.setheaders(Dict("HX-Trigger" => "caesarEncrypt"))
    end
end

function ui_post_key()
    newkey = parse(Int, params(:key, nothing))    
    global keynum = newkey
    tmp = String(circshift(collect(alphabet), -keynum))
    global key = Dict{Char, Char}(zip(alphabet, tmp))
    global keyinv = Dict{Char, Char}(zip(tmp, alphabet))
    Responses.setheaders(Dict("HX-Trigger" => "caesarKey"))
end

function ui_key()
    string(keynum)
end

function ui_post_alpha()
    newalpha = params(:alphabet, nothing)
    global alphabet = newalpha
    Responses.setheaders(Dict("HX-Trigger" => "caesarAlphabet"))
end

function ui_alpha()
    isempty(alphabet) ? "..." : alphabet
end

function ui_enc()
    encrypt(key, plaintxt)
end

function ui_dec()
    decrypt(keyinv, ciphertxt)
end
    
function encrypt(key::Dict{Char, Char}, message::String)
    map(c -> key[c], message)
end

function decrypt(key::Dict{Char, Char}, ciphertext::String)
    map(c -> key[c], ciphertext)
end

end
