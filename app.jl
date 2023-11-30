module CryptoApp
using GenieFramework
@genietools

include("app/resources/caesars/CaesarsController.jl")
include("app/resources/monoalphabetic/MonoalphabeticController.jl")
include("app/resources/onetimepad/OneTimePadController.jl")

using .CaesarsController
using .MonoalphabeticController
using .OneTimePadController

route("/") do
    serve_static_file("welcome.html")
end

# Caesar's cipher

route("/caesar", CaesarsController.ui, method = GET)
route("/caesar", CaesarsController.ui_post, method = POST)
route("/caesar/alphabet", CaesarsController.ui_alpha, method = GET)
route("/caesar/alphabet", CaesarsController.ui_post_alpha, method = POST)
route("/caesar/key", CaesarsController.ui_key, method = GET)
route("/caesar/key", CaesarsController.ui_post_key, method = POST)
route("/caesar/enc", CaesarsController.ui_enc, method = GET)
route("/caesar/dec", CaesarsController.ui_dec, method = GET)

# Monoalphabetic substitution

route("/monoalphabetic", MonoalphabeticController.ui, method = GET)
route("/monoalphabetic/alphabet", MonoalphabeticController.ui_alpha, method = GET)
route("/monoalphabetic/alphabet", MonoalphabeticController.ui_post_alpha, method = POST) 
route("/monoalphabetic/key", MonoalphabeticController.ui_key, method = GET)
route("/monoalphabetic/key", MonoalphabeticController.ui_post_key, method = POST) 
route("/monoalphabetic/enc", MonoalphabeticController.ui_enc, method = GET)
route("/monoalphabetic/enc", MonoalphabeticController.ui_post_enc, method = POST)
route("/monoalphabetic/dec", MonoalphabeticController.ui_dec, method = GET)
route("/monoalphabetic/dec", MonoalphabeticController.ui_post_dec, method = POST)

# One time pad

route("/onetimepad", OneTimePadController.ui, method = GET)
route("/onetimepad/showhex", OneTimePadController.ui_showhex, method = GET)
route("/onetimepad/showhex", OneTimePadController.ui_post_showhex, method = POST) 
route("/onetimepad/showtext", OneTimePadController.ui_showtext, method = GET)
route("/onetimepad/showtext", OneTimePadController.ui_post_showtext, method = POST) 
route("/onetimepad/key", OneTimePadController.ui_key, method = GET)
route("/onetimepad/key", OneTimePadController.ui_post_key, method = POST)
route("/onetimepad/randkey", OneTimePadController.ui_randkey, method = GET)
route("/onetimepad/randkey", OneTimePadController.ui_post_randkey, method = POST) 
route("/onetimepad/enc", OneTimePadController.ui_enc, method = GET)
route("/onetimepad/enc", OneTimePadController.ui_post_enc, method = POST)
route("/onetimepad/dec", OneTimePadController.ui_dec, method = GET)
route("/onetimepad/dec", OneTimePadController.ui_post_dec, method = POST)


end
